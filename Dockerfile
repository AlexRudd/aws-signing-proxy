## aws-signing-proxy
FROM scratch
MAINTAINER Chris Lunsford <cllunsford@gmail.com>

# Add ca-certificates.crt
ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Add executable
ADD _bin/aws-signing-proxy /

# Default listening port
EXPOSE 8080

ENTRYPOINT ["/aws-signing-proxy"]
