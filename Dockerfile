FROM alpine
RUN apk add --no-cache tini sassc=3.6.0-r0 inotify-tools
COPY watch.sh /watch.sh
ENTRYPOINT ["/sbin/tini", "--"]
CMD /watch.sh
