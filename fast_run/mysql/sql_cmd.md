数据库操作

## 基本操作
1.进入数据库
```
mysql -u root -p   
mysql -h localhost -u root -p database_name  
```

2.列出数据库
```
show databases;  
```

3.选择数据库：

```
use databases_name;  
```
4.列出数据表：

```
show tables;  
```

5.显示表格列的属性

```
show columns from table_name;   
describe table_name;  
```

6.导出整个数据库：

```
mysqldump -u user_name -p database_name > /tmp/file_name  
```

例如： `mysqldump -u root -p test_db > d:/test_db.sql`

7.导出一个表：

```
mysqldump -u user_name -p database_name table_name > /tmp/file_name  
```

例如： `mysqldump -u root -p test_db table1 > d:/table1.sql`

8.导出一个数据库结构：

```
mysqldump -u user_name -p -d --add-drop-table database_name > file_name  
```

例如： `mysqldump -u root -p -d --add-drop-table test_db > test_db.sql`

9.导入数据库：

```
source file_name;   
```

或   

```
mysql -u user_name -p database_name < file_name  
```

例如：

```
source /tmp/bbs.sql；
mysql -u root -p bbs < "/tmp/bbs.sql"
```

10.将文本文件导入数据表中（excel与之相同）

```
load data infile "tables.txt" into table table_name;  
```

例如：

```
load data infile "/tmp/bbs.txt" into table bbs；

load data infile "/tmp/bbs.xls" into table bbs；
```

11.将数据表导出为文本文件（excel与之相同）

```
select * into outfile "path_file_name" from table_name;  
```

例如：

```
select * into outfile "/tmp/bbs.txt" from bbs；

select * into outfile "/tmp/bbs.xls" from bbs where id=1;
```

12.创建数据库时先判断数据库是否存在：

```
create database if not exists database_name;  
```

例如： `create database if not exists bbs;`

13.创建数据库：

```
create database database_name;  
```

例如： `create database bbs;`

14.删除数据库：

```
drop database database_name;  
```

例如： `drop database bbs;`

15.创建数据表：

```
create table <table_name> ( <column 1 name> <col. 1 type> <col. 1 details>,<column 2 name> <col. 2 type> <col. 2 details>, ...);  
```

例如： `create table (id int not null auto_increment primary key,name char(16) not null default "jack",date_year date not null);`

16.删除数据表中数据：

```
delete from table_name;  
```

例如：

```
delete from bbs;

delete from bbs where id=2;
```

17.删除数据库中的数据表：

```
drop table table_name;  
```

例如：

```
drop table test_db;
```

```
rm -f database_name/table_name.*  #(linux 环境下）
```

例如：

```
rm -rf bbs/accp.*
```

18.向数据库中添加数据：

```
insert into table_name set column_name1=value1,column_name2=value2;  
```

例如： `insert into bbs set name="jack",date_year="1993-10-01";`

```
insert into table_name values (column1,column2,...);  
```

例如： `insert into bbs ("2","jack","1993-10-02")`

```
insert into table_name (column_name1,column_name2,...) values (value1,value2);  
```

例如：  `insert into bbs (name,data_year) values ("jack","1993-10-01");`

19.查询数据表中的数据：

```
select * from table_name;  
```

例如： `select * from bbs where id=1;`

20.修改数据表中的数据：

```
update table_name set col_name=new_value where id=1;  
```

例如： `update bbs set name="tom" where name="jack";`

21.增加一个字段：

```
alter table table_name add column field_name datatype not null default "1";  
```

例如： `alter table bbs add column tel char(16) not null;`

22.增加多个字段：(column可省略不写）

```
alter table table_name add column filed_name1 datatype,add column filed_name2 datatype;  
```

例如： `alter table bbs add column tel char(16) not null,add column address text;`

23.删除一个字段：

```
alter table table_name drop field_name;  
```

例如： `alter table bbs drop tel;`

24.修改字段的数据类型：

```
alter table table_name modify id int unsigned; //修改列id的类型为int unsigned   
alter table table_name change id sid int unsigned; //修改列id的名字为sid，而且把属性修改为int unsigned  
```

25.修改一个字段的默认值：

```
alter table table_name modify column_name datatype not null default "";  
```

例如： `alter table test_db modify name char(16) default not null "yourname";`

26.对表重新命名：

```
alter table table_name rename as new_table_name;  
```

例如： `alter table bbs rename as bbs_table;`

```
rename table old_table_name to new_table_name;  
```

例如： `rename table test_db to accp;`

27.从已经有的表中复制表的结构：

```
create table table2 select * from table1 where 1<>1;  
```

例如： `create table test_db select * from accp where 1<>1;`

28.查询时间：

```
select now();  
```

29.查询当前用户：

```
select user();  
```

30.查询数据库版本：

```
select version();  
```

31.创建索引：

```
alter table table1 add index ind_id(id);   
```

```
create index ind_id on table1(id);   
```

```
create unique index ind_id on table1(id);//建立唯一性索引  
```

32.删除索引：

```
drop index idx_id on table1;   
```

```
alter table table1 drop index ind_id;  
```

33.联合字符或者多个列（将id与":"和列name和"="连接）

```
select concat(id，':',name,'=') from table;  
```

34.limit（选出10到20条）

```
select * from bbs order by id limit 9,10;  
```

35.增加一个管理员账号：

```
grant all on *.* to user@localhost identified by "password";  
```

36.创建表是先判断表是否存在

```
create table if not exists students(……);  
```

37.复制表：

```
create table table2 select * from table1;  
```

例如： `create table test_db select * from accp;`

38.授于用户远程访问mysql的权限

```
grant all privileges on *.* to "root"@"%" identified by "password" with grant option;  
```

或者是修改mysql数据库中的user表中的host字段

```
use mysql;   
select user,host from user;   
update user set host="%" where user="user_name";  
```

39.查看当前状态

```
show status;  
```
40.查看当前连接的用户

```
show processlist;  
```

## 常用函数 

ifnull

```
ifnull(oracle, nvl) #如果 oracle 字段为 null , 设置为 nvl
```

如 `select ifnull(b,0) from c;`

`sum(...) over( )`  对所有行求和

`sum(...) over( order by ... )`

`sum(...) over( partition by... order by ... )`

数据占的百分:  `percent_rank() over(partition by init_date,interval_type order by drawdown) `   



### 时间比较

- 转成时间戳
    - `unix_timestamp(time1)`  将字符型的时间，转成unix时间戳
- 格式化
    - `Date(time1)` 将 datetime 转成 date
    - `MONTH(time1)`
    - `Year(time1)`
    - `Month(time1)`
- 哪一天
    - `DAYOFWEEK(time1)` , `WEEKDAY(time1)` 0 = 星期一
    - `DAYOFMONTH(time1)`
    - `DAYOFYEAR(time1)`
    - `DAYNAME(time1)` ， `MONTHNAME(time1)` 
- 季度
    - `QUARTER(time1)`
- 日期比较
    - `>` `<` `=` 如 `SELECT NOW() > '2019-09-21 15:59:59';`
    - `between ... and ...` 如 `SELECT NOW() BETWEEN '2019-09-21 15:59:59' AND '2019-10-21 15:59:59' AS res;`
    - `DATEDIFF(time1,time2)` 如 `SELECT DATEDIFF(NOW(),'2019-09-21 15:59:59') > 0;`
- 日期计算
    - 减 `DATE_SUB(CURDATE(),INTERVAL 3 MONTH)`
    - 加 `DATE_ADD(CURDATE(),INTERVAL 3 MONTH)`


## 细节专栏
### DISTINCT
1. 作用于单列

    ```
    select distinct name from A
    ```

2. 作用于多列

    ```
    select distinct name, id from A
    ```
    实际上是根据name和id两个字段来去重的

3. COUNT统计
    ```
    select count(distinct name) from A;
    ```

    count不能统计多个字段, 以下语句 ~~错误~~ : 
    ```
    select count(distinct name, id) from A;
    ```

    若使用嵌套查询，如下：
    ```
    select count(*) from (select distinct xing, name from B) AS M;
    ```

4. distinct必须放在开头

    ```
    select id, distinct name from A;   --会提示错误，因为distinct必须放在开头
    ```

