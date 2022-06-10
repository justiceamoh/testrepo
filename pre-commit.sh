#! /bin/bash
VERSION=$(awk '/FIRMWARE/ { printf("%s.", $3); }' FirmwareVersion.h | sed 's/\./-/3;s/.$//;s/\"//g')