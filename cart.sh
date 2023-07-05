echo -e "\e[31m configure nodejs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[31m Install nodejs \e[0m"
yum install nodejs -y  &>>/tmp/roboshop.log

echo -e "\e[31m Add application user \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[31m  create application directory\e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[31m Download application content \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Extract application content \e[0m"
unzip /tmp/cart.zip  &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Install nodejs dependencies \e[0m"
npm install  &>>/tmp/roboshop.log

echo -e "\e[31m setup systemd service \e[0m"
cp /root/Roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[31m start cart service \e[0m"
systemctl daemon-reload
systemctl enable cart  &>>/tmp/roboshop.log
systemctl start cart   &>>/tmp/roboshop.log