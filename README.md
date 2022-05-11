# Saineating Backend


## Get Ready

```bash
git clone https://github.com/cookies-team/saineating-backend && cd saineating-backend
npm install
```

## Main File Descriptions

- `iterion#X.js`: nodejs backend for iteration X, use `node iteration#X.js` to start it
- `nginx/sites-available/XXX`: the config file of the site

## Scripts

- `update_nginx.sh`: update nginx setting and restart nginx (not auto enable site)
- `create_http_auth.sh`: create a .htpasswd to keep the http auth user and password, requiring manually add the generated file by `auth_basic` and `auth_basic_user_file` inside the site config
- `update_ssl_cert.sh`: require installing [acme.sh](https://github.com/acmesh-official/acme.sh); update (or sign) the ssl cert of the site. requiring manually add the cert files by `ssl_certificate` and `ssl_certificate_key` inside the site config

## FAQ

- nginx updated but cannot serve the site?

Please enable the site with command `ln -s /nginx/sites-available/SITE_NAME /nginx/sites-enabled/SITE_NAME`

- What if port got occupied?

Change port written in the js file's last line, e.g. change the `4000` in `app.listen(4000);`  

