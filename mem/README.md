# Redis Mem monitor

> Redis Mem monitor tools.

[![Build Status](http://img.shields.io/travis/badges/badgerbadgerbadger.svg?style=flat-square)](https://travis-ci.org/badges/badgerbadgerbadger) [![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

## Table of Contents

- [Installation](#installation)
- [Features](#features)
- [Contributing](#contributing)
- [Team](#team)
- [FAQ](#faq)
- [Support](#support)
- [License](#license)

## Installation

- Ubuntu 16.04.1 LTS
- Written in bash

### Clone

- Clone this repo to your server using:

``` bash
sudo mkdir -p /data/monitor/exinpool
cd /data/monitor/exinpool
sudo git clone https://github.com/ExinPool/Redis
```

### Setup

Search `7000000012` in [Mixin Messenger](https://mixin.one/messenger) and add **[Webhook](https://mixin.one/codes/4d792128-1db8-4baf-8d90-d0d8189a4a7e)** as contact.

Invite Webhook and somebody who want to receive monitor message to a small group in Mixin Messenger. Open Webhook in the group, you can see the access token.

> Note: The access token is only available for the owner of the group.

Copy `config.cfg.defaults` to `config.cfg` and change some varibles like this in the `config.cfg`.

``` bash
SERVICE=Redis
MEM_NUM=80
REDIS_CLI=""
HOST=""
SLEEP_NUM=60
LOG_FILE=redis_mem_monitor.log
WEBHOOK_URL=https://webhook.exinwork.com/api/send?access_token
ACCESS_TOKEN=YOUR_ACCESS_TOKEN
LARK_WEBHOOK_URL=https://open.larksuite.com/open-apis/bot/v2/hook/
```

Add crontab like this in the server.

``` bash
# Redis Mem monitor
*/30 * * * * cd /data/monitor/exinpool/Redis/mem && bash redis_mem_monitor.sh >> redis_mem_monitor.log &

# Redis Mem monitor
*/30 * * * * cd /data/monitor/exinpool/Redis/mem && bash redis_mem_monitor_lark.sh >> redis_mem_monitor.log &
```

The crontab will run every minute then you can check the log in the `redis_mem_monitor.log`.

## Features

- Monitor Redis memory
- Send alarm message when disk is abnormal
- Send alarm message to Mixin Messenger via Webhook
- Send alarm message to Lark via Lark API

## Contributing

To be continued.

## Team

@ExinPool

## FAQ

To be continued.

## Support

Reach out to us at one of the following places!

- Website at <a href="https://exinpool.com" target="_blank">`exinpool.com`</a>
- Twitter at <a href="http://twitter.com/ExinPool" target="_blank">`@ExinPool`</a>
- Email at `robin@exin.one`

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](https://opensource.org/licenses/mit-license.php)**
- Copyright 2019 © <a href="https://exinpool.com" target="_blank">ExinPool</a>.