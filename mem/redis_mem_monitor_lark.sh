#!/bin/bash
#
# Copyright © 2020 ExinPool <robin@exin.one>
#
# Distributed under terms of the MIT license.
#
# Desc: Mem monitor script.
# User: Robin@ExinPool
# Date: 2021-12-15
# Time: 10:29:19

# load the config library functions
source config.shlib

# load configuration
service="$(config_get SERVICE)"
mem_num="$(config_get MEM_NUM)"
redis_cli="$(config_get REDIS_CLI)"
host="$(config_get HOST)"
log_file="$(config_get LOG_FILE)"
lark_webhook_url="$(config_get LARK_WEBHOOK_URL)"
sleep_num="$(config_get SLEEP_NUM)"

mem_num_var_1=`echo "info memory" | ${redis_cli} | grep used_memory_human | awk -F':' '{print $2}' | sed "s/G//g"`
sleep ${sleep_num}
mem_num_var_2=`echo "info memory" | ${redis_cli} | grep used_memory_human | awk -F':' '{print $2}' | sed "s/G//g"`
sleep ${sleep_num}
mem_num_var_3=`echo "info memory" | ${redis_cli} | grep used_memory_human | awk -F':' '{print $2}' | sed "s/G//g"`
sleep ${sleep_num}
mem_num_var_4=`echo "info memory" | ${redis_cli} | grep used_memory_human | awk -F':' '{print $2}' | sed "s/G//g"`
sleep ${sleep_num}
mem_num_var_5=`echo "info memory" | ${redis_cli} | grep used_memory_human | awk -F':' '{print $2}' | sed "s/G//g"`

sum=`echo "scale=1; ${mem_num_var_1} + ${mem_num_var_2} + ${mem_num_var_3} + ${mem_num_var_4} + ${mem_num_var_5}" | bc -l`
avg=`echo $sum / 5 | bc -l`
mem_num_var=`echo "scale = 1; $avg / 1" | bc -l`

log="`date '+%Y-%m-%d %H:%M:%S'` `hostname` INFO Mem usage: ${mem_num_var}."
echo $log >> $log_file

if (( $(echo "${mem_num_var} < ${mem_num}" | bc -l) ))
then
    log="`date '+%Y-%m-%d %H:%M:%S'` `hostname` `whoami` INFO ${service} cpu num is normal."
    echo $log >> $log_file
else
    log="时间：`date '+%Y-%m-%d %H:%M:%S'`\nHost: ${host}\n监控类型：MEM\n状态：${service} 内存使用率已超过 ${mem_num}，请及时处理。"
    echo $log >> $log_file
    curl -X POST -H "Content-Type: application/json" -d '{"msg_type":"text","content":{"text":"'"$log"'"}}' ${lark_webhook_url}
fi