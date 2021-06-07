NO_COLOR=$(shell tput sgr0)
GREEN=$(shell tput bold)$(shell tput setaf 2)
RED=$(shell tput bold)$(shell tput setaf 1)

DC = docker-compose
DCE = ${DC} exec

default: start configure disable_2FA clear_cache success

start:
	@echo '${GREEN}Starting Magento containers${NO_COLOR}'
	@${DC} up -d --force-recreate

configure:
	@echo '${GREEN}Configuring Magento${NO_COLOR}'
	@./wait.sh
	@${DCE} --user=www-data webserver bin/magento setup:install --base-url=http://magento2.local/ \
	  --backend-frontname="admin_panel" \
	  --db-host=db --db-name=magento2 --db-user=magento2 --db-password=magento2 \
	  --admin-firstname=Admin --admin-lastname=User --admin-email=admin@example.com \
	  --admin-user=admin@example.com --admin-password=magento2password! --language=en_GB \
	  --currency=GBP --timezone=Europe/London --use-rewrites=1 \
	  --cache-backend=redis --cache-backend-redis-server=redis --cache-backend-redis-db=1 \
	  --page-cache=redis --page-cache-redis-server=redis --page-cache-redis-db=2 \
	  --session-save=redis --session-save-redis-host=redis --session-save-redis-log-level=4 --session-save-redis-db=0 \
	  --search-engine=elasticsearch7 --elasticsearch-host=elasticsearch \
	  --elasticsearch-port=9200

disable_2FA:
	@echo '${GREEN}Disabling 2FA${NO_COLOR}'
	@${DCE} --user=www-data webserver bin/magento module:disable Magento_TwoFactorAuth

clear_cache:
	@echo '${GREEN}Clearing cache${NO_COLOR}'
	@${DCE} --user=www-data webserver bin/magento cache:flush

success:
	@echo '${GREEN}Magento configured!${NO_COLOR}'
	@echo 'Frontend: http://magento2.local'
	@echo 'GraphQL: http://magento2.local/graphql'
	@echo 'Admin: http://magento2.local/admin_panel'
	@echo 'u: admin@example.com'
	@echo 'p: magento2password!'
	@echo -e '\n${GREEN}NB: If this is your first time, run ${NO_COLOR}make host_setup${GREEN} to configure local DNS${NO_COLOR}'

host_setup:
	@echo '${GREEN}Configuring local DNS (password required)${NO_COLOR}'
	@sudo -- sh -c 'grep -q "magento2.local" /etc/hosts && echo "Host already configured" || echo "# Local Magento DNS\n127.0.0.1 magento2.local" >> /etc/hosts'

rm:
	@echo '${GREEN}Removing container and cleaning up${NO_COLOR}'
	@${DC} down -v --remove-orphans
	@docker system prune --volumes -f
