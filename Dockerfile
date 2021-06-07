FROM narayanvarma/magento2:2.4.2
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    netcat \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
