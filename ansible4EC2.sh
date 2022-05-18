
sudo add-apt-repository universe
sudo apt-get update
sudo  apt install python3-pip -y
sudo pip3 install boto3
sudo python3 get-pip.py
sudo python3 -m pip install ansible



ssh -o ProxyCommand="ssh -W %h:%p -q publicec2" -i ~/.ssh/pub-key.pem ubuntu@10.0.3.216