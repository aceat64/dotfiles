#!/bin/bash
SSH_ENV="$HOME/.ssh/environment"
/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
chmod 600 "${SSH_ENV}"
. "${SSH_ENV}" >/dev/null
/usr/bin/ssh-add &>/dev/null;
