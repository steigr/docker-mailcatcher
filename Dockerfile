FROM alpine:3.7 AS mailcatcher

RUN  trap 'rm -rf /var/cache/apk/*' EXIT \
 &&  apk add --no-cache ruby ruby-json sqlite-libs libstdc++ tini

RUN  trap 'apk del --no-cache .build-dep; rm -rf /var/cache/apk/*' EXIT \
 &&  apk add --no-cache --virtual .build-dep ruby-dev gcc libc-dev make g++ sqlite-dev \
 &&  gem install --no-ri --no-rdoc mailcatcher --pre \
 &&  gem install --no-ri --no-rdoc anyway_config \
 &&  find $(find /usr/lib/ruby -type d -name thin) -name server.rb -type f | xargs -n1 sed -i 's|Fixnum|Integer|'

COPY dockerfiles .
RUN  adduser -D mailcatcher
USER mailcatcher

ENV  MAILCATCHER_SMTP_PORT=1025 \
     MAILCATCHER_HTTP_PORT=1080 \
     MAILCATCHER_BROWSE=true \
     MAILCATCHER_VERBOSE=true

ENTRYPOINT ["tini"]
CMD ["mailcatcher"]