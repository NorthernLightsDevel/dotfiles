#!/bin/bash

# Get dotnet install script if not found
if [ ! -f "${HOME}/dotnet-install.sh" ]; then
    wget https://builds.dotnet.microsoft.com/dotnet/scripts/v1/dotnet-install.sh -O ${HOME}/dotnet-install.sh
    chmod +x ${HOME}/dotnet-install.sh
fi

# Install/update LTS runtimes currently in use.
sudo ${HOME}/dotnet-install.sh -c 6.0 --install-dir /usr/share/dotnet/
sudo ${HOME}/dotnet-install.sh -c 8.0 --install-dir /usr/share/dotnet/
sudo ${HOME}/dotnet-install.sh -c 9.0 --install-dir /usr/share/dotnet/

# link dotnet executable into /usr/bin/dotnet to ensure command is executable.
sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet 2>/dev/null
