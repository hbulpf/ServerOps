for host in $(cat remote-hosts)
do
   ip=$(echo ${host} | cut -f1 -d ":")
   port=$(echo ${host} | cut -f2 -d ":")
   password=$(echo ${host} | cut -f3 -d ":")
　 arg=$(echo -p ${port} -o StrickHostKeyChecking=no root@${ip})
　 echo sshpass -p ${password} ssh-copy-id '"'${arg}'"' >> tmp.sh
done
sh tmp.sh
rm -f tmp.sh