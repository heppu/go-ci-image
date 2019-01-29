FROM golang:1.11.5

# Install go-junit-reporter for junit style reports
RUN go get -u github.com/jstemmer/go-junit-report

# Install pip and docker-compose for running integration tests
RUN apt-get update && apt-get install -y python-pip
RUN pip install docker-compose

# Install pact tools for contract tests
WORKDIR /
RUN wget https://github.com/pact-foundation/pact-ruby-standalone/releases/download/v1.63.0/pact-1.63.0-linux-x86_64.tar.gz && \
    tar xzf pact-1.63.0-linux-x86_64.tar.gz && \
    rm -rf pact-1.63.0-linux-x86_64.tar.gz
ENV PATH="/pact/bin:${PATH}"
WORKDIR /go
