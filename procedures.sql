﻿CREATE PROC UserRegister /*figure out how to return password and user_id and also what to insert in the tables down below (also external supervisor doesnt exist??))*/
@usertype varchar(20),
@username varchar(20), 
@email varchar(50) , /*should i specify unique here or just in the first sql file*/
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
@country_of_residence varchar(20),
@users_id int output,
@password varchar(10) output
/* is this correct? should anything be not null should it be specific with nested ifs? or general?*/
AS
IF @usertype IS NULL or @username IS NULL or @email IS NULL 
print 'One of the main inputs is null'


IF @usertype = 'Students' AND
 (@first_name IS NULL or 
    @last_name IS NULL or 
    @major_code IS NULL or 
    @birth_date IS NULL or 
    @address IS NULL or 
    @semester IS NULL or
    @gpa IS NULL)

print 'One of the student values is null'
ELSE IF @usertype = 'Students'
BEGIN 
INSERT INTO users(user_role, username, email)
    VALUES (@usertype , @username , @email)
INSERT INTO student(first_name, last_name, major_code, date_of_birth,adress, semester, gpa)
    VALUES(@first_name, @last_name,@major_code, @birth_date,@address, @semester, @gpa )
   set @users_id = (select max(users_id) from users)
   set @password = (select max(users_id) from users)
    insert into users(user_password)
    values (@password)
END
IF @usertype = 'Companies' AND
 (@company_name IS NULL or 
@representative_name IS NULL or 
@representative_email IS NULL or 
@address IS NULL)  /*is location of company the address?*/

    print 'One of the company values is null' 

ELSE IF @usertype = 'Companies'

BEGIN
INSERT INTO users(user_role, username, email)
    VALUES (@usertype ,  @username , @email)
INSERT INTO company(company_name, representative_name, representative_email, company_location )
    VALUES (@company_name, @representative_name, @representative_email, @address)

   set @users_id = (select max(users_id) from users)
   set @password = (select max(users_id) from users)
    insert into users(user_password)
    values (@password)
END
IF @usertype = 'Teaching assistants' and @username is null or @email is null or @usertype is null or  @phone_number is null

    print 'One of the TA values is null'

ELSE IF @usertype = 'Teaching assistants'
BEGIN
 INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)
    SET @users_id = (SELECT max(users_id) FROM users)
    SET @password = (SELECT max(users_id) FROM users)
 INSERT INTO teaching_assistant(teaching_assistant_id)
    VALUES (@users_id)
 INSERT INTO users(user_password)
    VALUES (@password)


END
IF @usertype = 'External examiners' and @username is null or @email is null or @usertype is null or  @phone_number is null

    print 'One of the external_examiner values is null'

ELSE IF @usertype = 'External examiners'
BEGIN 
    INSERT INTO users(username,email, user_role, phone_number)
        VALUES (@username, @email, @usertype, @phone_number)
    SET @users_id = (SELECT max(users_id) FROM users)
    SET @password = (SELECT max(users_id) FROM users)
    INSERT INTO external_examiner(external_examiner_id)
        VALUES (@users_id)
    INSERT INTO users(user_password)
        VALUES (@password)
END
IF @usertype = 'Coordinators' and @username is null or @email is null or @usertype is null or  @phone_number is null

    print 'One of the coordinator values is null'

ELSE IF @usertype = 'Coordinators'
    BEGIN 
    INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)
    SET @users_id = (SELECT max(users_id) FROM users)
    SET @password = (SELECT max(users_id) FROM users)
    INSERT INTO coordinator(coordinator_id)
        VALUES (@users_id)
    INSERT INTO users(user_password)
        VALUES (@password)
END
GO

CREATE PROC UserLogin
@email VARCHAR(50),
@password VARCHAR(10),
@success bit output,
@user_id int output
as 
declare @tmp_id INT
IF EXISTS(SELECT @tmp_id as users_id  FROM users WHERE email = @email and user_password = @password)
    BEGIN 

        SET @success = 1
        SET @user_id = @tmp_id
    END
ELSE 
    SET @success = 0
    SET @user_id = -1

    --DROP PROC UserLogin
GO

CREATE PROC ViewProfile
@user_id int
as
select * from users where @user_id = users_id
go

CREATE PROC ViewBachelorProjects
@user_id int,
@project_type varchar(20)
as
if @user_id is null and @project_type is null
begin
select * from bachelor_project
select * from academic
select * from industrial
end
else
if @project_type is null
begin 
select * from academic where @user_id = lecturer_id or @user_id = teaching_assistant_id or @user_id = external_examiner_id
select * from industrial where @user_id = lecturer_id or @user_id = staff_id or @user_id = company_id
end
else if @project_type = 'industrial'
begin 
select * from industrial where @user_id = lecturer_id or @user_id = staff_id or @user_id = company_id
end
else if @project_type = 'academic'
begin
select * from academic where @user_id = lecturer_id or @user_id = teaching_assistant_id or @user_id = external_examiner_id
end
go
--start of task 3

CREATE PROC MakePreferencesLocalProject
@student_id int,
@title varchar(50),
@preference_number int
as
insert into student_preferences(student_id, preference_number, project_code)
    values (@student_id, @title, @preference_number)

go

CREATE PROC ViewMyThesis
@student_id int,
@title varchar(50)
as
declare @grade1 decimal

IF EXISTS(select * from grade_academic_thesis where @title = title)
begin
declare @external_examiner_grade decimal, @lecturer_grade decimal
select @external_examiner_grade = external_examiner_grade from grade_academic_thesis
select @lecturer_grade = lecturer_grade from grade_academic_thesis
if @external_examiner_grade IS NOT NULL and @lecturer_grade IS NOT NULL 
set @grade1 = (@external_examiner_grade + @lecturer_grade)/2
update thesis set total_grade = @grade1 where @student_id = student_id
end
IF EXISTS(select * from grade_industrial_thesis where @title = title)
begin
declare @company_grade decimal, @employee_grade decimal
select @company_grade = company_grade from grade_industrial_thesis
select @employee_grade = staff_grade from grade_industrial_thesis
if @employee_grade IS NOT NULL and @company_grade IS NOT NULL 
set @grade1 = (@company_grade + @employee_grade)/2
update thesis set total_grade = @grade1 where @student_id = student_id
end
select * from thesis
go 

CREATE PROC SubmitMyThesis
@student_id int,
@title varchar(50),
@pdf_doc varchar(1000)
as
insert into thesis(student_id, title, pdf_doc)
    values (@student_id, @title, @pdf_doc)
go

CREATE PROC ViewMyProgressReport
@student_id int,
@date datetime
as
declare @lecturer_grade int
if @date is null 
begin
select @lecturer_grade = lecturer_grade from grade_academic_progress_report where @student_id = student_id
update progress_report set comulative_progress_report_grade = @lecturer_grade
select * from progress_report where @student_id = student_id order by progress_report_date asc
end
else
select @lecturer_grade = lecturer_grade from grade_academic_progress_report where @student_id = student_id
update progress_report set comulative_progress_report_grade = @lecturer_grade
select * from progress_report where @student_id = student_id and @date = progress_report_date


go
CREATE PROC ViewMyDefense
@student_id int
as
declare @grade1 decimal
declare @project varchar(10)
set @project = (select Assigned_Project_Code from student where @student_id = student_id)

IF EXISTS(select * from academic where @project = academic_code)
begin
declare @external_examiner_grade decimal, @lecturer_grade decimal
select @external_examiner_grade = external_examiner_grade from grade_academic_thesis
select @lecturer_grade = lecturer_grade from grade_academic_thesis
if @external_examiner_grade IS NOT NULL and @lecturer_grade IS NOT NULL 
set @grade1 = (@external_examiner_grade + @lecturer_grade)/2
update defense set total_grade = @grade1 where @student_id = student_id
end
IF EXISTS(select * from industrial where @project = industrial_code)
begin
declare @company_grade decimal, @employee_grade decimal
select @company_grade = company_grade from grade_industrial_thesis
select @employee_grade = staff_grade from grade_industrial_thesis
if @employee_grade IS NOT NULL and @company_grade IS NOT NULL 
set @grade1 = (@company_grade + @employee_grade)/2
update defense set total_grade = @grade1 where @student_id = student_id
end
select * from defense
go


CREATE PROC UpdateMyDefense
@student_id int,
@defense_content varchar(1000)
as
update defense set defense_content = @defense_content where @student_id = student_id
go


CREATE PROC ViewMyBachelorProjectGrade
@student_id int,
@bachelor_grade decimal(4,2) output
as
declare @thesis_grade decimal
declare @defense_grade decimal
declare @cprg decimal
select @thesis_grade = total_grade  from thesis where @student_id = student_id 
select @defense_grade =total_grade from defense where @student_id = student_id
select @cprg= comulative_progress_report_grade from progress_report where @student_id = student_id
if @cprg is null or @defense_grade is null or @thesis_grade is null
return null
else 
update student set TotalBachelorGrade =  0.3*@thesis_grade + 0.3*@defense_grade + 0.4*@cprg
set @bachelor_grade = 0.3*@thesis_grade + 0.3*@defense_grade + 0.4*@cprg
return @bachelor_grade
go


CREATE PROC ViewNotBookedMeetings
@student_id int
as
select * from meeting where start_time is null


--start of 5
go

