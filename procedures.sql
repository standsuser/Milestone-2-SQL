CREATE PROC UserRegister --1a 
@usertype varchar(20),
@username varchar(20), 
@email varchar(50) , 
@first_name varchar(20),
@last_name varchar(20), 
@birth_date datetime, 
@GPA decimal(3,2), 
@semester int, 
@address varchar(100), 
@faculty_code varchar(10), 
@major_code varchar(10), 
@company_name varchar(20),
@representative_name varchar(20), 
@representative_email varchar(50), 
@phone_number varchar(20),
@country_of_residence varchar(20)

AS

declare @users_id int
declare @password varchar(10) 

IF @usertype = 'Students'
BEGIN 
 INSERT INTO users(username, email, user_role, phone_number)
	VALUES (@username, @email, @usertype, @phone_number)

	set @users_id = (select max(users_id) from users)
	set @password = (select max(users_id) from users)
	
INSERT INTO student(student_id, first_name, last_name, major_code, date_of_birth,adress, semester, gpa)
	VALUES(@users_id, @first_name, @last_name,@major_code, @birth_date,@address, @semester, @gpa )
	
	update users set user_password = @password where @users_id = users_id

END

IF @usertype = 'Companies'

BEGIN
 INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)

   set @users_id = (select max(users_id) from users)
   set @password = (select max(users_id) from users)

INSERT INTO company(company_id, company_name, representative_name, representative_email, company_location )
    	VALUES (@users_id, @company_name, @representative_name, @representative_email, @address)

	update users set user_password = @password where @users_id = users_id

END

IF @usertype = 'Teaching assistants'
BEGIN
 INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)

    SET @users_id = (SELECT max(users_id) FROM users)
    SET @password = (SELECT max(users_id) FROM users)

 INSERT INTO teaching_assistant(teaching_assistant_id)
    VALUES (@users_id)

	update users set user_password = @password where @users_id = users_id

END

IF @usertype = 'External examiners'
BEGIN 
    INSERT INTO users(username,email, user_role, phone_number)
        VALUES (@username, @email, @usertype, @phone_number)

    SET @users_id = (SELECT max(users_id) FROM users)
    SET @password = (SELECT max(users_id) FROM users)

    INSERT INTO external_examiner(external_examiner_id)
        VALUES (@users_id)
	
	update users set user_password = @password where @users_id = users_id
END

IF @usertype = 'Coordinators'
    BEGIN 
    INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)
    SET @users_id = (SELECT max(users_id) FROM users)
    SET @password = (SELECT max(users_id) FROM users)
    INSERT INTO coordinator(coordinator_id)
        VALUES (@users_id)

	update users set user_password = @password where @users_id = users_id
END

IF @usertype = 'Lecturers'
    BEGIN 
    INSERT INTO users(username, email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)
	SET @users_id = (SELECT max(users_id) FROM users)
	SET @password = (SELECT max(users_id) FROM users)

    INSERT INTO lecturer (lecturer_id) VALUES (@users_id)


	update users set user_password = @password where @users_id = users_id
END
GO


--DROP PROC UserRegister 
/*EXEC UserRegister @usertype='Lecturer',@username='userlecx' ,@email ='testlec.com', @first_name ='mariam',@last_name ='mohamed',@birth_date = '3/3/2003',@GPA = 0.7, @semester =3, @address ='maadi', @major_code = 123,

@faculty_code =NULL, 
@company_name =NULL,
@representative_name = NULL, 
@representative_email =NULL, 
@phone_number =NULL,
@country_of_residence =NULL*/
CREATE PROC LoginHelper
@email VARCHAR(50),
@password VARCHAR(10)

as
declare @tmp_id INT
IF EXISTS(SELECT @tmp_id as users_id  FROM users WHERE email = @email and user_password = @password)
    BEGIN 
    SET @tmp_id=(SELECT users_id  FROM users WHERE email = @email and user_password = @password)
    END
ELSE
    SET @tmp_id=-1
    SELECT 'Return' = @tmp_id
GO

CREATE PROC UserLogin --2a
@email VARCHAR(50),
@password VARCHAR(10)

as
declare @success bit 
declare @tmp_id INT
IF EXISTS(SELECT @tmp_id as users_id  FROM users WHERE email = @email and user_password = @password)
    BEGIN 
        SET @success = 1
    END
ELSE 
    SET @success = 0
    SELECT 'Return' = @success
    EXEC LoginHelper @email=@email, @password = @password

GO


--drop proc UserLogin drop proc LoginHelper

--exec UserLogin @email='card@gmail.com', @password=1036

CREATE PROC ViewProfile --2b
@user_id int
as
select users_id,username,email,user_role,phone_number from users where @user_id = users_id
go

--drop proc ViewProfile
--EXEC ViewProfile @user_id = 1


CREATE PROC ViewBachelorProjects--2c
@user_id int,
@project_type varchar(20)
as
if @user_id is null and @project_type is null
begin
select * from bachelor_project 

end

else
if @project_type is null and @user_id is not null
begin 
select * from bachelor_project  

end

else if @project_type = 'industrial'
begin 
select * from bachelor_project  inner join industrial on code = industrial_code where @user_id = lecturer_id or @user_id = staff_id or @user_id = company_id
end
else if @project_type = 'academic'
begin
select * from bachelor_project  inner join academic on code = academic_code where @user_id = lecturer_id or @user_id = teaching_assistant_id or @user_id = external_examiner_id
end
go

--drop proc ViewBachelorProjects
--EXEC ViewBachelorProjects @project_type= 'academic' , @user_id =3
--EXEC ViewBachelorProjects @project_type= null , @user_id =3

--start of task 3

CREATE PROC MakePreferencesLocalProject--3a
@student_id int,
@bachelor_code varchar(10),
@preference_number int
as
insert into student_preferences(student_id, preference_number, project_code)
    values (@student_id, @preference_number, @bachelor_code)

go


--EXEC MakePreferencesLocalProject @student_id=1, @bachelor_code=1, @preference_number=90



create proc ViewMyThesis
@sid int, @title varchar(50)
as

if (exists(select *
FROM grade_academic_thesis
where grade_academic_thesis.student_id=@sid AND grade_academic_thesis.title=@title))
BEGIN

Update thesis
SET thesis.total_grade=((select grade_academic_thesis.external_examiner_grade
FROM grade_academic_thesis
where grade_academic_thesis.student_id=@sid AND grade_academic_thesis.title=@title)+(select grade_academic_thesis.lecturer_grade
FROM grade_academic_thesis
where grade_academic_thesis.student_id=@sid AND grade_academic_thesis.title=@title))/2
Where thesis.student_id=@sid AND thesis.title=@title


END
else if (exists(select *
FROM grade_industrial_thesis
where student_id=@sid AND  title=@title) )
BEGIN
Update thesis
SET thesis.total_grade=((select grade_industrial_thesis.company_grade
FROM grade_industrial_thesis
where  grade_industrial_thesis.student_id=@sid AND grade_industrial_thesis.title=@title)+(select grade_industrial_thesis.staff_grade
FROM grade_industrial_thesis
where grade_industrial_thesis.student_id=@sid AND grade_industrial_thesis.title=@title))/2
Where thesis.student_id=@sid AND thesis.title=@title
END
SELECT *
From thesis
Where thesis.student_id=@sid AND thesis.title=@title
go

--drop proc ViewMyThesis

--EXEC ViewMyThesis @sid=27, @title = 'Study on X'
--EXEC ViewMyThesis @sid=25, @title = 'Mechanical Uses'

CREATE PROC SubmitMyThesis--3c
@student_id int,
@title varchar(50),
@pdf_doc varchar(1000)
as
insert into thesis(student_id, title, pdf_doc)
    values (@student_id, @title, @pdf_doc)
go

--EXEC SubmitMyThesis @student_id=1, @title = 'test test' , @pdf_doc='pdfpdfpdfpdf'


CREATE PROC ViewMyProgressReport--3d
@student_id int,
@date datetime
as
declare @lecturer_grade int
declare @company_grade int

select @lecturer_grade = lecturer_grade from grade_academic_progress_report where @student_id = student_id
select @company_grade = company_grade from grade_industrial_progress_report where @student_id = student_id

if @date is null AND @student_id is not null
begin


if (exists(select *
FROM grade_academic_progress_report
where grade_academic_progress_report.student_id=@student_id))
BEGIN
update progress_report set grade = @lecturer_grade  where @student_id = student_id 

select * from progress_report where @student_id = student_id order by progress_report_date asc
end

else if (exists(select *
FROM grade_industrial_progress_report
where grade_industrial_progress_report.student_id=@student_id))
BEGIN
select @lecturer_grade = lecturer_grade from grade_industrial_progress_report where @student_id = student_id
update progress_report set grade = (@lecturer_grade +@company_grade) /2  where @student_id = student_id 

select * from progress_report where @student_id = student_id order by progress_report_date asc
end
end

else if @date is not null AND @student_id is not null
begin


if (exists(select *
FROM grade_academic_progress_report
where grade_academic_progress_report.student_id=@student_id  AND grade_academic_progress_report.progress_report_date=@date))
BEGIN
update progress_report set grade = @lecturer_grade where @student_id = student_id AND  @date = progress_report_date

select * from progress_report where @student_id = student_id and @date = progress_report_date order by progress_report_date asc
end

else if (exists(select *
FROM grade_industrial_progress_report
where grade_industrial_progress_report.student_id=@student_id AND grade_industrial_progress_report.progress_report_date=@date))
BEGIN
select @lecturer_grade = lecturer_grade from grade_industrial_progress_report where @student_id = student_id
update progress_report set grade = (@lecturer_grade +@company_grade) /2 where @student_id = student_id AND  @date = progress_report_date

select * from progress_report where @student_id = student_id and @date = progress_report_date order by progress_report_date asc
end

end
go

--EXEC ViewMyProgressReport @student_id=1 , @date='9/7/2022'
--EXEC ViewMyProgressReport @student_id=25 , @date=null
--drop proc ViewMyProgressReport


CREATE PROC ViewMyDefense--3e
@student_id int
as

if (exists(select *
FROM grade_academic_defense
where student_id=@student_id))
BEGIN

Update defense
SET defense.total_grade=((select grade_academic_defense.external_examiner_grade
FROM grade_academic_defense
where grade_academic_defense.student_id=@student_id)+(select grade_academic_defense.lecturer_grade
FROM grade_academic_defense
where grade_academic_defense.student_id=@student_id))/2
Where defense.student_id=@student_id


END

else if (exists(select *
FROM grade_industrial_defense
where student_id=@student_id) )
BEGIN
Update defense
SET defense.total_grade=((select grade_industrial_defense.company_grade
FROM grade_industrial_defense
where  grade_industrial_defense.student_id=@student_id)+(select grade_industrial_defense.employee_grade
FROM grade_industrial_defense
where grade_industrial_defense.student_id=@student_id))/2
Where defense.student_id=@student_id
END
SELECT *
From defense
Where defense.student_id=@student_id 
go


--drop proc ViewMyDefense
--EXEC ViewMyDefense @student_id=25

CREATE PROC UpdateMyDefense--3f
@student_id int,
@defense_content varchar(1000)
as
update defense set content = @defense_content where @student_id = student_id
go


--EXEC UpdateMyDefense @student_id=1 , @defense_content='newest content'

CREATE PROC ViewMyBachelorProjectGrade--3g
@student_id int
as
declare  @bachelor_grade decimal(4,2) 


declare @thesis_grade decimal
declare @defense_grade decimal
declare @cprg decimal

select @thesis_grade = total_grade  from thesis where @student_id = student_id 
select @defense_grade =total_grade from defense where @student_id = student_id
select @cprg= grade from progress_report where @student_id = student_id

if @cprg is null or @defense_grade is null or @thesis_grade is null
update student set TotalBachelorGrade =  null where  student_id=@student_id


else 
update student set TotalBachelorGrade =  (0.3*@thesis_grade) + (0.3*@defense_grade) + (0.4*@cprg) where student_id=@student_id

select TotalBachelorGrade from student where student_id=@student_id

go

--drop proc ViewMyBachelorProjectGrade
--EXEC ViewMyBachelorProjectGrade @student_id=27

CREATE PROC ViewNotBookedMeetings--3h
@student_id int
as
--use inner not in  join to get all meetings with no student attendents 
--query of meetings with attendents and query of meetings with student attendents 

SELECT meeting.*
FROM meeting
INNER JOIN meeting_attendents
ON meeting.meeting_id = meeting_attendents.meeting_id

WHERE (( attendant_id  ) 
NOT IN(SELECT student_id FROM student)) OR ((meeting.meeting_id) NOT IN(select meeting_attendents.meeting_id from meeting_attendents))
ORDER BY meeting_date
go

--drop proc ViewNotBookedMeetings
--EXEC ViewNotBookedMeetings @student_id=24



CREATE PROC BookMeeting --3i 
 @sid int,
 @meeting_id int
as

IF EXISTS(select meeting_id from meeting where @meeting_id = meeting.meeting_id)
BEGIN
INSERT INTO meeting_attendents(meeting_id,attendant_id) VALUES (@meeting_id,@sid)
end
go

--drop proc BookMeeting
--EXEC BookMeeting @sid= 23 , @meeting_id= 1
--EXEC BookMeeting @sid= 23 , @meeting_id= 5

CREATE PROC ViewMeeting --3j
@meeting_id int,
@sid int
as 
IF(@meeting_id is null)
    begin
        Select * from meeting INNER JOIN meeting_attendents 
        ON meeting.meeting_id = meeting_attendents.meeting_id
        where (attendant_id= @sid)  

    end
ELSE begin
        SELECT * from meeting INNER JOIN meeting_attendents
        ON meeting.meeting_id = meeting_attendents.meeting_id
        where (attendant_id= @sid and meeting.meeting_id=@meeting_id) 
         


    end

go

--drop proc ViewMeeting
--EXEC ViewMeeting @meeting_id=null,@sid=1
--EXEC ViewMeeting @meeting_id=1,@sid=1


CREATE PROC StudentAddToDo --3k
@meeting_id int,
@to_do_list varchar(200)
as
IF EXISTS(select meeting_id from meeting where @meeting_id = meeting_id)
    BEGIN
            INSERT INTO meeting_to_do_list(meeting_id ,to_do_list) values (@meeting_id, @to_do_list)
    END
GO

--drop proc StudentAddToDo
--EXEC StudentAddToDo @meeting_id=1, @to_do_list='hi i am new'


--start of 4
CREATE PROC AddEmployee--4a

@CompanyID int ,
@email varchar(50), 
@name varchar(20), 
@phone_number varchar(20),
@field varchar(25)

as
if exists(select company_id from company where @CompanyID = company_id)
begin
insert into users(username,email,user_role,phone_number)
values(@name, @email, 'Employee', @phone_number)

declare @staffid int = (select max(users_id) from users)

update users set user_password=@staffid WHERE users_id=@staffid
insert into employee(company_id,staff_id, email, phone, field, employee_password,username)
values(@CompanyID, @staffid, @email, @phone_number, @field, @staffid, @name)
select staff_id, employee_password,company_id from employee where email = @email


end

go

--drop proc AddEmployee

--exec AddEmployee @CompanyID=7,@email='hique555i@gmail.com',@name='haisan',@phone_number=209282,@field='CS'

CREATE PROC CompanyCreateLocalProject--4b
@company_id int,
@proj_code varchar(10),
@title varchar(50),
@description varchar(200),
@major_code varchar(10)
as
if exists(select company_id from company where company_id = @company_id)
begin
insert into bachelor_project(code, project_name, pdescription)
values(@proj_code, @title, @description)

insert into industrial(industrial_code, company_id)
values(@proj_code, @company_id) 

insert into major_has_bachelor_project(major_code, project_code)
values(@major_code, @proj_code)
end
go

--drop proc CompanyCreateLocalProject

CREATE PROC AssignEmployee--4c
@bachelor_code varchar(10), 
@staff_id int, 
@Company_id int
as
if exists(select company_id from company where @Company_id = company_id)
begin
update industrial set staff_id = @staff_id where @bachelor_code =industrial_code and company_id = @Company_id
end

select * from industrial inner join bachelor_project on industrial_code=code where staff_id=@staff_id

go

--drop proc AssignEmployee
--exec AssignEmployee @bachelor_code=9 , @staff_id=65, @Company_id=11

CREATE PROC CompanyGradeThesis--4d
@Company_id int, 
@sid int, 
@thesis_title varchar(50), 
@Company_grade Decimal(4,2)
as
if exists(select company_id from company where @Company_id = company_id)
begin 
update grade_industrial_thesis set company_grade = @Company_grade where
student_id = @sid and @thesis_title = title
end

go

CREATE PROC CompanyGradedefense--4e
@Company_id int, 
@sid int, 
@defense_location varchar(5), 
@Company_grade Decimal(4,2)
as
if exists(select company_id from company where @Company_id = company_id)
begin
update grade_industrial_defense set company_grade = @Company_grade where
student_id = @sid and @defense_location = defense_location
end

go

CREATE PROC CompanyGradePR--4f
@Company_id int, 
@sid int, 
@date datetime, 
@Company_grade decimal(4,2)
as
if exists(select company_id from company where @Company_id = company_id)
begin
update grade_industrial_progress_report set company_grade = @Company_grade
where @sid = student_id and @date = progress_report_date
end

go

--EXEC CompanyGradePR @Company_id=11, @sid=23, @date=4/7/2023, @Company_grade=45
--5 starts


CREATE PROC LecturerCreateLocalProject --5a
    @Lecturer_id int, 
    @proj_code varchar(10), 
    @title varchar(50), 
    @description varchar(200),
    @major_code varchar(10)
as
IF EXISTS(select lecturer_id from lecturers where @Lecturer_id = lecturer_id)
    BEGIN
        INSERT INTO bachelor_project (code,project_name, pdescription)
            values (@proj_code, @title, @description)
        INSERT INTO major_has_bachelor_project(major_code ,project_code )
            values (@major_code, @proj_code)
    END
GO

CREATE PROC SpecifyThesisDeadline --5b
    @deadline datetime
as 
declare @tmp_id INT
    UPDATE thesis SET deadline = @deadline
IF EXISTS(SELECT @tmp_id as student_id  FROM student WHERE NOT EXISTS(select student_id FROM thesis ))
    BEGIN 
        INSERT INTO thesis(deadline,student_id) values (@deadline,@tmp_id)
    END
GO


CREATE PROC CreateMeeting --5c
@Lecturer_id int, 
@start_time datetime, 
@end_time datetime, 
@date datetime, 
@meeting_point varchar(5)
as
IF EXISTS(select lecturer_id from lecturers where @Lecturer_id = lecturer_id)
    BEGIN
        INSERT INTO meeting(meeting_point ,lecturer_id ,meeting_date ,start_time ,end_time)
            values (@meeting_point, @Lecturer_id, @date , @start_time, @end_time)

    END
GO


CREATE PROC LecturerAddToDo --5d
@meeting_id int,
@to_do_list varchar(200)
as
IF EXISTS(select meeting_id from meeting where @meeting_id = meeting_id)
    BEGIN

            INSERT INTO meeting_to_do_list(meeting_id ,to_do_list) values (@meeting_id, @to_do_list)
    END
GO
--drop proc LecturerAddToDo


CREATE PROC ViewMeetingLecturer --5e
@Lecturer_id int, 
@meeting_id int
as

IF EXISTS(select lecturer_id from lecturers where @Lecturer_id = lecturer_id) 
    BEGIN
        IF (@meeting_id = null)
            BEGIN
           
            SELECT * FROM meeting WHERE EXISTS(select attendant_id from meeting_attendents where attendant_id=@lecturer_id)
            ORDER BY meeting_date
            END
        ELSE
            SELECT * FROM meeting WHERE EXISTS(select attendant_id from meeting_attendents where attendant_id=@lecturer_id and meeting_id=@meeting_id)
                ORDER BY meeting_date
    END
GO


CREATE PROC ViewEE --5f
as

SELECT * 
FROM external_examiner 
WHERE NOT EXISTS 
    (SELECT * 
     FROM lecturer_recommend_external_examiner 
     WHERE external_examiner.external_examiner_id = lecturer_recommend_external_examiner.external_examiner_id)
GO

--EXEC ViewEE 
--DROP PROC ViewEE


CREATE PROC RecommendEE --5g
@Lecturer_id int, 
@proj_code varchar(10), 
@EE_id int
as
INSERT into lecturer_recommend_external_examiner(lecturer_id ,external_examiner_id ,project_code )
VALUES  (@Lecturer_id, @EE_id, @proj_code)
GO

--EXEC RecommendEE @Lecturer_id = 9 , @proj_code = 7, @EE_id =16

CREATE PROC SuperviseIndustrial --5h
@Lecturer_id int, 
@proj_code varchar(10)
AS

IF EXISTS(select industrial_code from industrial where @proj_code = industrial_code) 
    BEGIN
            UPDATE industrial
            SET lecturer_id = @Lecturer_id
            WHERE industrial_code= @proj_code 
    END
ELSE


INSERT INTO industrial(industrial_code,lecturer_id)
VALUES (@proj_code, @Lecturer_id)
GO

--EXEC SuperviseIndustrial @Lecturer_id = 3, @proj_code=2

CREATE PROC LecGradeThesis --5i
@Lecturer_id int, 
@sid int, 
@thesis_title varchar(50), 
@Lecturer_grade Decimal(4,2)

as
IF EXISTS(select lecturer_id from lecturer where @Lecturer_id = lecturer_id) 
    BEGIN
        IF EXISTS(select student_id from grade_academic_thesis where lecturer_id=@Lecturer_id and student_id=@sid and title=@thesis_title)
            BEGIN
                UPDATE grade_academic_thesis
                SET lecturer_grade= @Lecturer_grade
                where lecturer_id=@Lecturer_id and student_id=@sid and title=@thesis_title
            END
        ELSE
        INSERT into grade_academic_thesis(lecturer_id, student_id, title, lecturer_grade)
        VALUES (@Lecturer_id, @sid, @thesis_title, @Lecturer_grade)
    END
GO

--EXEC LecGradeThesis @Lecturer_id = 3, @sid =26 , @thesis_title = 'Study on X' , @Lecturer_grade = 80
--drop Proc LecGradeThesis

CREATE PROC LecGradedefense --5j
 @Lecturer_id int,
 @sid int, 
 @defense_location varchar(5),
 @Lecturer_grade Decimal(4,2)

 as
IF EXISTS(select lecturer_id from lecturer where @Lecturer_id = lecturer_id) 
    BEGIN
        IF EXISTS(select student_id from grade_academic_defense where lecturer_id=@Lecturer_id and student_id=@sid and defense_location=@defense_location)
            BEGIN
                UPDATE grade_academic_defense
                SET lecturer_grade= @Lecturer_grade
                where lecturer_id=@Lecturer_id and student_id=@sid and defense_location=@defense_location
            END
        ELSE
        INSERT into grade_academic_defense(lecturer_id, student_id, defense_location, lecturer_grade)
        VALUES (@Lecturer_id, @sid, @defense_location, @Lecturer_grade)
    END
GO

--EXEC LecGradedefense @Lecturer_id = 3, @sid =26 , @defense_location = 's334' , @Lecturer_grade = 80


CREATE PROC LecCreatePR--5k
@Lecturer_id int, 
@sid int, 
@date datetime,
@content varchar(1000)
as
    IF EXISTS(select lecturer_id from lecturer where @Lecturer_id = lecturer_id) 
        begin
        insert into progress_report(student_id, progress_report_date, updating_user_id, content)
        values(@sid,@date,@Lecturer_id, @content)
        end
go

--EXEC LecCreatePR @Lecturer_id = 10, @sid =26, @date = '2022-7-6', @content = 'content of prog report'



CREATE PROC LecGradePR--5l
    @Lecturer_id int,
    @sid int, 
    @date datetime,
    @lecturer_grade decimal(4,2)
as 
    IF EXISTS(select lecturer_id from lecturer where @Lecturer_id = lecturer_id) 
        begin 
        IF EXISTS(select Assigned_Project_Code from student where student_id=@sid and exists(select academic_code from academic where academic_code= Assigned_Project_Code))
            begin
            update grade_academic_progress_report
            SET lecturer_grade= @Lecturer_grade , progress_report_date = @date
             where lecturer_id=@Lecturer_id and student_id=@sid
             end
        end
go

--EXEC LecGradePR @Lecturer_id = 9, @sid =28, @date = '2022-9-4', @lecturer_grade = 77



--start of 6
CREATE PROC TACreatePR --6a
@student_id int,
@teaching_assistant_id int,
@date datetime,
@content varchar(1000)
as
if exists(select teaching_assistant_id from teaching_assistant where teaching_assistant_id = @teaching_assistant_id)
begin
insert into progress_report(student_id, content, updating_user_id, progress_report_date)
values (@student_id, @content, @teaching_assistant_id, @date)
end
go

--EXEC TACreatePR @student_id = 1,@teaching_assistant_id =2,@date = '2003-6-7',@content = 'A+ progress report content'



CREATE PROC TAAddToDo --6b
@meeting_id int,
@to_do_list varchar(200)
as
insert into meeting_to_do_list(meeting_id, to_do_list)
values(@meeting_id, @to_do_list)
go

--EXEC TAAddToDo @meeting_id=4 , @to_do_list = 'the todolist for today'


--start of 7
CREATE PROC EEGradeThesis--7a
@EE_id int,
@sid int,
@thesis_title varchar(50),
@EE_grade decimal(4,2)
as
if exists(select external_examiner_id from external_examiner where @EE_id = external_examiner_id)
    begin 


    IF EXISTS(select student_id from grade_academic_thesis where external_examiner_id=@EE_id and student_id=@sid and title=@thesis_title)
        begin
            update grade_academic_thesis set external_examiner_grade = @EE_grade
            where student_id = @sid and title = @thesis_title 
        end
    ELSE
        INSERT into grade_academic_thesis(external_examiner_id, student_id, title, external_examiner_grade)
        VALUES (@EE_id, @sid, @thesis_title, @EE_grade)
    end
GO

--EXEC EEGradeThesis @EE_id = 6, @sid =26 , @thesis_title = 'Study on X' , @EE_grade = 60

CREATE PROC EEGradeDefense--7b
@EE_id int,
@sid int,
@defense_location varchar(5),
@EE_grade decimal(4,2)
as
if exists(select external_examiner_id from external_examiner where @EE_id = external_examiner_id)
    begin
    IF EXISTS(select student_id from grade_academic_defense where external_examiner_id=@EE_id and student_id=@sid and defense_location=@defense_location)
        begin
            update grade_academic_defense set external_examiner_grade = @EE_grade
            where student_id = @sid and defense_location = @defense_location
        end
    ELSE
        INSERT into grade_academic_defense(external_examiner_id, student_id, defense_location, external_examiner_grade)
        VALUES (@EE_id, @sid, @defense_location, @EE_grade)
    end
GO


--EXEC EEGradeDefense @EE_id = 6, @sid =26 , @defense_location = 's334' , @EE_grade = 80


--start of 8
CREATE PROC ViewUsers--8a
@User_type varchar(20), 
@User_id int
as
select * from users where @User_id = users_id
if(@User_type = 'Students')
begin
select * from student where @User_id = student_id
end
else if (@User_type = 'Companies')
begin 
select * from company where @User_id = company_id
end
else if (@User_type = 'Teaching assistants')
begin 
select * from teaching_assistant where @User_id = teaching_assistant_id
end
else if (@User_type = 'External examiners')
begin
select * from external_examiner where @User_id = external_examiner_id
end
else if (@User_type = 'Coordinator')
begin
select * from coordinator where @User_id = coordinator_id
end
else if (@User_type = 'Lecturers')
begin
select * from lecturer where @User_id = lecturer_id
end

go

CREATE PROC AssignAllStudentsToLocalProject--8b CHANGES HERE
as

DECLARE @counter INT = 1
DECLARE @RowCnt INT
declare @tmpid int
declare @tmpcode int

SELECT student_preferences.student_id ,preference_number ,project_code
INTO atmptable
FROM student_preferences inner join student
on student_preferences.student_id = student.student_id
order by student_preferences.preference_number DESC  , student.gpa ASC


SELECT @RowCnt = COUNT(student_id) FROM atmptable

WHILE (@counter <= @RowCnt)
BEGIN

    set @tmpid = (SELECT student_id 
FROM (
    SELECT student_id, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM atmptable
) AS tmptable
WHERE tmptable.RowNum = 1)

set @tmpcode = (
    SELECT project_code 
FROM (
    SELECT project_code, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM atmptable
) AS tmptable2
WHERE tmptable2.RowNum = 1)

        update student
        set Assigned_Project_Code =  @tmpcode WHERE student.student_id = @tmpid

  DELETE FROM atmptable WHERE student_id = @tmpid 
    DELETE FROM atmptable WHERE project_code = @tmpcode 
   SET @counter = @counter + 1 
END

    drop table atmptable

SELECT s.student_id, bp.code,bp.project_name, bp.pdescription, bp.submitted_materials
FROM student s INNER JOIN bachelor_project bp
ON s.Assigned_Project_Code = bp.code
GO



--drop proc AssignAllStudentsToLocalProject

--EXEC AssignAllStudentsToLocalProject




CREATE PROC AssignTAs --8c CHANGES HERE
@coordinator_id int, 
@TA_id int, 
@proj_code varchar(10)
as
if exists(select coordinator_id from coordinator where @coordinator_id = coordinator_id)
begin
update academic set teaching_assistant_id = @TA_id where academic_code = @proj_code 
end
go

--drop proc AssignTAs


CREATE PROC ViewRecommendation--8d CHANGES HERE
@lecturer_id int
as
select lecturer_id, external_examiner_id from lecturer_recommend_external_examiner WHERE @lecturer_id = lecturer_id ORDER BY lecturer_id ASC

go

--drop proc ViewRecommendation


CREATE PROC AssignEE--8e CHANGES HERE
@coordinator_id int, 
@EE_id int, 
@proj_code varchar(10)
as
if exists(select coordinator_id from coordinator where coordinator_id = @coordinator_id)
begin
update academic set external_examiner_id = @EE_id where academic_code = @proj_code
end
go

--drop proc AssignEE

CREATE PROC ScheduleDefense--8f
@sid int, 
@date datetime, 
@time time, 
@location varchar(5)
as
update defense set defense_date = @date where @sid = student_id
update defense set defense_time = @time where @sid = student_id
update defense set defense_location = @location where @sid = student_id

go
CREATE PROC EmployeeGradeThesis --9a
@Employee_id int, 
@sid int, 
@thesis_title varchar(50), 
@Employee_grade Decimal(4,2)
as
if exists(select staff_id from employee where staff_id = @Employee_id)
begin
update grade_industrial_thesis set staff_grade = @Employee_grade
where @sid = student_id and @thesis_title = title
end

go

CREATE PROC EmployeeGradedefense --9b
@Employee_id int, 
@sid int, 
@defense_location varchar(5), 
@Employee_grade Decimal(4,2)
as
if exists(select staff_id from employee where staff_id = @Employee_id)
begin
update grade_industrial_defense set employee_grade = @Employee_grade
where @sid = student_id and @defense_location = defense_location
end


go


CREATE PROC EmployeeCreatePR --9c
@Employee_id int, 
@sid int, 
@date datetime, 
@content varchar(1000)
as
if exists(select staff_id from employee where staff_id = @Employee_id)
begin
insert into progress_report(student_id, content, progress_report_date, updating_user_id)
values(@sid, @content, @date, @Employee_id)
end

go

