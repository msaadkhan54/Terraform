#!/bin/bash
dnf update -y
dnf install -y nginx

mkdir -p /usr/share/nginx/html

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h1>Nginx Installed through script</h1>
</body>
</html>
EOF

systemctl enable nginx
systemctl start nginx