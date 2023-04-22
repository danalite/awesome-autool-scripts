## Prerequisites
- Docker: install Docker on your machine



```bash
export TARGET=Untitled

docker run --rm -v $(pwd):/workdir -w /workdir  jrottenberg/ffmpeg:4.1-alpine -i "$TARGET.mov" -vf "fps=12,palettegen" -y palette.png

docker run --rm -v $(pwd):/workdir -w /workdir  jrottenberg/ffmpeg:4.1-alpine -i "$TARGET.mov" -i palette.png -lavfi "fps=8,scale='min(720,iw)':-1:flags=lanczos [x]; [x][1:v] paletteuse" -y "$TARGET.gif"
```