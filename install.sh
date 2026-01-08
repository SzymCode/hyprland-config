#!/bin/sh

. ~/temp-hyprland-config/scripts/variables/colors.sh

echo
echo -e "${CYAN}This will copy all files from the repo into your home directory (~).${RESET}"
echo
read -p "$(echo -e ${YELLOW}Continue? [y/N]: ${RESET})" CONFIRM
CONFIRM=${CONFIRM:-N}
echo

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo -e "${RED}Aborted.${RESET}"
    exit 1
fi

echo -e "${CYAN}Copying files to home directory...${RESET}"
rm -rf ~/temp-hyprland-config/.git
cp -r ~/temp-hyprland-config/* ~/
cp -r ~/temp-hyprland-config/.* ~/ 2>/dev/null

rm -rf ~/temp-hyprland-config

echo
echo -e "${GREEN}All files copied successfully!${RESET}"
