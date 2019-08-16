# scss-watcher

sassc with watcher on Alpine, much smaller than the Ruby pendants.

It uses a small watch script with `inotifywait` to recompile scss files on change events.

I use it like this in docker-compose:

```
version: '3.7'
services:
  sass-watch:
    image: "gerrit91/scss-watcher"
    init: true
    container_name: scss-watcher
    user: "${USER_ID}:${GROUP_ID}"
    volumes:
      - "$(PWD)/scss:/scss"
      - "$(PWD)/public/css:/output"
```

Hope this will fit your needs as well.
