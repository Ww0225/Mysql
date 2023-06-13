CREATE DATABASE Test

CREATE TABLE account(
user_name varchar(20) PRIMARY KEY,
balance float
)
INSERT INTO account VALUES('张三',1000)
INSERT INTO account VALUES('李四',1)

BEGIN TRANSACTION
DECLARE @minNum int
SELECT @minNum = balance FROM account WHERE user_name = '张三'
SET @minNum = @minNum - 1000
IF(@minNum>=0)
BEGIN
	UPDATE account 
	SET balance = balance-1000
	WHERE user_name = '张三'
	UPDATE account
	SET balance = balance+1000
	WHERE user_name = '李四'
	print'交易成功'
	COMMIT TRANSACTION
END
ELSE
BEGIN
	print'余额不够，交易失败'
	ROLLBACK TRANSACTION
END
SELECT *
FROM account

CREATE TRIGGER trig_update
ON account
AFTER update
AS
	IF update(balance)
		BEGIN
			print'抱歉，不允许更新余额'
			ROLLBACK TRANSACTION
		END

UPDATE account 
SET balance = 2000
WHERE user_name = '张三'
SELECT *
FROM account

CREATE TABLE t_users(
id int primary key,
name char(10)
)
CREATE TRIGGER trig_insert
ON t_users
AFTER INSERT
AS
BEGIN
	DECLARE @userNum INT
	SELECT @userNum = (SELECT COUNT(*) FROM t_users)
	IF @userNum>3
	BEGIN
		print'插入失败'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		print'插入成功'
		COMMIT TRANSACTION
	END
END

INSERT INTO t_users VALUES(1,'张三')
INSERT INTO t_users VALUES(2,'李四')
INSERT INTO t_users VALUES(3,'王五')
INSERT INTO t_users VALUES(4,'赵六')
INSERT INTO t_users VALUES(5,'张三')

CREATE TABLE student(
id int primary key,
name varchar(14)
)

CREATE TRIGGER trig_insert_stu
ON student
AFTER INSERT
AS
BEGIN
	DECLARE @nameDest char(10)
	SELECT @nameDest = inserted.name FROM inserted
	IF(SELECT COUNT(name) FROM student WHERE name = @nameDest)>1
		BEGIN
			print'不能插入重复的姓名'
			ROLLBACK TRANSACTION
		END
END

INSERT INTO student VALUES(1,'张三')
INSERT INTO student VALUES(2,'张三')



