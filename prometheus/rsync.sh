#!/bin/bash

# $PROME_MASTER_IP & $PROME_SLAVE_IP 之间prometheus / alertmanager / Dingtalk-webhook file 同步；

# prometheus:
rsync -avz /data/prometheus/prometheus/prometheus.yml work@$PROME_SLAVE_IP:/data/prometheus/prometheus/
rsync -avz /data/prometheus/prometheus/rules/* work@$PROME_SLAVE_IP:/data/prometheus/prometheus/rules/
rsync -avz /data/prometheus/prometheus/targets/* work@$PROME_SLAVE_IP:/data/prometheus/prometheus/targets/

# alertnamager:
rsync -avz /data/prometheus/alertmanager/alertmanager.yml work@$PROME_SLAVE_IP:/data/prometheus/alertmanager/

# Dingtalk-webhook:
# rsync -avz /data/deploy/dingtalk/app.py work@$PROME_SLAVE_IP:/data/deploy/dingtalk/
rsync -avz /data/deploy/dingtalk/* work@$PROME_SLAVE_IP:/data/deploy/dingtalk/


# reload:
ssh $PROME_SLAVE_IP "curl -sS -XPOST http://localhost:9090/-/reload"
ssh $PROME_SLAVE_IP "curl -sS -XPOST http://localhost:9093/-/reload"
