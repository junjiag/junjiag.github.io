---
title: 【转】设置本地MySQL允许外部访问的方法
date: 2017-03-19 23:43:50
tags:
- MySQL

---


### 修改配置文件
    sudo vim /etc/mysql/my.cnf
把bind-address参数的值改成你的内/外网IP或0.0.0.0,或者直接注释掉这行.


### 登录数据库
    mysql -u root -p
    #输入密码
    mysql > use mysql;


### 查询host
    mysql> select user,host from user;


### 创建host
    #如果没有"%"这个host值,就执行下面这两句:
    mysql> update user set host='%' where user='root';
    mysql> flush privileges;


### 授权用户
    #任意主机以用户root和密码mypwd连接到mysql服务器
    mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mypwd' WITH GRANT OPTION;
    mysql> flush privileges;
    
    #IP为192.168.1.102的主机以用户myuser和密码mypwd连接到mysql服务器
    mysql> GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.102' IDENTIFIED BY 'mypwd' WITH GRANT OPTION; 
    mysql> flush privileges;



出处：
http://www.cnblogs.com/live41/archive/2013/04/02/2995178.html



