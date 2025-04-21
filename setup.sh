#!/bin/bash
WD=$(pwd)

echo $WD
echo $HOME

if [ ! -e "${HOME}/.config/nvim" ]; then
   mkdir -p "${HOME}/.config"
   ln -s "${WD}/nvim" "${HOME}/.config/nvim"
fi

if [ ! -e "${HOME}/.config/alacritty/alacritty.toml" ]; then
   mkdir -p "${HOME}/.config/alacritty"
   ln -s ${WD}/alacritty.toml "${HOME}/.config/alacritty/alacritty.toml"
fi

if [ ! -e "${HOME}/.config/hypr/hyprland.conf" ]; then
   mkdir -p "${HOME}/.config/hypr"
   ln -s "${WD}/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
fi

if [ ! -e "${HOME}/.bashrc" ]; then
   ln -s "${WD}/.bashrc" "${HOME}/.bashrc"
fi

if [ ! -e "${HOME}/.profile" ]; then
   ln -s "${WD}/.profile" "${HOME}/.profile"
fi

if [ ! -e "${HOME}/.bash_logout" ]; then
   ln -s "${WD}/.bash_logout" "${HOME}/.bash_logout"
fi

if [ ! -e "${HOME}/.gitconfig" ]; then
   ln -s "${WD}/.gitconfig" "${HOME}/.gitconfig"
fi

# Set up GIT config with signing secret
if [ ! -e "${HOME}/.gitsecrets" ]; then
   echo -n "Git email: "
   read -r email

   echo -n "Name: "
   read -r name
   
   gpg --list-secret-keys $email # 2>$1 1>/dev/null
   if [[ $? > 0 ]] 
   then
      gpg --batch --gen-key <<EOF
Key-Type: 1
Key-Length: 4096
Name-Real: $name
Name-Email: $email
Expire-Date: 0
EOF
   fi

   keyid=$(gpg --list-secret-keys --keyid-format=long $email | grep sec)
   keyid=${keyid#*/}
   keyid=${keyid:0:16}
   echo "[user]" > "${HOME}/.gitsecrets"
   echo "   email = ${email}" >> "${HOME}/.gitsecrets"
   echo "   name = ${name}" >> "${HOME}/.gitsecrets"
   echo "   signingKey = ${keyid}" >> "${HOME}/.gitsecrets"

   echo "The following key can be shared to ensure others may trust commits signed by your key"
   gpg --armor --export $email
fi
