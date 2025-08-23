# Cloud Linux Essentials <!-- omit in toc -->
https://training.linuxfoundation.org/training/linux-system-administration-essentials-lfs207/

https://training.linuxfoundation.org/training/linux-for-cloud-technicians-essentials-lfs203/

https://www.coursera.org/specializations/linux-for-lfca-certification?action=enroll#courses

# 1. Not included
- Installation
- BIOS
- Boot loader
- GUI

# 2. Distributions
> [Image](./distributions.png)

# 3. help
```
date
man date
date --help
whoami
whereis date
which date
```

# 4. File system
- ext3, ext4, XFS, Btrfs, JFS, NTFS, vfat, exfat
## 4.1. partitions
```
lsblk
df -h
du -hs /home
```
Result:
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.6G  1.6G  6.0G  22% /
```
## 4.2. Folders
```
ls -la /
```
- bin: user binaries
- etc: system config
- home: user home
- lib: shared libs
- mnt: mount points
- tmp: temp files
- usr: user utilities
- var: variable files (log)


# 5. Shell
- sh (Bourne)
- bash (Bourne again)
- zsh (Z)
## 5.1. Bash
```
ls -la
cat  .bashrc
alias la="ls -lah"
la
vim .bashrc
# add alias
```
## 5.2. Install ZSH
> [Install](https://ohmyz.sh/#install)
> [zsh plugins](./zshrc.sh)
```
sudo apt install -y zsh
cat .zshrc
cat .zsh_history
```

## 5.3. command line
```
pwd
cd /
ls -la
cd /var/log
ls
ls -l
cat cloud-init.log (aws - azure)
tail -f syslog
tail -fn 30 syslog
head -n3 syslog
less syslog # cat syslog | less

cd /home/ubuntu # $USER
mkdir app
cd app
cd ..
rmdir app    # rm -rf app

mkdir -p app2/devops
cd app2/devops
touch file1
echo line 1 > file1
echo line 2  >> file1
cat file1

# simbolic links
ln file1 file2 # hard link
cat file2

echo line 3  >> file1
ls -li # 2 files associated, same ID
rm file1 # file2 remains

touch file3
echo line 4  >> file3
ln -s file3 file4
ls -li

rm file3
ls -li

pushd $home # push onto a list
popd

touch file5
cp file5 file6
mv file5 file7
cd ../..
rm -rf app2/devops
mkdir app3/devops/sourcecode
tree
history
# ctl + r
# ctl + l
```
## 5.4. explain shell
> [link](https://explainshell.com/)
## 5.5. absolute paths
```
cat  /etc/hosts
```
## 5.6. relative paths
```
cat ../../etc/hosts
```
## 5.7. nano
```
cd app3/devops/sourcecode
nano test
# ctl + w = find
# ctl + o = write
# enter
# ctl + x = exit
```
## 5.8. vim
```
vim test
# i = insert
# esc = read
# w = write
# q = quit
# q! = forced quit
# wq = write + quit
# :<line number>
# :/<text to search>/
```
- shift + V = visual mode, select, copy (y), paste(p), cut(c)
## 5.9. .vimrc
```
set expandtab
set tabstop=2
set shiftwidth=2
set ai
set number ruler
```
# 6. I/O
## 6.1. streaming and redirections
- stdin: keyboard (0)
- stdout: terminal (1)
- stderr: log  (2)
```
cd ~
ls -la
ls -la > myhome   # tee -a = >>
echo "new line  ******************* "     >>  myhome
echo "Last line!" | tee -a myhome

find . -name 'my*'
find . -namexxx 'my*' 2> error.log
cat error.log

# stdout + stderr
ls nofile
# ls: cannot access 'nofile': No such file or directory
ls nofile > filelist 2>&1 # 2>&1; add err to out = &>
cat filelist
ls myhome  > filelist 2>&1
```
> [bash re-directions](https://catonmat.net/ftp/bash-redirections-cheat-sheet.txt)
## 6.2. pipes
- ? single char
- * any char
```
ls -la > listings
cat listings | grep error.log
ls -la | grep error.log

wget https://wordpress.org/latest.zip
find . -size +10M
find . -size +10M -exec rm {} ';'

# sed
echo "I hate you" > txt
sed s/hate/love/ txt
sed -i s/hate/love/ txt  # -i overwrite file
echo "I hate you" >> txt
echo "I hate you" >> txt
echo "I hate you" >> txt
cat txt
sed -i s/you/'all all all'/ txt
cat txt
sed -i s/all/you/ txt
cat txt # 1 match/line
sed -i s/all/you/g txt  # /g = global
cat txt

sed -i 3,4s/I/'I dont'/ txt # line 3 & 4
cat txt

sed -e 1s/you/all/g txt > sed-output

sort txt
sort -r txt
cat txt sed-output | sort
sort txt | uniq

# tee send command to stdout = >>
find . -name "*.log" | grep code-server | tee some-errors.log

cat some-errors.log | wc -lw txt # lines - words

# split command \
find . -name "*.log" \
  | tee some-errors.log
```

# 7. ENV variables
```
env
export NEW_VAR=12345
echo $NEW_VAR
echo "valor : $NEW_VAR"
unset NEW_VAR
echo $HOME
echo $PWD
echo $PATH # path to commands
echo $SHELL
```


# 8. Package management
- debian: apt (dpkg)
- redhat: dnf (rpm)
- suse: sypper (rpm)
- alpine: apk
```
# list sources (Check mongodb & docker example)
ls /etc/apt/sources.list.d

# system packages
dpkg --list | less
dpkg --list | grep adduser

apt list # all packages
apt list --installed
apt list --upgradeable

sudo apt update
sudo apt install -y wget2
sudo apt list wget2
dpkg -L  wget2 # installation path: /usr/bin/wget2
sudo apt remove wget2

sudo apt clean # clean cache

```
# 9. Process
```
ps # current user
ps -aux ## all users
ps -lf
echo "sleep 10" > sleep.sh
sh sleep.sh # run in foreground
echo "sleep 60" > sleep.sh
sh sleep.sh
# ctl + z (to suspend)
ps -lf
jobs
fg %1 # to continue
watch ps -lf

echo "sleep 600" > sleep.sh
sh sleep.sh& # & = background
kill <pid>

sh sleep.sh&
pstree | grep sleep -A1 -B2
```

- SIGTERM (15) → pide terminar (por defecto). El proceso puede limpiar recursos antes de salir.
- SIGKILL (9) → mata inmediatamente, no da chance de limpieza.
- SIGSTOP (19) → pausa el proceso (equivalente a Ctrl+Z).
- SIGCONT (18) → reanuda un proceso detenido.

## 9.1. Load Average
```
htop
free -m
```
- CPU
- Mem
- load average: last min - last 5 min - last 15 min
- uptime



# 10. users & groups
## 10.1. commands
```
whoami
groups
# check sudo & ubuntu groups

cat /etc/group
cat /etc/group | grep ubuntu:
cat /etc/group | grep sudo:
# group-name:password:group-id:user-list

cat /etc/passwd
cat /etc/passwd | grep ubuntu
# username:password:user-id:group-id:comment:home-dir:command-shell
```
## 10.2. Users
```
useradd tester
sudo useradd tester
groups tester
cat /etc/passwd | grep tester
sudo userdel tester
```
## 10.3. Groups
```
sudo groupadd temp-group
sudo groupdel temp-group

sudo groupadd new-group
sudo useradd new-user
newgrp new-group

sudo usermod -aG new-group new-user
groups new-user
sudo deluser new-user new-group
```

## 10.4. root account
```
ls /root # Permission denied
sudo ls /root

sudo cat /etc/sudoers # edit with visudo editor
# %GROUP <HOST>=(<USER>:<GROUP>) <COMMANDS>
# root     ALL =(  ALL :  ALL  )   ALL

sudo -i # prompt changed to '#'

useradd super # without sudo command
usermod -aG sudo super
passwd super
exit
su super
whoami
sudo ls /root
exit
```
> root ALL=(ALL:ALL) ALL The first field indicates the username that the rule will apply to (root).

> root ALL=(ALL:ALL) ALL The first “ALL” indicates that this rule applies to all hosts.

> root ALL=(ALL:ALL) ALL This “ALL” indicates that the root user can run commands as all users.

> root ALL=(ALL:ALL) ALL This “ALL” indicates that the root user can run commands as all groups.

> root ALL=(ALL:ALL) ALL The last “ALL” indicates these rules apply to all commands.

# 11. file permissions
```
ls -l
# <USER>-<GROUP>-<OTHERS> <USER> <GROUP>
#   rw   -  rw  -  r       ubuntu  ubuntu
# 4 = read
# 2 = write
# 1 = execute

chmod 400 sleep.sh
ls -l sleep.sh
# r --------

chmod 261 sleep.sh
chmod 777 sleep.sh

# rwx: rwx: rwx
#  u:   g:   o

chmod uo-wx,g-x  sleep.sh
chmod u+wx  sleep.sh

chgrp adm sleep.sh
chown new-user sleep.sh
mkdir new-folder
touch new-folder/file1
chown new-user new-folder
ls -l new-folder
chown -R new-user new-folder   # recursive
```

# Práctica
**Objetivo:** Reforzar el manejo de redirecciones, pipes, variables de entorno, procesos, usuarios, permisos y paquetes en Linux.
## Parte 1: Redirecciones y Pipes (15 min)

1. Ve a al home:
- usa cd
- usa ~ ó la variable $HOME

2.Lista los archivos y guarda el resultado en listado.txt.
- usa ls y > para redireccionar al archivo

3. Agrega una línea que diga "Fin del listado" al final del archivo usando >>.

4. Busca dentro de listado.txt la palabra "log" usando grep.

5. Crea un archivo llamado errores.log al intentar ejecutar un comando incorrecto:
```
ls no-existe 2> errores.log
```

6. Combina salida estándar y errores en un mismo archivo:
```
ls no-existe > errores.log 2>&1
```
7. Pregunta:
¿Qué diferencia ves entre usar > y >>?

## Parte 2: Variables de Entorno (5 min)
1. Crea una variable llamada MI_NOMBRE con su nombre.
2. Imprímela en pantalla con echo.
3. Impríme la variable dentro de una oración de la siguiente manera: "mi nombre es <MI_NOMBRE>".
4. Borra la variable con unset e intenta imprimirla nuevamente.
5. Pregunta: ¿Cuál es la diferencia entre una variable normal en Bash y una variable exportada con export?

## Parte 3: Procesos (15 min)
1. Crea un script sleep2.sh que contenga:
```
echo "sleeping for 30 seconds"
sleep 30
```
2. Ejecútalo en foreground y suspéndelo con Ctrl+Z.
3. Verifica con jobs y reanúdalo en foreground (fg).
4. Ejecuta el mismo script en background con &.
5. Encuentra el proceso con ps y mándale la señal SIGKILL para terminarlo (kill -9).
6. Pregunta: ¿Qué diferencia ves entre usar & y no usarlo?

## Parte 4: Usuarios y Permisos (15 min)
1. Crea un nuevo usuario llamado estudiante
2. Crea un archivo notas.txt con cualquier texto.
3. Cámbiale el dueño al usuario estudiante.
4. Cámbiale los permisos al archivo para que:
   - El dueño pueda leer y escribir.
   - El grupo solo pueda leer.
   - Otros no tengan acceso.
5. Agrega el usuario estudiante al grupo sudo.
6. Cambia la contraseña del usuario estudiante a: temp100
7. Ingresa al usuario root
8. Regresa al usuario anterior
9. Ingresa como el usuario estudiante.
10. Regresa al usuario anterior

## Parte 5: Monitoreo del sistema (10 min)
1. Abre el monitor interactivo de procesos: htop
2. Identifica los procesos que más CPU usan.
3. Identifica los procesos que más memoria consumen.
4. Observa la parte superior de htop e interpreta el Load Average (carga del sistema).
   - Primer valor = carga en el último minuto.
   - Segundo valor = carga en los últimos 5 minutos.
   - Tercer valor = carga en los últimos 15 minutos.
5. Abre otra terminal y ejecuta un proceso que consuma CPU (ejemplo: un bucle infinito):
```
while true; do sleep 1; done
```
6. Observa el htop y observa la carga del sistema.
7. Mata el proceso con Ctrl+C.
8. Mide el uso de memoria en MB: free -m

## Parte 6: Paquetes (10 min)
En este ejercicio vamos a instlar la aplicación cosway
1. Lista los paquetes instalados relacionados con `cowsay`
```bash
dpkg --list | grep cowsay
# otra opción para ver los paquetes:
apt list | grep cowsay
```
2. Instala el paquete cowsay
3. Ejecuta cowsay
```bash
cowsay "Hello World"
```
4. Desinstala el paquete cowsay

## Parte 7: Paquetes Avanzado (15 min)
En este laboratorio vamos a instalar la apliación NodeJS (JavaScript) paso a paso.
Esta es una instalación mas compleja ya que el instalador no existe en la lista de paquetes de ubuntu.

1. Verifica la lista de paquetes: NodeJS no existe.
```bash
apt list | grep nodejs
```

1.1 Intenta instalar NodeJS
```bash
sudo apt install -y nodejs
```
> Resultado: E: No se encontraron paquetes que coincidan con 'nodejs'

2. Preparación
  - Actualiza los paquetes
  - Instala curl, ca-certificates y gnupg: esto es necesario para administrar paquetes de repositorio remoto
  - GPG es un protocolo de cifrado que se utiliza para verificar la integridad de los paquetes
```bash
sudo apt update
sudo apt install -y curl ca-certificates gnupg
```

2. Agregar la llave GPG
- Descarga la llave GPG
- gpg --dearmor: se encarga de convertir la llave en un archivo .gpg
```bash
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
  sudo gpg --dearmor -o /usr/share/keyrings/nodesource.gpg
```

3. Verifica la llave:
```bash
gpg --show-keys /usr/share/keyrings/nodesource.gpg
```
> Salida esperada: gpg: directory '/home/azureuser/.gnupg' created

4. Agregar la lista de paquetes
- Este comando agrega NodeJS a la lista de paquetes de apt
```bash
echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] \
https://deb.nodesource.com/node_20.x nodistro main" | \
  sudo tee /etc/apt/sources.list.d/nodesource.list

```
5. Actualizar la lista de paquetes y verificar que NodeJS esta disponible
```bash
sudo apt update
apt list | grep nodejs
```

6. Instalar usando apt
```bash
sudo apt install -y nodejs
```


7. Verifica la instalación
```bash
node --version
```
> Resultado: v20.19.4

> Node Ya esta instalado en la VM!!

# 12. Scripting
> [hints](https://devhints.io/bash)
## 12.1. first.sh
```
#!/bin/bash
echo "My first shell script"
```
> sh first.sh
```
./first.sh

# permission denied: ./first.sh
ls -la
chmod 700 first.sh
./first.sh
```

## 12.2. vars
vars.sh
```sh
#!/bin/bash
NAME=<MY_NAME>
echo "My name is $NAME"
```
> sh vars.sh

## 12.3. System functions
sysfunc.sh
```sh
#!/bin/bash
MY_ENV=$(env)
echo "$MY_ENV" > local-env
```
> sh sysfunc.sh
> cat local-env

## 12.4. input
input.sh
```sh
#!/bin/bash
INPUT=$1
echo $1
echo "my input = $INPUT"
```
> sh input.sh
> $0 = script name
> $1, $2... = args
> $* = all params
> $# = number args

## 12.5. Conditionals
cond.sh
```sh
#!/bin/bash
if [ $# -eq 0 ]
then
  echo "No arguments supplied"
  exit 1
fi


NUM=$1
if [ $NUM -eq 1 ]
  then
     echo "$NUM is one"
     exit 0
  else
    echo "$NUM isnt one. Error"
    exit 128 # Invalid Argument To Exit
fi
```
> sh cond.sh
> -eq = equal
> -ne = not equal
> -gt = greather than
> -lt = less than

## 12.6. Files
files.sh
```sh
#!/bin/bash
echo $1
if [ -e $1 ]
then
  echo "File exists!!!"
else
  echo "File not exists :("
fi
```
> sh files.sh


## 12.7. Functions
func.sh
```sh
#!/bin/bash
file_count()
{
  local NUMBER_OF_FILES=$(ls -l | wc -l)
  echo "$NUMBER_OF_FILES"
}
file_count
```
> sh func.sh

## 12.8. Functions and arguments
func-var.sh
```sh
#!/bin/bash
file_count()
 {
   local Directory=$1
   FILE_COUNTER=$(ls $Directory|wc -l)
   echo "$Directory: $FILE_COUNTER"
 }
file_count /etc
file_count /var
file_count /usr/bin
```
> sh func-var.sh

## 12.9. Prompt
prompt.sh
```sh
#!/bin/bash
echo "Enter your name:"
   read NAME
sleep 10
echo "YOUR NAME: $NAME"

```
> sh prompt.sh

## 12.10. command
command.sh
```sh
#!/bin/bash
if [ $# -eq 0 ]
then
  echo "No arguments supplied"
  exit 1
fi

if ! command -v ${1}  2>&1 /dev/null ; then
  echo "${1} isnt installed :("
else
  echo "${1} is installed!!!"
fi
```
> sh command.sh wget
> sh command.sh docker

## 12.11. string
string.sh
```sh
#!/bin/bash
echo $1 | cut -c 1-5
```
> sh string.sh "1 2 3 4 5"

## 12.12. for
for.sh
```sh
#!/bin/bash
for i in hello world and others
do
   echo "i: $i"
   sleep 2
done
```
> sh for.sh

## 12.13. while
while.sh
```sh
#!/bin/bash
HOST=$1
i=0
ok=false
echo "Init log $(date)" > /tmp/while.log
while [ $i -lt 3  ]
do
  echo "try: $i to $HOST"
  if ! ping -c 1 $HOST >/dev/null 2>&1
  then
    echo "waiting vm[$HOST]..." >> /tmp/while.log
    sleep 5
  else
    echo "vm [$HOST] ok" >> /tmp/while.log
    ok=true
    break
  fi
  i=$(($i+1))
done

if $ok; then
  echo "$HOST online"
else
  echo "$HOST offline"
fi
```
> sh while.sh localhost
> sh while.sh nohost

# 13. Cron
> [crontab.guru](https://crontab.guru/#*_*_*_*_*)
```

vim cron-sleep.sh
# #!/bin/bash -x
# echo "message from cron $(date)" >> /home/ubuntu/msg.txt
# sleep 5

crontab -e
# * * * * * sh /home/ubuntu/cron-sleep.sh

tail -f /var/log/syslog | grep cron
watch cat  msg.txt
```
- /etc/anacrontab


# 14. Practice
- create user: appuser
- create a group: master
- add appuser to master group
- add user to sudo group
- change appuser password to 12345
- login to appuser
- at appuser HOME, create new folder: code
- change code folder group owner to master
- change code folder user owner to appuser
- change code folder permission to group: r, user rwx, other: none
- at code folder create application.sh. File content:
  - make it executable (#!/bin/bash)
  - echo "<DATE> application executed at <HOSTNAME>". Use a hostname command
  - save echo stdout in app.log
  - wait for 7 seconds
- execute application.sh
- show app.log with "tail -f"
- create a cron each two minutes executing application.sh
- check cron logs
- create a file named tree.txt, and add a soft link to a file named /home/appuser/code/linked
- list all files (use tree command) then filter by word "app" and save it to tree.txt file
- show /home/appuser/linked file
# 15. Basic networking
## 15.1. IP Addresses
```
ip address
# eth0 - ip
```

## 15.2. IP Octets

#.#.#.#/#

## 15.3. IP Class
A: 1.0.0.0 to 127.255.255.255
16 Millones de hosts por red

B: 128.0.0.0 to 191.255.255.255
65 000 hosts por red

C: 192.0.0.0 to 223.255.255.255
254 hosts por red

## 15.4. subnet
A: /8  - /15 =  131K - 16M ips

B: /16 - /23 =  510  - 65k ips

C: /24 - /32 =  0    - 254 ips

/28: 14
/24: 254
/20: 4.094
/16: 65.534


## 15.5. Name Resolution
> [info](https://en.wikipedia.org/wiki/Domain_Name_System)
```
ping linuxfoundation.org

cat /etc/resolv.conf
# nameserver 127.0.0.53

vim /etc/hosts
# 10.0.0.0 nada.com

host nada.com
host linuxfoundation.org
nslookup linuxfoundation.org
```

## 15.6. Routing
```
ip address
ip route
sudo apt install traceroute
traceroute linuxfoundation.org
wget https://training.linuxfoundation.org/cm/prep/ready-for.sh
```


# 16. SystemD
```
service  --status-all
```
> + = running
> - = stopped
## 16.1. Create service

```sh
sudo vim /etc/systemd/system/hello.service
```

```sh
[Unit]
Description=hello world service

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=sh for.sh
Restart=always

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload

sudo systemctl start hello.service
sudo systemctl enable hello.service
sudo systemctl status hello.service
journalctl -u hello -f
sudo systemctl disable hello.service
sudo systemctl stop hello.service
```

# 17. ssh
```
cat /etc/ssh/sshd_config
# Port 22
# PermitRootLogin prohibit-password
# PasswordAuthentication no

# sudo systemctl restart sshd

cd ~/.ssh
ls

# authorized_keys
# known_hosts

ssh-keygen -q -N "" -C "user@mail.com"
cat mykey
cat mykey.pub
# copy mykey.pub
# paste in remote VM: "vim ~/.ssh/authorized_keys"

# connect
ssh -i ~/.mykey <USER>@<REMOTE_HOST>
```
> -e 'ssh -i key-name'

# 18. Compression and backup
## 18.1. zip
```
# file
gzip listings
ls *.gz
cat listings.gz
zcat listings.gz

# files in folder
mkdir -p bigfiles/code
touch bigfiles/file1
touch bigfiles/file2
touch bigfiles/file3
gzip -r bigfiles
gunzip bigfiles/file1

# folder
tar zcvf big.tar.gz bigfiles
rm -rf bigfiles
# untar folder
tar xvf big.tar.gz
```
## 18.2. rsync
> [rsync examples](https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/)
```
mkdir -p /tmp/backups
rsync -zvh big.tar.gz /tmp/backups/
ls /tmp/backups

# ssh send (incremental)
rsync -avzhe ssh --progress  /tmp/backups  ubuntu@ip-10-0-98-123:/tmp/
#                             LOCAL FOLDER     REMOTE USER      : REMOTE FOLDER

# ssh receive
rsync -avzhe ssh --progress  <USER>@<REMOTE_HOST>:/tmp/backups   /tmp/backups
#                               REMOTE USER      : REMOTE FOLDER  LOCAL FOLDER
```

# 19. Basic security
## 19.1. logs
```
tail -fn 10 /var/log/auth.log
tail -fn 10 /var/log/syslog
journalctl
```
## 19.2. password
```
passwd ubuntu
passwd -l ubuntu
passwd -u ubuntu

chage --list ubuntu
sudo chage -M 30 ubuntu # pass expire after 30 days
sudo chage -W 25 ubuntu # pass expiration warning
sudo chage -d 0 ubuntu # pass force to change
su ubuntu
sudo chage -E -1 ubuntu # disable account expiry
sudo chage -E 2025-01-31 ubuntu # disable date account
chage --help

# strong passwords
sudo apt install -y libpam-pwquality
sudo cp /etc/pam.d/common-password /etc/pam.d/common-password.bak

sudo vim /etc/pam.d/common-password
# find and edit:
# password requisite  pam_pwquality.so retry=3 minlen=8 ucredit=-1 dcredit=-1 ocredit=-1 deny=5 unlock_time=600

passwd
```
> minlen  = length
> ucredit = upper
> dcredit = digit
> ocredit = other
> deny    = lock user attempts
> unlock_time = unlock


## 19.3. firewall
```
sudo systemctl status ufw
sudo ufw status
sudo ufw app list
ufw --help

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80

sudo ufw enable
sudo ufw status

sudo ufw allow from 10.0.1.10
sudo ufw allow from 10.0.1.0/24

sudo ufw allow from 10.0.1.0/24 to any port 22

sudo ufw deny 81

sudo ufw status numbered
sudo ufw delete 9

sudo ufw disable
sudo ufw reset
```

## 19.4. Hardening
```
# Enforcement and Complain
sudo apparmor_status
```
> Alt: SELinux

# 20. Optional. vm cloud practice
- create a vm
- add a initial script:
  - check if git is installed, if not install it
  - install docker
  - run a hello world container
  - install nginx and installs SSL certificates
