FROM ubuntu:18.04

# Prepare installations
RUN apt-get update && apt-get install -y gnupg curl apt-transport-https lsb-release dirmngr software-properties-common tzdata wget

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# Add ansible repo
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu artful main"

# Add azure cli repo
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Upgrade system
RUN apt-get update && apt-get upgrade -y

# Install required software and set locales
RUN apt-get install -y azure-cli php-cli byobu zsh git-core openvpn ansible pwgen vim yarn curl locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install oh my zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

CMD ["zsh"]
