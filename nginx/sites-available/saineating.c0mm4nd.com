server {
        listen 443 ssl;

        server_name saineating.c0mm4nd.com saineating.tk;
                
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
                return 301 https://$host/iter1;
        }

        location /iter1 {
                auth_basic           "saineating maintaince area";
                auth_basic_user_file /var/www/.htpasswd;

                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location / {
                auth_basic           "saineating maintaince area";
                auth_basic_user_file /var/www/.htpasswd;

                root /var/www/saineating-iterations/iter2;
                try_files $uri $uri/ =404;
        }

        location /design {
                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location /public {
                auth_basic           "saineating maintaince area";
                auth_basic_user_file /var/www/.htpasswd;

                root /var/www/saineating-landing/;
                try_files $uri $uri/ =404;
        }
}

server {
        listen 443 ssl;

        server_name saineating-1.c0mm4nd.com;
                
        index index.html index.debain.html index.nginx-debian.html;

        ssl_certificate     /root/.acme.sh/saineating-1.c0mm4nd.com/saineating-1.c0mm4nd.com.cer;
        ssl_certificate_key /root/.acme.sh/saineating-1.c0mm4nd.com/saineating-1.c0mm4nd.com.key;

        location /api/ {
                proxy_pass http://127.0.0.1:4000/;
        }

        location /apiv2/ {
                proxy_pass http://127.0.0.1:5000/;
        }

        location /latest {
                return 301 https://$host/iter1;
        }

        location /iter1 {
                auth_basic           "saineating maintaince area";
                auth_basic_user_file /var/www/.htpasswd;

                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location /design {
                root /var/www/saineating-iterations/;
                try_files $uri $uri/ =404;
        }

        location / {
                auth_basic           "saineating maintaince area";
                auth_basic_user_file /var/www/.htpasswd;

                root /var/www/saineating-landing/public;
                try_files $uri $uri/ =404;
        }
}