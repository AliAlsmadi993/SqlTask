create database relation;
use relation 

create table loginuser(userid int primary key,
username varchar(50) unique,
useremail varchar(50));

create table userdetalse(userid int primary key,
phonenumber int );

create table userdetalsee(userid int primary key,
phonenumber int
foreign key(userid ) references loginuser(userid)on delete cascade);

create table userdetal(userid int ,
phonenumber int
foreign key(userid ) references loginuser(userid)on delete cascade);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

create table studentcourse (
 CourseID INT,
  StudentID INT,
  primary key(CourseID,StudentID),
  foreign key (StudentID) references Students on delete cascade,
  foreign key  (CourseID) references courses on delete cascade
  );
  
  select*from studentcourse;
  
