# We deploy with Ubuntu so that devs have a familiar environment.
FROM codercom/code-server


RUN sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY apt-get-source.list /etc/apt/sources.list

RUN sudo apt-get update && sudo apt-get install -y \
	gcc \
	&& sudo rm -rf /var/lib/apt/lists/*


RUN sudo echo "export PATH=$PATH:/usr/local/go/bin:/home/coder/go/bin" >> /etc/profile
RUN sudo echo "export GOPATH=/home/coder/go" >> /etc/profile
RUN sudo echo "export PATH=$PATH:/usr/local/go/bin:/home/coder/go/bin" >> /home/corder/.bashrc
RUN sudo echo "export GOPATH=/home/coder/go" >> /home/coder/.bashrc

USER coder
RUN mkdir -p /home/coder/go 
RUN mkdir -p /home/coder/soft

# install golang
WORKDIR /home/coder/soft
RUN wget https://dl.google.com/go/go1.12.16.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xzf go1.12.16.linux-amd64.tar.gz \
     && rm go1.12.16.linux-amd64.tar.gz

RUN export PATH=$PATH:/usr/local/go/bin \
        && export GOPATH=/home/coder/go \
		&& export GO111MODULE=on \
		&& go get -v github.com/go-delve/delve/cmd/dlv \
		&& go get -v golang.org/x/tools/gopls
#RUN go get -v github.com/go-delve/delve/cmd/dlv 
#RUN go get -v golang.org/x/tools/gopls

#install vscode extension
#RUN wget -O ms-vscode.Go-0.13.0.vsix https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/Go/0.13.0/vspackage
#RUN code-server --install-extension ms-vscode.Go-0.13.0.vsix





WORKDIR /home/coder/project
