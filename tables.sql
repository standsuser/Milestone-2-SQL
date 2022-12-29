CREATE DATABASE Bachelor USE Bachelor CREATE TABLE users (
    users_id INTEGER IDENTITY,
    username VARCHAR(20),
    user_password VARCHAR(10),
    email VARCHAR(50),
    user_role VARCHAR(20),
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
    fields VARCHAR(20),
    PRIMARY KEY(lecturer_id, fields),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE company (
    company_id INTEGER,
    company_name VARCHAR(20),
    representative_name VARCHAR(20),
    representative_email VARCHAR(50),
    company_location VARCHAR(50),
    PRIMARY KEY(company_id),
    FOREIGN KEY (company_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE employee(
    staff_id INTEGER IDENTITY,
    company_id INTEGER,
    username VARCHAR(10),
    employee_password VARCHAR(10),
    email VARCHAR(20),
    field VARCHAR(20),
    phone VARCHAR(20),
    PRIMARY KEY (staff_id, company_id),
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (username, email)
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
    faculty_name VARCHAR(20),
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

CREATE TABLE bachelor_project(
    code INTEGER,
    project_name VARCHAR(20),
    submitted_materials VARCHAR(100),
    pdescription VARCHAR(100),
    PRIMARY KEY (code)
);

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
    TotalBachelorGrade DECIMAL(4, 2),
    Assigned_Project_Code INTEGER,
    /*total_bachelor_grade AS((0.3*thesis.total_grade)+(0.3*defense.total_grade)+ (0.4*comulative_progress_report_grade)),
     comulative_progress_report_grade AS AVG(progress_report.grade), */
    PRIMARY KEY (student_id),
    FOREIGN KEY (student_id) REFERENCES users(users_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (major_code) REFERENCES major(major_code),
    FOREIGN KEY (Assigned_Project_Code) REFERENCES bachelor_project(code)
);

CREATE TABLE bachelor_submitted_materials(
    code INTEGER,
    material VARCHAR(30),
    PRIMARY KEY (code),
    FOREIGN KEY (code) REFERENCES bachelor_project(code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE academic(
    academic_code INTEGER,
    lecturer_id INTEGER,
    teaching_assistant_id INTEGER,
    external_examiner_id INTEGER,
    PRIMARY KEY (academic_code),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (teaching_assistant_id) REFERENCES teaching_assistant(teaching_assistant_id),
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id),
    FOREIGN KEY (academic_code) REFERENCES bachelor_project(code)
);

CREATE TABLE industrial(
    industrial_code INTEGER,
    company_id INTEGER,
    lecturer_id INTEGER,
    staff_id INTEGER,
    PRIMARY KEY (industrial_code),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id, company_id) REFERENCES employee(staff_id, company_id),
    FOREIGN KEY (company_id) REFERENCES company(company_id),
    FOREIGN KEY (industrial_code) REFERENCES bachelor_project(code)
);

CREATE TABLE meeting(
    meeting_id INTEGER IDENTITY,
    meeting_point VARCHAR(5),
    lecturer_id INTEGER,
    meeting_date DATE,
    start_time DATETIME,
    end_time DATETIME,
    duration as datediff(mi, start_time, end_time),
    PRIMARY KEY (meeting_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE meeting_to_do_list(
    meeting_id INTEGER,
    to_do_list VARCHAR(200),
    PRIMARY KEY (meeting_id, to_do_list),
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE meeting_attendents(
    meeting_id INTEGER,
    attendant_id INTEGER,
    PRIMARY KEY (attendant_id, meeting_id),
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (attendant_id) REFERENCES users(users_id)
);

CREATE TABLE thesis(
    student_id INTEGER,
    title varchar(20),
    deadline datetime,
    pdf_doc varchar(1000),
    total_grade Decimal(4,2),
    PRIMARY KEY (student_id, title),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    /*Where : Thesis.Total_Grade =
     Calculated((GradeAcademicThesis.EE_grade+GradeAcademicThesis.Lecturer_grade)/2 or
     (GradeIndustrialThesis.Company_grade & GradeIndustrialThesis.Employee_grade)/2) */
);

CREATE TABLE defense(
    student_id INTEGER,
    defense_location varchar(20),
    content varchar(1000),
    defense_time TIME,
    defense_date DATETIME,
    total_grade Decimal(4,2),
    PRIMARY KEY (student_id, defense_location),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    /*Where : Defense.Total_Grade = Calculated((GradeAcademicDefense.EE_grade +
     GradeAcademicDefense.Lecturer_grade)/2 or
     (GradeIndustrialDefense.Compay_grade+GradeIndustrialDefense.Employee_grade)/2*/
);

CREATE TABLE progress_report(
    student_id INTEGER,
    content varchar(1000),
    updating_user_id INTEGER,
    progress_report_date datetime,
    grade INTEGER,
    PRIMARY KEY (progress_report_date, student_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (updating_user_id) REFERENCES users(users_id),
    /*Where : ProgressReport.Grade = Calculated((GradeAcademicPR.LecGrade) or
     (GradeIndustrialPR.Company_grade+GradeAcademicPR.Lecturer_grade)/2)*/
);

CREATE TABLE grade_industrial_progress_report (
    lecturer_id INTEGER,
    company_id INTEGER,
    student_id INTEGER,
    lecturer_grade Decimal(4,2),
    progress_report_date datetime,
    company_grade Decimal(4,2),
    PRIMARY KEY (student_id, progress_report_date),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (company_id) REFERENCES company(Company_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (progress_report_date, student_id) REFERENCES progress_report(progress_report_date, student_id),
);

CREATE TABLE grade_academic_progress_report (
    lecturer_id INTEGER,
    student_id INTEGER,
    lecturer_grade Decimal(4,2),
    progress_report_date datetime,
    PRIMARY KEY (progress_report_date, student_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (progress_report_date, student_id) REFERENCES progress_report(progress_report_date, student_id),
);

CREATE TABLE grade_academic_thesis (
    lecturer_id INTEGER,
    external_examiner_id INTEGER,
    student_id INTEGER,
    title varchar(20),
    lecturer_grade Decimal(4,2),
    external_examiner_grade Decimal(4,2),
    PRIMARY KEY (student_id, title),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id, title) REFERENCES thesis(student_id, title)
);

CREATE TABLE grade_industrial_thesis(
    company_id INTEGER,
    staff_id INTEGER,
    student_id INTEGER,
    title varchar(20),
    company_grade Decimal(4,2),
    staff_grade Decimal(4,2),
    PRIMARY KEY (student_id, title),
    FOREIGN KEY (company_id) REFERENCES company(company_id),
    FOREIGN KEY (staff_id, company_id) REFERENCES employee(staff_id, company_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id, title) REFERENCES thesis(student_id, title)
);

CREATE TABLE grade_academic_defense (
    lecturer_id INTEGER,
    external_examiner_id INTEGER,
    student_id INTEGER,
    defense_location varchar(20),
    lecturer_grade Decimal(4,2),
    external_examiner_grade Decimal(4,2),
    PRIMARY KEY (student_id, defense_location),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id, defense_location) REFERENCES defense(student_id, defense_location),
);

CREATE TABLE grade_industrial_defense (
    company_id INTEGER,
    staff_id INTEGER,
    student_id INTEGER,
    defense_location varchar(20),
    company_grade Decimal(4,2),
    employee_grade Decimal(4,2),
    PRIMARY KEY (student_id, defense_location),
    FOREIGN KEY (company_id) REFERENCES company(company_id),
    FOREIGN KEY (staff_id, company_id) REFERENCES employee(staff_id, company_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id, defense_location) REFERENCES defense(student_id, defense_location),
);

CREATE TABLE lecturer_recommend_external_examiner(
    lecturer_id INTEGER NOT NULL,
    external_examiner_id INTEGER,
    project_code INTEGER,
    PRIMARY KEY (external_examiner_id, project_code),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (external_examiner_id) REFERENCES external_examiner(external_examiner_id),
    FOREIGN KEY (project_code) REFERENCES academic(academic_code) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE student_preferences(
    student_id INTEGER,
    preference_number INTEGER,
    project_code INTEGER,
    PRIMARY KEY (student_id, project_code),
    FOREIGN KEY (student_id) REFERENCES student ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (project_code) REFERENCES bachelor_project(code) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE major_has_bachelor_project(
    major_code INTEGER,
    project_code INTEGER,
    PRIMARY KEY (major_code, project_code),
    FOREIGN KEY (major_code) REFERENCES major(major_code) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (project_code) REFERENCES bachelor_project(code) ON DELETE CASCADE ON UPDATE CASCADE,
);