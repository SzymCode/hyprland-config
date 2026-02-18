#!/bin/bash
TARGET=$1
CURRENT=$(hyprctl activeworkspace -j | jq '.id')

if [ "$TARGET" == "$CURRENT" ] || [ -z "$TARGET" ]; then exit 0; fi

# Get window addresses
WIN_TARGET=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $TARGET) | .address")
WIN_CURRENT=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $CURRENT) | .address")

# Step 1: Move windows from TARGET to temporary (99)
for addr in $WIN_TARGET; do
    hyprctl dispatch movetoworkspacesilent 99,address:$addr
done

# Step 2: Move windows from CURRENT to TARGET
for addr in $WIN_CURRENT; do
    hyprctl dispatch movetoworkspacesilent $TARGET,address:$addr
done

# Step 3: Move windows from temporary to CURRENT
WIN_TMP=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == 99) | .address")
for addr in $WIN_TMP; do
    hyprctl dispatch movetoworkspacesilent $CURRENT,address:$addr
done
