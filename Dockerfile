FROM alpine
RUN apk add sassc=3.6.0-r0 inotify-tools
COPY watch.sh /watch.sh
CMD /watch.sh
