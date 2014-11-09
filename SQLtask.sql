-- Queries are written using MS SQL Server sintax

CREATE DATABASE School

CREATE TABLE Students(
    ID int IDENTITY (1,1) PRIMARY KEY,
    SURNAME nvarchar(50),
    NAME nvarchar(30),
    CLASS int,
    CLASSLETTER nchar(1),
    BIRTHDAY date
);

CREATE TABLE Teachers (
    ID int PRIMARY KEY,
    SURNAME nvarchar(50),
    NAME nvarchar(30),
    MIDNAME nvarchar(30)
);

CREATE TABLE Subjects(
    ID int PRIMARY KEY,
    NAME nvarchar(30),
    CLASS int,
    HOURS int,
    TEACHER_ID int
 CONSTRAINT FK_TEACHERS FOREIGN KEY (TEACHER_ID) REFERENCES TEACHERS(ID)
 ); 


INSERT INTO STUDENTS (SURNAME, NAME, CLASS, CLASSLETTER, BIRTHDAY) 
        VALUES 	('Чернов' , 'Виталий' ,  5, 'А' , '2004-12-05'),
        		('Иванова' , 'Лина' ,    5, 'Б' , '2004-05-11'),	
      	 		('Васильев' , 'Кирилл',  4, 'А' ,  '2005-03-21'),
       			('Луценко' , 'Василиса', 6, 'А' ,  '2003-05-04'),
       			('Иващенко' , 'Ольга' ,  1, 'Б' ,  '2008-12-31'),
       			('Антонова' , 'Елена' ,  1, 'Б' ,  '2008-08-16'),
				('Любченко' , 'Егор' ,   9, 'А' ,  '2000-07-12'),
				('Ильина  ' , 'Ольга' ,  2, 'А' ,  '2007-04-03'),
       			('Артеменко' , 'Иван' ,  3, 'А' ,  '2006-10-15'),
				('Любченко' , 'Ирина' ,  5, 'А' ,  '2004-01-12'),
				('Кащенко' , 'Владимир', 1, 'А' ,  '2008-11-01'),
       			('Масько' , 'Андрей' ,   5, 'Б' ,  '2004-02-16'),
				('Иванов' , 'Сергей' ,   6, 'А' ,  '2003-07-01')


INSERT INTO TEACHERS 
VALUES	 (1, 'Курченко', 'Мария', 'Ивановна'),
		 (2, 'Лукачук', 'Евгений', 'Николаевич'),
		 (3, 'Маевская', 'Людмила', 'Сергеевна'),
		 (4, 'Обломова', 'Люсиль', 'Эдуардовна'),
		 (5, 'Лопух', 'Семен', 'Семенович'),
		 (6, 'Иванченко', 'Шехерезада', 'Степановна')
select * from teachers

INSERT INTO SUBJECTS 
VALUES	(1, 'Математика', 6, 52, 3),
		(2, 'Физкультура', 5, 100, 5),
		(3, 'Английский язык', 6, 56, 2),
		(4, 'Английский язык', 5, 70, 2),
		(5, 'Математика', 6, 52, 3),
		(6, 'Начальная школа', 1, null, 6),
		(7, 'Английский язык', 9, 60, 1),
		(8, 'Математика', 6, 52, 3),
		(9, 'Информатика', 5, 40, 3)


-- Select names, surnames and date of birth of the students that go to primary school (up to 4 class), from youngest to oldest

SELECT NAME, SURNAME, CLASS, CLASSLETTER, CONVERT (varchar(11), BIRTHDAY, 106) [Date of Birth]
 FROM STUDENTS WHERE CLASS < 5 ORDER BY BIRTHDAY DESC

-- Show number of students in every class

SELECT STR(CLASS)+'-'+CLASSLETTER Class, COUNT(*) [Num of Students] 
FROM STUDENTS GROUP BY CLASS, CLASSLETTER
ORDER BY CLASS, CLASSLETTER

-- Select students who have the teacher with the surname 'Лукачук'

SELECT *
FROM STUDENTS
WHERE CLASS IN (SELECT CLASS 
				FROM SUBJECTS SUB 
				JOIN TEACHERS TEACH 
				ON SUB.TEACHER_ID = TEACH.ID
				WHERE TEACH.SURNAME = 'Лукачук')

-- Count rows in all tables

SELECT 'Students' Table_Name, COUNT(*) Rows_Num FROM Students
UNION
SELECT 'Teachers', COUNT(*) FROM Teachers
UNION
SELECT 'Subjects', COUNT(*) FROM Subjects
 
 