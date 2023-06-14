CREATE DATABASE Test1
USE Test1
create table student(
sno varchar(10) not null primary key,
sname varchar(10),
birthday date,
sex varchar(10)
)
create table score(
sno varchar(10) not null,
cno varchar(10) not null,
degree int,
primary key(sno, cno)
)
create table course(
cno varchar(10) not null primary key,
cname varchar(10),
tno varchar(10)
)
create table teacher(
tno varchar(10) not null primary key,
tname varchar(10)
)

insert into student
values('0001' , '猴哥' , '1989-01-01' , '男');
insert into student
values('0002' , '猴哥' , '1990-12-21' , '女');
insert into student
values('0003' , '马云' , '1991-12-21' , '男');
insert into student
values('0004' , '王思聪' , '1990-05-20' , '男');
--alter table score add degree int
insert into score
values('0001' , '0001' , 80);
insert into score
values('0001' , '0002' , 90);
insert into score
values('0001' , '0003' , 99);
insert into score
values('0002' , '0002' , 60);
insert into score
values('0002' , '0003' , 55);
insert into score
values('0003' , '0001' , 42);
insert into score
values('0003' , '0002' , 59);
insert into score
values('0003' , '0003' , 80);
insert into course
values('0001' , '语文' , '0002');
insert into course
values('0002' , '数学' , '0001');
insert into course
values('0003' , '英语' , '0003');
insert into teacher
values('0001' , '孟扎扎');
insert into teacher
values('0002' , '马化腾');
-- 这里的教师姓名是空值（null）
insert into teacher
values('0003' , null);
-- 这里的教师姓名是空字符串（''）
insert into teacher
values('0004' , '');

select *from student
select *from teacher
select *from score
select *from course

SELECT *
FROM student
WHERE sname LIKE '猴%'

SELECT *
FROM student
WHERE sname LIKE '%猴'


SELECT *
FROM student
WHERE sname LIKE '%猴%'

SELECT COUNT(*) 姓孟老师的个数
FROM teacher
WHERE tname LIKE '孟%'

SELECT SUM(degree)课程编号为0002的总成绩
FROM score
WHERE cno = '0002'

SELECT COUNT(*) 选了课程的学生人数
FROM score
WHERE cno IS NOT NULL

SELECT cno 课程号,MAX(degree)最高分,MIN(degree)最低分
FROM score
GROUP BY cno

SELECT cno,COUNT(*)选修的学生数
FROM course
GROUP BY cno

SELECT COUNT(sex)男生人数
FROM student
WHERE sex = '男'
GROUP BY sex
SELECT COUNT(sex)女生人数
FROM student
WHERE sex = '女'
GROUP BY sex

SELECT student.sno,AVG(degree)平均成绩
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno
HAVING AVG(degree)>60

SELECT student.sno
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno
HAVING COUNT(score.cno)>=2

SELECT sname,COUNT(sname) 人数
FROM student
GROUP BY sname
HAVING COUNT(sname)>=2

SELECT cno
FROM score
WHERE degree<60
ORDER BY cno DESC

SELECT cno,AVG(degree)平均成绩
FROM score
GROUP BY cno
ORDER BY AVG(degree)ASC

SELECT sno,degree
FROM score
WHERE cno = '0003' AND degree < 90
ORDER BY degree DESC

SELECT cno 课程号,COUNT(cno)选修人数
FROM course
GROUP BY cno
HAVING COUNT(cno)>2
ORDER BY COUNT(cno)DESC,cno ASC

SELECT score.cno 课程号,COUNT(cno)选修人数
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.cno
HAVING COUNT(score.cno)>=2
ORDER BY COUNT(cno)DESC,cno ASC

SELECT score.sno 学号,AVG(degree)平均成绩
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.sno,score.cno,score.degree
HAVING COUNT(cno)>2 AND degree > 60

SELECT sno,SUM(degree)总成绩
FROM score
GROUP BY sno
ORDER BY SUM(degree) DESC

SELECT score.sno 学号,student.sname 姓名
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.sno,score.cno,score.degree,student.sname
HAVING degree > ALL(SELECT degree FROM score WHERE degree <60)

SELECT student.sno 学号,sname 姓名
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno,student.sname
HAVING COUNT(cno) = 2

SELECT *
FROM student
WHERE YEAR(birthday) = '1990'

SELECT cno,MAX(degree)最高成绩
FROM score
GROUP BY cno

SELECT *
FROM student
WHERE MONTH(birthday) = '06'

SELECT student.sno 学号,COUNT(cno) 选课数, SUM(degree)总成绩
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno

SELECT student.sno,AVG(degree)平均成绩
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno
HAVING AVG(degree)>85

SELECT student.sno,sname
FROM student JOIN score
ON student.sno = score.sno
WHERE cno = '0003' AND degree >80
GROUP BY student.sname,student.sno

SELECT *
FROM student JOIN score
ON student.sno = score.sno
JOIN course
ON score.cno = course.cno

SELECT *
FROM score
WHERE cno = '0001' AND degree < 60
ORDER BY degree ASC

SELECT student.sname,degree
FROM student JOIN score
ON student.sno = score.sno
JOIN course
ON score.cno = course.cno
WHERE cname = '数学' AND degree < 60

SELECT teacher.tname 教师名字,course.cname 课程号,AVG(degree)平均成绩
FROM teacher JOIN course
ON teacher.tno = course.tno
JOIN score
ON course.cno = score.cno
GROUP BY teacher.tname,course.cname
ORDER BY AVG(degree) DESC

SELECT student.sname 名字,course.cname 课程名,score.degree 分数
FROM student JOIN score
ON student.sno = score.sno
JOIN course
ON score.cno = course.cno
GROUP BY student.sname,course.cname,score.degree
HAVING degree > 70

SELECT score.sno 学号,AVG(degree)平均成绩
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.sno,score.cno,score.degree
HAVING COUNT(cno)>=2 AND degree < 60