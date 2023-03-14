FROM postgres:15.2

COPY ./ACCC4CF8.asc /ACCC4CF8.asc

RUN cp /etc/apt/sources.list.d/pgdg.list /pgdg.list.bak &&\
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list' &&\
    cat /ACCC4CF8.asc | apt-key add - &&\
    apt-get update &&\
    apt-get install -y git make gcc postgresql-server-dev-15 &&\
    git clone https://github.com/begriffs/pg_rational.git &&\
    cd /pg_rational && make && make install &&\
    rm /ACCC4CF8.asc &&\
    mv /pgdg.list.bak /etc/apt/sources.list.d/pgdg.list &&\
    apt-key del "B97B 0AFC AA1A 47F0 44F2  44A0 7FCC 7D46 ACCC 4CF8" &&\
    rm -rf /pg_rational &&\
    apt-get remove -y git make gcc postgresql-server-dev-15 &&\
    apt-get autoremove -y &&\
    apt-get clean all
