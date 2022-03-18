#!/bin/sh

#nginx
echo 'worker_processes  1;
events {
    worker_connections  1024;
}


rtmp {
server {
listen '${PORT}'; # Listen on standard RTMP port
chunk_size 4096;

# Enable simple RTMP live broadcast service
application live {
live on;
record off;

}
}
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       6573;
        server_name  _;

        location / {
            root   html;
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

    }

}' > /usr/local/nginx/conf/nginx.conf

/usr/local/nginx/sbin/nginx &

echo Server started successfully!

sshd-lite -p 10122 tesing:miksike1 

