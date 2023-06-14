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
values('0001' , '���' , '1989-01-01' , '��');
insert into student
values('0002' , '���' , '1990-12-21' , 'Ů');
insert into student
values('0003' , '����' , '1991-12-21' , '��');
insert into student
values('0004' , '��˼��' , '1990-05-20' , '��');
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
values('0001' , '����' , '0002');
insert into course
values('0002' , '��ѧ' , '0001');
insert into course
values('0003' , 'Ӣ��' , '0003');
insert into teacher
values('0001' , '������');
insert into teacher
values('0002' , '����');
-- ����Ľ�ʦ�����ǿ�ֵ��null��
insert into teacher
values('0003' , null);
-- ����Ľ�ʦ�����ǿ��ַ�����''��
insert into teacher
values('0004' , '');

select *from student
select *from teacher
select *from score
select *from course

SELECT *
FROM student
WHERE sname LIKE '��%'

SELECT *
FROM student
WHERE sname LIKE '%��'


SELECT *
FROM student
WHERE sname LIKE '%��%'

SELECT COUNT(*) ������ʦ�ĸ���
FROM teacher
WHERE tname LIKE '��%'

SELECT SUM(degree)�γ̱��Ϊ0002���ܳɼ�
FROM score
WHERE cno = '0002'

SELECT COUNT(*) ѡ�˿γ̵�ѧ������
FROM score
WHERE cno IS NOT NULL

SELECT cno �γ̺�,MAX(degree)��߷�,MIN(degree)��ͷ�
FROM score
GROUP BY cno

SELECT cno,COUNT(*)ѡ�޵�ѧ����
FROM course
GROUP BY cno

SELECT COUNT(sex)��������
FROM student
WHERE sex = '��'
GROUP BY sex
SELECT COUNT(sex)Ů������
FROM student
WHERE sex = 'Ů'
GROUP BY sex

SELECT student.sno,AVG(degree)ƽ���ɼ�
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno
HAVING AVG(degree)>60

SELECT student.sno
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno
HAVING COUNT(score.cno)>=2

SELECT sname,COUNT(sname) ����
FROM student
GROUP BY sname
HAVING COUNT(sname)>=2

SELECT cno
FROM score
WHERE degree<60
ORDER BY cno DESC

SELECT cno,AVG(degree)ƽ���ɼ�
FROM score
GROUP BY cno
ORDER BY AVG(degree)ASC

SELECT sno,degree
FROM score
WHERE cno = '0003' AND degree < 90
ORDER BY degree DESC

SELECT cno �γ̺�,COUNT(cno)ѡ������
FROM course
GROUP BY cno
HAVING COUNT(cno)>2
ORDER BY COUNT(cno)DESC,cno ASC

SELECT score.cno �γ̺�,COUNT(cno)ѡ������
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.cno
HAVING COUNT(score.cno)>=2
ORDER BY COUNT(cno)DESC,cno ASC

SELECT score.sno ѧ��,AVG(degree)ƽ���ɼ�
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.sno,score.cno,score.degree
HAVING COUNT(cno)>2 AND degree > 60

SELECT sno,SUM(degree)�ܳɼ�
FROM score
GROUP BY sno
ORDER BY SUM(degree) DESC

SELECT score.sno ѧ��,student.sname ����
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.sno,score.cno,score.degree,student.sname
HAVING degree > ALL(SELECT degree FROM score WHERE degree <60)

SELECT student.sno ѧ��,sname ����
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno,student.sname
HAVING COUNT(cno) = 2

SELECT *
FROM student
WHERE YEAR(birthday) = '1990'

SELECT cno,MAX(degree)��߳ɼ�
FROM score
GROUP BY cno

SELECT *
FROM student
WHERE MONTH(birthday) = '06'

SELECT student.sno ѧ��,COUNT(cno) ѡ����, SUM(degree)�ܳɼ�
FROM student JOIN score
ON student.sno = score.sno
GROUP BY student.sno

SELECT student.sno,AVG(degree)ƽ���ɼ�
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
WHERE cname = '��ѧ' AND degree < 60

SELECT teacher.tname ��ʦ����,course.cname �γ̺�,AVG(degree)ƽ���ɼ�
FROM teacher JOIN course
ON teacher.tno = course.tno
JOIN score
ON course.cno = score.cno
GROUP BY teacher.tname,course.cname
ORDER BY AVG(degree) DESC

SELECT student.sname ����,course.cname �γ���,score.degree ����
FROM student JOIN score
ON student.sno = score.sno
JOIN course
ON score.cno = course.cno
GROUP BY student.sname,course.cname,score.degree
HAVING degree > 70

SELECT score.sno ѧ��,AVG(degree)ƽ���ɼ�
FROM student JOIN score
ON student.sno = score.sno
GROUP BY score.sno,score.cno,score.degree
HAVING COUNT(cno)>=2 AND degree < 60