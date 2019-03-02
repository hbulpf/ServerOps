###Install dependencies:
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py

###Install Shadowsocks:
pip install --upgrade pip
pip install shadowsocks

###Create Shadowsocks profile:
sudo cat << EOM > /etc/shadowsocks.json 
{ 
    "server": "0.0.0.0",
    "port_password":
	{
		"5041": "50412018",
		"5042": "50422018",
        "5043": "50432018"
    },
    "timeout": 300,
    "method": "aes-256-cfb"
}
EOM

#Configure Firewall:
yum install firewall
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-port=5041/tcp
firewall-cmd --permanent --zone=public --add-port=5042/tcp
firewall-cmd --permanent --zone=public --add-port=5043/tcp
firewall-cmd --reload

#Initiate Shadowsocks service in the background:
nohup ssserver -c /etc/shadowsocks.json &
