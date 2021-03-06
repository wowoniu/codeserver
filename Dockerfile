# We deploy with Ubuntu so that devs have a familiar environment.
FROM codercom/code-server


USER coder
RUN mkdir -p /home/coder/go && mkdir -p /home/coder/soft

COPY apt-get-source.list /etc/apt/sources.list
COPY vscode-extensions /home/coder/soft/vscode-extensions/

RUN sudo apt-get update && sudo apt-get install -y \
	gcc \
	&& sudo rm -rf /var/lib/apt/lists/* \
	&& sudo echo "export PATH=$PATH:/usr/local/go/bin:/home/coder/go/bin" >> /home/coder/.bashrc \
	&& sudo echo "export GOPATH=/home/coder/go" >> /home/coder/.bashrc \
	&& code-server --install-extension /home/coder/soft/vscode-extensions/Go-0.12.1-beta.3.vsix \
        && code-server --install-extension /home/coder/soft/vscode-extensions/gitlens-10.2.1.vsix \
        && code-server --install-extension /home/coder/soft/vscode-extensions/php-intellisense.vsix




# install golang
WORKDIR /home/coder/soft
RUN wget https://dl.google.com/go/go1.12.16.linux-amd64.tar.gz \
    && sudo tar -C /usr/local -xzf go1.12.16.linux-amd64.tar.gz \
    && rm go1.12.16.linux-amd64.tar.gz 
    
    
RUN export PATH=$PATH:/usr/local/go/bin \
        && export GOPATH=/home/coder/go \
#	&& export GO111MODULE=on \
	&& go get  -v  github.com/go-delve/delve/cmd/dlv \
	&& go get  -v  golang.org/x/tools/gopls \
	&& go get  -v  github.com/mdempsky/gocode \ 
	&& go get  -v  github.com/uudashr/gopkgs/cmd/gopkgs \ 
	&& go get  -v  github.com/ramya-rao-a/go-outline \ 
	&& go get  -v  github.com/acroca/go-symbols \ 
	&& go get  -v  golang.org/x/tools/cmd/guru \ 
	&& go get  -v  golang.org/x/tools/cmd/gorename \ 
	&& go get  -v  github.com/fatih/gomodifytags \ 
	&& go get  -v  github.com/haya14busa/goplay/cmd/goplay \ 
	&& go get  -v  github.com/josharian/impl \ 
	&& go get  -v  github.com/rogpeppe/godef \ 
	&& go get  -v  github.com/sqs/goreturns \ 
	&& go get  -v  golang.org/x/lint/golint \ 
	&& go get  -v  github.com/stamblerre/gocode \
	&& go get  -v  github.com/davidrjenni/reftools/cmd/fillstruct \
	&& go get  -v  github.com/cweill/gotests/... 

COPY settings.json /home/coder/.local/share/code-server/User/

WORKDIR /home/coder/project
