# Hexlet little CMS

### Hexlet tests and linter status:
[![Actions Status](https://github.com/Luferov/devops-for-programmers-project-74/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Luferov/devops-for-programmers-project-74/actions)
[![Push App](https://github.com/Luferov/devops-for-programmers-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/Luferov/devops-for-programmers-project-74/actions)


## For use

You can find image [https://hub.docker.com/repository/docker/luferov/services-app/general](https://hub.docker.com/repository/docker/luferov/services-app/general)


If you use `docker-compose.yml`

```yml
version: "3"

services:
  caddy:
    image: caddy:latest
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
  app:
    command: >
        bash -c "npm run prestart && npm run start"
    image: luferov/services-app
    environment:
        DATABASE_NAME: postgres
        DATABASE_USERNAME: postgres
        DATABASE_PASSWORD: postgres
        DATABASE_PORT: 5432
        DATABASE_HOST: db
  db:
    container_name: hexlet-db
    image: postgres:latest
    environment:
      POSTGRES_DB: postgres
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
```

For reverse proxy you can use Caddyfile with configuration

```config
localhost {
  log {
    format json
  }

  # Компрессия
  encode zstd
  # Самоподписной сертификат
  tls internal

  # Проксирование всех запросов в app:8080
  # app – имя сервиса в docker-compose.yml
  reverse_proxy /* app:8080
}
```

## Dev 💻

Before dev you need init project, use this command:

```bash
make init
```

After this use command for dev:

```bash
make dev
```

## Test 🚀

```bash
make test
```

## For push image use

```bash
make push
```
