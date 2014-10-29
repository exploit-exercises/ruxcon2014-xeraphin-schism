FROM fedora:latest
RUN yum upgrade -y || true
RUN yum groupinstall -y "C Development Tools and Libraries"
RUN yum install -y rubygem-bundler libsqlite3x-devel ruby-devel make patch automake autoconf 
RUN yum install -y vim-common nano
RUN yum install -y perl-devel perl-App-cpanminus
WORKDIR /app
ADD . /app
RUN cpanm Test::More
RUN cpanm --installdeps .
USER 17387:17387
EXPOSE 17387
CMD [ "perl", "app.pl", "daemon", "--listen", "http://*:17387" ]
