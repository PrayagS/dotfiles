#!/bin/sh

pactl load-module module-null-sink sink_name=null_sink
pactl load-module module-loopback sink=null_sink
pactl load-module module-loopback sink=null_sink
