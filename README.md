# scss-watcher

sassc with watcher on Alpine, much smaller than the Ruby pendants.

It uses a small watch python script with `inotify` to recompile sass/scss files on modification events. pyinstaller is used to keep the image size small.

Only files with `.sass` and `.scss` (without leading underscore) will be passed through to the compiler.

I use the image like this in docker-compose:

```
version: '3.7'
services:
sass-watch:
  image: "gerrit91/scss-watcher"
  container_name: scss-watcher
  user: "${USER_ID}:${GROUP_ID}"
  environment:
    SASSC_ARGS: "--style compressed"
  volumes:
    - "${SCRIPT_DIRNAME}/../scss:/input"
    - "${SCRIPT_DIRNAME}/../public/css:/output"
```

Hope this will fit your needs as well.
