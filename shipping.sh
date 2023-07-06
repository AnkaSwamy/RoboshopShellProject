echo -e "\e[31m Install Maven \e[0m"
yum install maven -y  &>>/tmp/roboshop.log

echo -e "\e[31m Add application user  \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[31m Create application directory \e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[31m Download application content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Extract application content \e[0m"
unzip /tmp/shipping.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m  Download maven dependencies \e[0m"
mvn clean package  &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar  &>>/tmp/roboshop.log

echo -e "\e[31m Install mysql client \e[0m"
yum install mysql -y  &>>/tmp/roboshop.log

echo -e "\e[31m load schema \e[0m"
mysql -h mysql-dev.ankadevopsb73.store -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>>/tmp/roboshop.log

echo -e "\e[31m setup systemd service \e[0m"
cp /root/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[31m Start shipping service \e[0m"
systemctl daemon-reload
systemctl enable shipping  &>>/tmp/roboshop.log
systemctl restart shipping  &>>/tmp/roboshop.log