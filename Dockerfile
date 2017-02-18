# based on https://github.com/ZZROTDesign/alpine-caddy

FROM alpine:edge
MAINTAINER j842

RUN apk --no-cache add tini git openssh-client bash \
    && apk --no-cache add --virtual devs tar curl 
    
#Install Caddy Server, and All Middleware
RUN curl "https://caddyserver.com/download/build?os=linux&arch=amd64&features=DNS%2Cawslambda%2Ccors%2Cexpires%2Cfilemanager%2Cgit%2Chugo%2Cipfilter%2Cjsonp%2Cjwt%2Clocale%2Cmailout%2Cminify%2Cmultipass%2Cprometheus%2Cratelimit%2Crealip%2Csearch%2Cupload%2Ccloudflare%2Cdigitalocean%2Cdnsimple%2Cdyn%2Cgandi%2Cgooglecloud%2Clinode%2Cnamecheap%2Crfc2136%2Croute53%2Cvultr" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

VOLUME ["/data"]

# https://github.com/krallin/tini
# allows signals to be sent to process :-)
# SIGUSR1 gets caddy to reload config.
ENTRYPOINT ["/sbin/tini","--"]
ENV PATH /bin:/usr/bin:$PATH

CMD ["caddy", "-quic", "--conf", "/data/caddyfile"]

# add on  -ca "https://acme-staging.api.letsencrypt.org/directory"  for staging