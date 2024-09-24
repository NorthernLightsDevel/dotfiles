#!/bin/bash
WD=$(pwd)

echo $WD
echo $HOME

if [ ! -e "${HOME}/.config/nvim" ]; then
   mkdir -p "${HOME}/.config"
   ln -s "${WD}/nvim" "${HOME}/.config/nvim"
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

if [ ! -e "${HOME}/.gitsecrets" ]; then
   echo "[user]" > "${HOME}/.gitsecrets"
   echo "Git email:"
   email=$(</dev/stdin)
   echo "email=${email}" >> "${HOME}/.gitsecrets"

   echo "Name: "
   name=$(</dev/stdin)
   echo "name=${name}" >> "${HOME}/.gitsecrets"

   gpg --default-new-key-algo rsa4096 --gen-key 
   
   keyid=$(gpg --list-secret-keys --keyid-format=long | grep sec)
   keyid=${keyid#*/}
   keyid=${keyid:0:16}
   echo "signingKey=${keyid}" >> "${HOME}/.gitsecrets"

fi
