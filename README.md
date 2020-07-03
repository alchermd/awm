# Alone With Me (awm)

## Setup (Docker)

Requirements:

- Docker
- Docker Compose

```bash
$ docker-compose up -d --build
$ curl --head http://127.0.0.1:8000/    
HTTP/1.1 200 OK
Date: Fri, 03 Jul 2020 00:49:16 GMT
Server: WSGIServer/0.2 CPython/3.8.3
Content-Type: text/html
X-Frame-Options: DENY
Content-Length: 16351
X-Content-Type-Options: nosniff
```