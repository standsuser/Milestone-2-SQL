CREATE DATABASE Bachelor USE Bachelor CREATE TABLE users (
    users_id INTEGER,
    username VARCHAR(20),
    password VARCHAR(10),
    email VARCHAR(50),
    role VARCHAR(20),
    phone_number VARCHAR(20),
    PRIMARY KEY (users_id),
    UNIQUE (username, email)
);

CREATE TABLE lecturer (
    lecturer_id INTEGER,
    schedule VARCHAR(100),
    PRIMARY KEY (lecturer_id),
    FOREIGN KEY (lecturer_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE lecturer_fields (
    lecturer_id INTEGER,
    fields VARCHAR(10),
    /*multivalued should it be different?*/
    PRIMARY KEY(lecturer_id, fields),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*should it reference lecturer*/
CREATE TABLE company (
    company_id INTEGER,
    name VARCHAR(20),
    representative_name VARCHAR(10),
    representative_email VARCHAR(20),
    location VARCHAR(50),
    PRIMARY KEY(company_id),
    FOREIGN KEY (company_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE employee(
    staff_id INTEGER,
    company_id INTEGER,
    username VARCHAR(10),
    password VARCHAR(10),
    email VARCHAR(20),
    field VARCHAR(20),
    phone VARCHAR(20),
    PRIMARY KEY (staff_id),
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (username)
);

CREATE TABLE external_examiner(
    external_examiner_id INTEGER,
    schedule VARCHAR(100),
    PRIMARY KEY (external_examiner_id),
    FOREIGN KEY (external_examiner_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE teaching_assistant(
    teaching_assistant_id INTEGER,
    schedule VARCHAR(100),
    PRIMARY KEY (teaching_assistant_id),
    FOREIGN KEY (teaching_assistant_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE coordinator(
    coordinator_id INTEGER,
    PRIMARY KEY (coordinator_id),
    FOREIGN KEY (coordinator_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE faculty(
    faculty_code INTEGER,
    name VARCHAR(20),
    dean INTEGER,
    PRIMARY KEY (faculty_code),
    FOREIGN KEY (dean) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE major(
    major_code INTEGER,
    major_name VARCHAR(20),
    faculty_code INTEGER,
    PRIMARY KEY (major_code),
    FOREIGN KEY (faculty_code) REFERENCES faculty(faculty_code) ON DELETE CASCADE ON UPDATE CASCADE
);

/*------------------error begin-------------------*/
CREATE TABLE student(
    student_id INTEGER,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    major_code INTEGER,
    date_of_birth DATE,
    adress VARCHAR(45),
    age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(date_of_birth)),
    semester INTEGER,
    gpa DECIMAL,
    /*double doesnt work?*/
    /*total_bachelor_grade AS((0.3*thesis.total_grade)+(0.3*defense.total_grade)+ (0.4*comulative_progress_report_grade)),
     comulative_progress_report_grade AS AVG(progress_report.grade), recheck grade odam*/
    PRIMARY KEY (student_id),
    FOREIGN KEY (student_id) REFERENCES users(users_id),
    FOREIGN KEY (major_code) REFERENCES major(major_code)
    /*i removed update cascades because it was causing an error revise what to type then*/
);

CREATE TABLE bachelor_project(
    code INTEGER,
    name VARCHAR(20),
    submitted_materials VARCHAR(100),
    description VARCHAR(100) PRIMARY KEY (code)
);

CREATE TABLE bachelor_submitted_materials(
    code INTEGER,
    material VARCHAR(30),
    PRIMARY KEY (code),
    FOREIGN KEY (code) REFERENCES bachelor_project(code) ON DELETE CASCADE ON UPDATE CASCADE
    /*eshme3na cascade hena doesnt cause error*/
);

CREATE TABLE academic(
    academic_code INTEGER,
    lecturer_id INTEGER,
    teaching_assistant_id INTEGER,
    external_examiner_id INTEGER,
    PRIMARY KEY (academic_code),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (teaching_assistant_id) REFERENCES teaching_assistant(teaching_assistant_id),
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id)
);

CREATE TABLE industrial(
    /*bayez*/
    industrial_code INTEGER,
    company_id INTEGER,
    employee_company_id INTEGER,/*extra to stop error*/
    lecturer_id INTEGER,
    staff_id INTEGER,
    PRIMARY KEY (industrial_code),
    FOREIGN KEY (company_id) REFERENCES company(company_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (staff_id) REFERENCES employee(staff_id)

);

CREATE TABLE meeting(
    meeting_id INTEGER,
    meeting_point VARCHAR(20),
    lecturer_id INTEGER,
    meeting_date DATE,
    start_time TIME,
    end_time TIME,
    /*duration SUM(DATEDIFF(MINUTE, End_Time,Start_Time)) , HOW TO ADD? SHOULD WE ADD IT ASLAN?*/
    PRIMARY KEY (meeting_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE meeting_to_do_list(
    meeting_id INTEGER,
    to_do_list VARCHAR(200),
    PRIMARY KEY (meeting_id),
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE meeting_attendents(
    meeting_id INTEGER,
    attendant_id INTEGER,
    PRIMARY KEY (attendant_id, meeting_id),
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE thesis(
    student_id INTEGER,
    title varchar(20),
    deadline datetime,
    pdf_doc varchar(200),
    total_grade INTEGER,
    PRIMARY KEY (student_id, title),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    /*Where : Thesis.Total_Grade =
     Calculated((GradeAcademicThesis.EE_grade+GradeAcademicThesis.Lecturer_grade)/2 or
     (GradeIndustrialThesis.Company_grade & GradeIndustrialThesis.Employee_grade)/2) */
);

CREATE TABLE defense(
    student_id INTEGER,
    defense_location varchar(20),
    defense_time TIME,
    defense_date DATETIME,
    total_grade INTEGER,
    PRIMARY KEY (student_id, defense_location),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    /*Where : Defense.Total_Grade = Calculated((GradeAcademicDefense.EE_grade +
     GradeAcademicDefense.Lecturer_grade)/2 or
     (GradeIndustrialDefense.Compay_grade+GradeIndustrialDefense.Employee_grade)/2*/
);

CREATE TABLE progress_report(
    student_id INTEGER,
    content varchar(20),
    updating_user_id INTEGER,
    progress_report_date datetime,
    grade INTEGER,
    PRIMARY KEY (student_id, progress_report_date),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (updating_user_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE,
    /*Where : ProgressReport.Grade = Calculated((GradeAcademicPR.LecGrade) or
     (GradeIndustrialPR.Company_grade+GradeAcademicPR.Lecturer_grade)/2)*/
);

CREATE TABLE grade_industrial_progress_report (
    /*bayez*/
    lecturer_id INTEGER,
    content varchar(20),
    company_id INTEGER,
    student_id INTEGER,
    lecturer_grade INTEGER,
    progress_report_date datetime,
    company_grade INTEGER,
    PRIMARY KEY (student_id, progress_report_date),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (company_id) REFERENCES company(Company_id),
    FOREIGN KEY (student_id) REFERENCES student_id(student_id),
    FOREIGN KEY (progress_report_date) REFERENCES progress_report(progress_report_date),
);

CREATE TABLE grade_academic_progress_report (
    /*bayez*/
    lecturer_id INTEGER,
    student_id INTEGER,
    lecturer_grade INTEGER,
    progress_report_date datetime,
    PRIMARY KEY (progress_report_date, lecturer_id, student_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (progress_report_date) REFERENCES progress_report(progress_report_date) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE grade_academic_thesis (
    /*bayez*/
    lecturer_id INTEGER,
    external_examiner_id INTEGER,
    student_id INTEGER,
    title varchar(20),
    lecturer_grade INTEGER,
    external_examiner_grade INTEGER,
    PRIMARY KEY (student_id, lecturer_id, title),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (external_examiner_id) REFERENCES ecternal_examiner(external_examiner_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (title) REFERENCES thesis(title) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE grade_industrial_thesis(
    /*bayez*/
    company_id INTEGER,
    staff_id INTEGER,
    student_id INTEGER,
    title varchar(20),
    company_grade INTEGER,
    staff_grade INTEGER,
    PRIMARY KEY (student_id, title),
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES employee(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (title) REFERENCES thesis(title) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE grade_academic_defense (
    /*bayez*/
    lecturer_id INTEGER,
    external_examiner_id INTEGER,
    student_id INTEGER,
    defense_location varchar(20),
    lecturer_grade INTEGER,
    external_examiner_grade INTEGER,
    PRIMARY KEY (student_id, defense_location),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (defense_location) REFERENCES defense(defense_location) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE grade_industrial_defense (
    /*bayez*/
    company_id INTEGER,
    staff_id INTEGER,
    student_id INTEGER,
    defense_location varchar(20),
    company_grade INTEGER,
    employee_grade INTEGER,
    PRIMARY KEY (student_id, defense_location),
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES employee(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (defense_location) REFERENCES defense(defense_location) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE lecturer_recommend_external_examiner(
    lecturer_id INTEGER NOT NULL,
    external_examiner_id INTEGER,
    project_code INTEGER,
    PRIMARY KEY (external_examiner_id, project_code),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id),
    FOREIGN KEY (project_code) REFERENCES academic(academic_code),
);

CREATE TABLE student_preferences(
    student_id INTEGER,
    preference_number INTEGER,
    project_code INTEGER,
    PRIMARY KEY (student_id, project_code),
    FOREIGN KEY (student_id) REFERENCES student,
    FOREIGN KEY (project_code) REFERENCES bachelor_project(code),
);

CREATE TABLE major_has_bachelor_project(
    /*bayez*/
    major_code INTEGER,
    project_code INTEGER,
    PRIMARY KEY (major_code, project_code),
    FOREIGN KEY (major_code) REFERENCES major(major_code) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (project_code) REFERENCES bachelor_project(project_code) ON DELETE CASCADE ON UPDATE CASCADE,
);

/* update notes: spelling mistakes and main errors fixed. entities tables are created
 BUT relation tables foreign keys have error issues when ran separately and aren't created */