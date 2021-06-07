# Local Magento 2.4 API Development

This project gives Mac/Linux users a local Magento 2.4 instance with some dummy data
to develop against.

After cloning this repository, ensuring Docker is running, you can simply run:

```bash
$ make
```

After doing so, and waiting for a not inconsiderable amount of time, you will see a
message along the lines of:

```bash
Magento configured!
Frontend: http://magento2.local
GraphQL: http://magento2.local/graphql
Admin: http://magento2.local/admin_panel
u: admin@example.com
p: magento2password!

NB: If this is your first time, run make host_setup to configure local DNS
```

These URLs require a local DNS entry:

```text
127.0.0.1 magento2.local
```

You can manually edit your `/etc/hosts` file to add that, or run the following to
have a script do it for you:

```bash
$ make host_setup
```

## GraphQL

Magento comes with GraphQL APIs out of the box. For more information on 
available queries, mutations and general concepts, 
visit [their documentation](https://devdocs.magento.com/guides/v2.4/graphql/index.html).

## Clean Up

This instance is immutable and to throw it all away and start again, run:

```bash
make rm
```

## Credits

Uses a great [container image](https://hub.docker.com/r/narayanvarma/magento2) 
by [Narayan Varma](https://github.com/narayanvarma)
