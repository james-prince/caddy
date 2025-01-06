FROM caddy:2.8.4-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2@v2.7.0 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/caddy-dns/rfc2136

FROM caddy:2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

ENTRYPOINT ["/usr/bin/caddy", "docker-proxy"]
