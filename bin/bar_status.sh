#!/usr/bin/env bash
if [ -x /usr/local/bin/slstatus ]
then
    STATUS="/usr/local/bin/slstatus -s"
else
    STATUS=:
fi

$STATUS