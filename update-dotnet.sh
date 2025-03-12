#!/bin/bash

# Get dotnet install script if not found
if [ ! -f "~/dotnet-install.sh" ]
then
    wget https://builds.dotnet.microsoft.com/dotnet/scripts/v1/dotnet-install.sh -o ~/dotnet-install.sh
    chmod +x ~/dotnet-install.sh
fi

# Install/update LTS runtimes currently in use.
sudo ~/dotnet-install.sh -c 6.0 --install-dir /usr/share/dotnet/
sudo ~/dotnet-install.sh -c 8.0 --install-dir /usr/share/dotnet/

# link dotnet executable into /usr/bin/dotnet to ensure command is executable.
sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet 2>/dev/null
