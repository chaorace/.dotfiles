#!/usr/bin/env bash

export RCLONE_CONFIG_PASS=$(lpass show --password auth/rclone)
rclone mount \
    --config="$HOME/.config/rclone/rclone.conf" \
    --vfs-cache-mode full \
    orgbucket:/chao-org "$HOME/org"
