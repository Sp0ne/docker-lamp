# 🐳 Docker-lamp &middot; [![Latest Github release](https://img.shields.io/github/release/Sp0ne/docker-lamp.svg)](https://github.com/Sp0ne/docker-lamp/releases/latest)
=====

Basic LAMP stack environment built using Docker Compose.

**🚨 Important : This Docker Stack is build for PERSONAL local development and NOT FOR PRODUCTION USAGE**

---

### 📌 Table of Content

- [🐳 Docker-lamp](#---docker-lamp)
    + [🗃 Introduction](#---introduction)
    + [💾 Installation / Quick start](#---installation---quick-start)
    + [💫 Configuration and Usage](#---configuration-and-usage)
      - [Configuration](#configuration)
      - [Entry Point](#entry-point)
      - [CMD Shortcut](#cmd-shortcut)
    + [🍭 CREDITS & SUPPORT](#---credits---support)

---

### 🗃 Introduction

Include in the Docker Compose (tested on Ubuntu 20.04 LTS):  

* PHP Apache (Include: 5.6, 7.1, 7.4)
* Portainer 
* PhpMyAdmin 
* Database (Include: mariadb 10.3, mysql 5.7, mysql8)
* Node (Include: 10.16, 12.4)

---

### 💾 Installation / Quick start

1. Clone this repository on your local computer
2. Init, configure .env as needed: `make env` 
3. Add yours entry points in `./config/vhosts.txt` file (see "Entry Point" below)
4. Run generation of vhosts files : `make generate-vhosts`
5. Add your entry point into `/etc/hosts` file (see "Entry Point" below)
6. Run Docker composer: 
    - make `run-build` for build and start
    - Or `make run` for start only

Your LAMP stack is now ready!! You can access it via [localhost](http://localhost).

Now you can access to your environnement:
* Your Http homepage [localhost](http://localhost)
* Portainer [localhost:9999](http://localhost:9999)
* PhpMyAdmin on [localhost:8090](http://localhost:8090)


---

### 💫 Configuration and Usage 


#### Configuration

This package comes with default configuration options. 
You can modify them by creating (Step 2.) .env file in your root directory. 

> PHP_INI: In each PHP Bin  you can define your custom php.ini `/bin/{PHP_VERSION}/php.ini` to meet your requirements.

#### Entry Point

1. Add yours vhosts URL and ENTRYPOINT Folder in `./config/vhosts.txt`:
2. Run generation of vhosts files : `make generate-vhosts` and Copy generate host line
3. Paste your entry point in `/etc/hosts` after localhost:
```shell
# 1
➜ nano /config/vhosts.txt
# Add your URL and PATH with delimiter: `|` 
my-project.local|\/var\/www\/my-project\/web

# 2
➜ make generate-vhosts
...
Modify your /etc/host file with these lines:
127.0.0.1 my-project.local
...

# 3
➜ sudo nano /etc/hosts
127.0.0.1 localhost # Paste your host line after this line
127.0.0.1 my-project.local
```

#### CMD Shortcut

Available script

- `make` or `make help` for helping
- `make env` for init env file
- `make run` for start
- `make run-build` for build and start
- `make run-php` for access into your container php 
- `make generate-vhosts` for create vhosts files conf 
- `make check-vhosts` for check if url is available

> _For windows user check the `makefile` for cmd._

Docker Shortcut:

- `docker ps` List all containers
- `docker ps -aq` List all containers (only IDs)
- `docker stop $(docker ps -aq)` Stop all running containers

Show Docker log into your server:

```shell
➜ docker logs --tail 50 --follow --timestamps [docker-container-name]
# Example
➜ docker logs --tail 50 --follow --timestamps my-container-name
```

> _Change `[docker-container-name]` by your container name_

---

### 🍭 CREDITS & SUPPORT

If this project help you, feel free to give me a cup of coffee :)

- [☕ Buy me a coffee](https://www.buymeacoffee.com/vincesio)
- [🎁 Feel free](https://www.paypal.me/vincesio/5)

---

> 🍻 Have Fun !
> Made with ❤ by @Sp0ne - Lead Developer - [vinces.io](https://vinces.io)

---