FROM ubuntu
RUN apt-get update
RUN apt-get install -y ca-certificates curl
RUN apt-get install -y apt-transport-https
RUN curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" |  tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl
ENTRYPOINT ["tail", "-f", "/dev/null"]