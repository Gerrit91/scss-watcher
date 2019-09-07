FROM inn0kenty/pyinstaller-alpine:3.7 as builder
RUN pip install inotify
WORKDIR /app
COPY watch.spec watch.spec
COPY watch watch
RUN PATH="/pyinstaller:$PATH" pyinstaller watch.spec

FROM alpine
RUN apk add --no-cache sassc=3.6.0-r0 \
 && mkdir -p /input /output
COPY --from=builder /app/dist/watch /watch
ENTRYPOINT ["/watch"]
