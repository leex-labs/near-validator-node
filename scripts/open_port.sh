echo -e """
    __ __             __  __
|  |_ |_ \_/  |   /\ |__)(_
|__|__|__/ \  |__/--\|__)__)

\033[;32mOpen Near Validator Ports \033[0m\n
"""

sudo iptables -A INPUT -p tcp --dport 3030 -j ACCEPT
sudo apt install -y iptables-persistent

echo "to check does it work, go to http://<IP Address>:3030/status"