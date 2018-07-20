FROM ubuntu:18.04

# Prepare installations
RUN apt-get update && apt-get install -y gnupg curl apt-transport-https lsb-release dirmngr software-properties-common tzdata wget ca-certificates

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# Add ansible repo
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu artful main"

# Add azure cli repository
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Add Docker repository
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Upgrade system
RUN apt-get update && apt-get upgrade -y

# Install required software and set locales
RUN apt-get install -y docker-ce azure-cli rake php-cli byobu zsh git-core openvpn ansible pwgen vim yarn curl locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install janus for vim
RUN curl -L https://bit.ly/janus-bootstrap | bash

# Install node LTS
RUN [ -s "/root/.nvm/nvm.sh" ] && \. "/root/.nvm/nvm.sh" && nvm install --lts

# Install oh my zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

CMD ["zsh"]
