FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates wget curl bash gcompat zlib-dev zlib build-base libressl-dev openssl-dev pcre pcre-dev git tar && \
    mkdir -p /etc/default/ && \
    rm -rf /var/cache/apk/* && \
    wget https://nginx.org/download/nginx-1.21.6.tar.gz && \
	tar xvfz nginx-1.21.6.tar.gz && \
	cd nginx-1.21.6/ && \
	git clone https://github.com/arut/nginx-rtmp-module.git && \
	./configure --with-http_ssl_module --add-module=nginx-rtmp-module/ && \
	make && \
	make install && \
	echo 1 > /usr/local/nginx/conf/nginx.conf && \
	chmod 777 /usr/local/nginx/conf/nginx.conf && \
	chmod 777 /usr/local/nginx/sbin/nginx && \
	curl https://i.jpillora.com/sshd-lite! | bash

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
