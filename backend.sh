print_Task_Heading "disable enable intall nodejs"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
print_Task_Heading "adding app user"
useradd expense
print_Task_Heading "copy backend serive file"
cp backend.service /etc/systemd/system/backend.service
print_Task_Heading "removing "
rm -rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip

cd /app
unzip /tmp/backend.zip
cd /app

npm install

systemctl daemon-reload
systemctl enable backend
systemctl start backend

dnf install mysql -y
mysql -h  172.31.47.128 -uroot -pExpenseApp@1 < /app/schema/backend.sql

