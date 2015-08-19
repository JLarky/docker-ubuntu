FROM ubuntu:14.04

RUN echo "wget"

RUN apt-get install -y wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RUN echo "deb http://binaries.erlang-solutions.com/debian wheezy contrib" | sudo tee -a /etc/apt/sources.list.d/erlang-solutions.list
RUN wget --quiet -O - http://binaries.erlang-solutions.com/debian/erlang_solutions.asc | sudo apt-key add -

RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list
RUN wget --quiet -O - http://nginx.org/keys/nginx_signing.key | sudo apt-key add -


RUN echo "install utils"

RUN apt-get -y update && apt-get install -y wget git
RUN apt-get install -q=3 build-essential libexpat1-dev graphviz libssl-dev

RUN echo "postgresql"

RUN apt-get install -q=3 postgresql-9.4
RUN wget --quiet https://gist.githubusercontent.com/gaech/4b17f9aef1fb48ec2667/raw/6341cb8b6c8bcabd70f90c928a95f10af56b6032/pg_hba.conf -O /etc/postgresql/9.4/main/pg_hba.conf

RUN service postgresql restart

RUN echo "erlang"

RUN apt-get install -q=3 esl-erlang=1:17.5.3
RUN rm -f /usr/lib/erlang/man

RUN echo "nginx"

RUN apt-get install -q=3 nginx
RUN mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled /etc/nginx/ssl
RUN wget --quiet https://gist.github.com/gaech/4b17f9aef1fb48ec2667/raw/be801b88a0c55e563b3224a3d158c0c5c6552aa4/nginx.conf -O /etc/nginx/nginx.conf

RUN echo "--= Node.js installation =--"

RUN wget -qO - https://deb.nodesource.com/setup_0.12 | sudo bash -
RUN apt-get install -y nodejs

RUN npm install -g gulp typescript
