echo -e "\e[31m Install python \e[0m"
yum install python36 gcc python3-devel -y  &>>/tmp/roboshop.log

echo -e "\e[31m Add application user \e[0m"
useradd roboshop   &>>/tmp/roboshop.log

echo -e "\e[31m Create application directory \e[0m"
rm -rf /app   &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[31m Download application content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Extract application content \e[0m"
unzip /tmp/payment.zip   &>>/tmp/roboshop.log

echo -e "\e[31m Install application dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt  &>>/tmp/roboshop.log

echo -e "\e[31m  Setup systemd service \e[0m"
cp /root/Roboshop-shell/payment.service /etc/systemd/system/payment.service  &>>/tmp/roboshop.log


echo -e "\e[31m Start payment service \e[0m"
systemctl daemon-reload   &>>/tmp/roboshop.log
systemctl enable payment   &>>/tmp/roboshop.log
systemctl start payment    &>>/tmp/roboshop.log