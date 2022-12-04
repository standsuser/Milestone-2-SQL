
CREATE PROC UserRegister
@usertype varchar(20),
@userName varchar(20), 
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
@country_of_residence varchar(20)

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
INSERT INTO users(role, username, email)
    VALUES (@usertype ,  @userName , @email)
INSERT INTO student(first_name, last_name, major_code, birth_date,adress, semester, gpa)
    VALUES(@first_name, @last_name,@major_code, @birth_date,@address, @semester, @gpa )
END
IF @usertype = 'Companies' AND
 (@company_name IS NULL or 
@representative_name IS NULL or 
@representative_email IS NULL or 
@address IS NULL)  /*is location of company the address?*/

print 'One of the company values is null' 

ELSE IF @usertype = 'Company'

BEGIN
INSERT INTO users(role, username, email)
    VALUES (@usertype ,  @userName , @email)
INSERT INTO company(company_name, representative_name, representative_email, company_location, )
    VALUES (@company_name, representative_name, @representative_email, @address)
END
IF 



