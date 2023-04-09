FROM rockylinux:9.0
ARG http_proxy
ARG https_proxy
COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN dnf install -y procps-ng MariaDB-server MariaDB-client
COPY server.cnf /etc/my.cnf.d/
COPY mariadb.sh /mariadb.sh
VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306
ENTRYPOINT [ "/mariadb.sh" ]
