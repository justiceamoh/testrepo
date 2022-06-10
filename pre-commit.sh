#! /bin/bash
VERSION=$(awk '/FIRMWARE/ { printf("%s.", $3); }' FirmwareVersion.h | sed 's/\./-/3;s/.$//;s/\"//g')

commit_hash=$(git rev-parse --verify HEAD)

if git diff --quiet HEAD^..HEAD FirmwareVersion.h
then
	echo ""
else
	# Initial commit: diff against an empty tree object
	against=$(git hash-object -t tree /dev/null)
fi


if ! git diff --quiet HEAD^..HEAD FirmwareVersion.h
then
    VERSION=$(awk '/FIRMWARE/ { printf("%s.", $3); }' FirmwareVersion.h | sed 's/\./-/3;s/.$//;s/\"//g')
    git tag -a "v$VERSION" -m "`git log -1 --format=%s`"
    echo "FirmwareVersion.h changed. Created new tag, v$VERSION."
fi