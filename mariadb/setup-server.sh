
if [ -e /.database-created ]; then
	exit
fi

/usr/bin/mysqld_safe &

random_password() {
	cat /dev/urandom | tr -cd '[:alnum:]' | head -c 32
}

echo "sleeping 10s..."
sleep 10s

admin_password=$(random_password)

# from tutum-docker-mysql
RET=1
while [[ RET -ne 0 ]]; do
	sleep 5
	mysql -uroot -e "grant all privileges on *.* to 'admin'@'%' identified by '$admin_password' with grant option"
	RET=$?
done

echo "'admin' user password: $admin_password"

mysqladmin -uroot shutdown

touch  /.database-created

ls -laShrt /var/lib/mysql
