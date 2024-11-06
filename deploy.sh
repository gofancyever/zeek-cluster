#!/bin/bash

zeek -j policy/frameworks/management/controller policy/frameworks/management/agent &
sleep 5
zeek-client deploy-config /usr/local/zeek/etc/zeek-client.cfg
wait