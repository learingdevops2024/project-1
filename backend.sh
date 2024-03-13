dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
cd /app
npm install
[Unit]
Description = Backend Service

[Service]
User=expense
Environment=DB_HOST=" 172.31.2.154"
ExecStart=/bin/node /app/index.js
SyslogIdentifier=backend
[Install]
WantedBy=multi-user.target
systemctl daemon-reload
systemctl enable backend
systemctl start backend
dnf install mysql -y
mysql -h 172.31.2.154 -uroot -pExpenseApp@1 < /app/schema/backend.sql