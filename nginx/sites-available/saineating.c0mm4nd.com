server {
        listen 443 ssl;

        server_name saineating.c0mm4nd.com;
                
        root /var/www/saineating-landing/public;
        index index.html index.debain.html index.nginx-debian.html;

        ssl_certificate     /root/.acme.sh/saineating.c0mm4nd.com/saineating.c0mm4nd.com.cer;
        ssl_certificate_key /root/.acme.sh/saineating.c0mm4nd.com/saineating.c0mm4nd.com.key;

        location /api/ {
                proxy_pass http://127.0.0.1:4000/;
        }

        location /apiv2/ {
                proxy_pass http://127.0.0.1:5000/;
        }

        location /latest {
                return 301 https://$host/iter2;
        }

        location /iter1 {
                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location /iter2 {
                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location /design {
                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location / {
                try_files $uri $uri/ =404;
        }
}