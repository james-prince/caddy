FROM caddy:2.11.7-builder-alpine AS builder

COPY modules /src/modules

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2=/src/modules/caddy-docker-proxy \
    --with github.com/caddy-dns/cloudflare=/src/modules/caddy-cloudflare \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --replace github.com/hslatman/caddy-crowdsec-bouncer=/src/modules/caddy-crowdsec-bouncer \
    --with github.com/caddy-dns/rfc2136=/src/modules/caddy-rfc2136

FROM caddy:2.11.7

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

ENTRYPOINT ["/usr/bin/caddy", "docker-proxy"]
