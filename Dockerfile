FROM golang:1.12

# Add Docker repo
RUN apt-get update && apt-get install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg2 \
   software-properties-common

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

# Install pip, docker-ce and docker-compose for running integration tests
RUN apt-get update && apt-get install -y docker-ce python-pip
RUN pip install docker-compose

# Install go-junit-reporter for junit style reports
RUN go get -u github.com/jstemmer/go-junit-report

# Install pact tools for contract tests
WORKDIR /
RUN wget https://github.com/pact-foundation/pact-ruby-standalone/releases/download/v1.63.0/pact-1.63.0-linux-x86_64.tar.gz && \
   tar xzf pact-1.63.0-linux-x86_64.tar.gz && \
   rm -rf pact-1.63.0-linux-x86_64.tar.gz
ENV PATH="/pact/bin:${PATH}"
WORKDIR /go
