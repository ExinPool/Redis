#!/bin/bash

cd /data/monitor/exinpool/Redis/mem
nohup bash redis_mem_monitor_lark.sh >> redis_mem_monitor.log &
