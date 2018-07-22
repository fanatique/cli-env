# fanatique/cli-env

Everything I usually need to work on the command line, stuffed into a Docker container.

# What it contains

tbd.

# Build it

tbd.

# Run it

The easiest way to run it, is using the public image that is hosted on Dockerhub:

´´´
docker pull fanatique/cli-env:latest
´´´

The image itself does not contain anything secret, therefore everything is passed into the container at runtime.

In my case this is:

- the ´~/.docker´ directory (for using docker machine)
- the ´~/.ssh´ directory 
- my openvpn certificates
- a directory with my projects

And I found it to be useful to also mount the the Docker socket, so that I can build and run images and containers within my environment.

´´´
docker run -v ~/.ssh:/root/.ssh:ro -v ~/.docker:/root/.docker:ro -v ~/.openvpn:/root/.openvpn -v ~/projects:/projects -v /var/run/docker.sock:/var/run/docker.sock -it fanatique/cli-env:latest
´´´

