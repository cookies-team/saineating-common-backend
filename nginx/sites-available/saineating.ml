server {
        listen 80;

        server_name saineating.ml;
                
        index index.html index.debain.html index.nginx-debian.html;

        location /api/ {
                proxy_pass http://127.0.0.1:4000/;
        }

        location /apiv2/ {
                proxy_pass http://127.0.0.1:5000/;
        }

        location /apiv3/ {
                proxy_pass http://127.0.0.1:6000/;
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
        listen 80;

        server_name 1.saineating.ml;
                
        index index.html index.debain.html index.nginx-debian.html;

        location /api/ {
                proxy_pass http://127.0.0.1:4000/;
        }

        location /apiv2/ {
                proxy_pass http://127.0.0.1:5000/;
        }

        location /apiv3/ {
                proxy_pass http://127.0.0.1:6000/;
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