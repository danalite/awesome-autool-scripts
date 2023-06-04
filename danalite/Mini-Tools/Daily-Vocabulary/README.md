## Pre-requisites

- Option 1:　install the anki-desktop docker image. Run `docker compose up`: https://hub.docker.com/r/pnorcross/anki-desktop

```yaml
services:
  anki-desktop: 
    image: "pnorcross/anki-desktop:latest"
    volumes:
      - ./config:/config/app
    ports: 
      - 3000:3000
      - 8765:8765
```

- Option 2: install anki-desktop from https://apps.ankiweb.net/, import decks locally and API call through anki-connect

- Option 3: do NOT use anki. Spaced repetition using csv local database. To make it simple, we use one CSV from [French-Dictionary](https://github.com/hbenbel/French-Dictionary/tree/master/dictionary) as example. The script will maintain another light SQLite database to track the progress.


