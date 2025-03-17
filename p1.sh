sudo useradd appuser
sudo groupadd master
sudo usermod -aG master appuser
sudo usermod -aG sudo appuser
groups appuser
passwd appuser
# 12345
sudo su appuser
cat /etc/passwd
sudo mkdir -p /home/appuser/code
sudo chgrp sudo code
sudo chown appuser:master code
chmod 740 code
ls -la
cd code
vim application.sh

#!/bin/bash -x
echo "$(date) application executed at $(hostname)" >> /home/appuser/code/application.sh
sleep 7

sh application.sh
tail -f app.log

crontab -e
*/2 * * * * sh /home/appuser/code/application.sh

tail -f /var/log/syslog | grep cron

touch tree.txt
sudo ln -s /home/appuser/code/tree.txt /home/appuser/code/linked
sudo apt tree
tree | grep app > tree.txt
cat /home/appuser/code/linked


