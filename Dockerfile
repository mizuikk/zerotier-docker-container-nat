FROM ubuntu:noble
RUN mkdir /app
WORKDIR /app

RUN apt-get update -qq && apt-get install -qq --no-install-recommends -y ca-certificates curl procps iptables 
RUN curl -o install-zerotier.sh https://install.zerotier.com
RUN bash install-zerotier.sh
COPY entrypoint.sh entrypoint.sh
RUN chmod 755 entrypoint.sh
RUN rm -rf install-zerotier.sh
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/app/entrypoint.sh"]
