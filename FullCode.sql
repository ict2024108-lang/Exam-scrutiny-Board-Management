CREATE DATABASE ScrutinyBoardDB;
USE ScrutinyBoardDB;

CREATE TABLE DEPARTMENT (
    dept_id     INT AUTO_INCREMENT PRIMARY KEY,
    dept_name   VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ROLE (
    role_id     INT AUTO_INCREMENT PRIMARY KEY,
    role_name   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE USERS (
    user_id     INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    phone       VARCHAR(15),
    dept_id     INT,                                   
    CONSTRAINT fk_users_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id)
        ON DELETE SET NULL
);

CREATE TABLE USER_ROLE (
    user_id         INT,
    role_id         INT,
    assigned_date   DATE NOT NULL,
    is_active       BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_ur_user FOREIGN KEY (user_id)
        REFERENCES USERS(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_ur_role FOREIGN KEY (role_id)
        REFERENCES ROLE(role_id) ON DELETE CASCADE
);

CREATE TABLE SUBJECT (
    subject_id      INT AUTO_INCREMENT PRIMARY KEY,
    subject_name    VARCHAR(100) NOT NULL,
    credits         INT CHECK (credits > 0),
    semester        INT,
    dept_id         INT NOT NULL,                      
    CONSTRAINT fk_subject_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id)
);

CREATE TABLE SCRUTINY_BOARD (
    board_id        INT AUTO_INCREMENT PRIMARY KEY,
    board_name      VARCHAR(100) NOT NULL,
    status          VARCHAR(20) DEFAULT 'Active',
    dept_id         INT NOT NULL,                      
    CONSTRAINT fk_board_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id)
);

CREATE TABLE BOARD_MEMBER (
    user_id     INT,
    board_id    INT,
    PRIMARY KEY (user_id, board_id),
    CONSTRAINT fk_bm_user FOREIGN KEY (user_id)
        REFERENCES USERS(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_bm_board FOREIGN KEY (board_id)
        REFERENCES SCRUTINY_BOARD(board_id) ON DELETE CASCADE
);

CREATE TABLE BOARD_MEETING (
    meeting_id      INT AUTO_INCREMENT PRIMARY KEY,
    meeting_date    DATE NOT NULL,
    venue           VARCHAR(100),
    mode            VARCHAR(20),                       
    quorum          INT,
    status          VARCHAR(20) DEFAULT 'Scheduled',
    board_id        INT NOT NULL,                      
    CONSTRAINT fk_meeting_board FOREIGN KEY (board_id)
        REFERENCES SCRUTINY_BOARD(board_id) ON DELETE CASCADE
);

CREATE TABLE MEMBER_ATTENDANCE (
    attendance_id   INT AUTO_INCREMENT PRIMARY KEY,
    present         BOOLEAN DEFAULT FALSE,
    join_time       DATETIME,
    leave_time      DATETIME,
    meeting_id      INT NOT NULL,                      
    user_id         INT NOT NULL,                      
    CONSTRAINT fk_att_meeting FOREIGN KEY (meeting_id)
        REFERENCES BOARD_MEETING(meeting_id) ON DELETE CASCADE,
    CONSTRAINT fk_att_user FOREIGN KEY (user_id)
        REFERENCES USERS(user_id) ON DELETE CASCADE
);

CREATE TABLE EXAM (
    exam_id         INT AUTO_INCREMENT PRIMARY KEY,
    exam_time       TIME,
    start_date      DATE,
    status          VARCHAR(20),
    board_id        INT,                               
    CONSTRAINT fk_exam_board FOREIGN KEY (board_id)
        REFERENCES SCRUTINY_BOARD(board_id) ON DELETE SET NULL
);

CREATE TABLE EXAM_PAPER (
    paper_id        INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(150) NOT NULL,
    exam_date       DATE,
    status          VARCHAR(30) DEFAULT 'Paper setting',
    subject_id      INT NOT NULL,                      
    exam_id         INT,                               
    board_id        INT,                               
    prepared_by     INT,                               
    CONSTRAINT fk_paper_subject FOREIGN KEY (subject_id)
        REFERENCES SUBJECT(subject_id),
    CONSTRAINT fk_paper_exam FOREIGN KEY (exam_id)
        REFERENCES EXAM(exam_id) ON DELETE SET NULL,
    CONSTRAINT fk_paper_board FOREIGN KEY (board_id)
        REFERENCES SCRUTINY_BOARD(board_id) ON DELETE SET NULL,
    CONSTRAINT fk_paper_user FOREIGN KEY (prepared_by)
        REFERENCES USERS(user_id) ON DELETE SET NULL
);

CREATE TABLE PAPER_STATUS_HISTORY (
    history_id      INT AUTO_INCREMENT PRIMARY KEY,
    status          VARCHAR(30) NOT NULL,
    change_date     DATETIME DEFAULT CURRENT_TIMESTAMP,
    paper_id        INT NOT NULL,                      
    CONSTRAINT fk_hist_paper FOREIGN KEY (paper_id)
        REFERENCES EXAM_PAPER(paper_id) ON DELETE CASCADE
);

CREATE TABLE HOD_APPROVAL (
    approval_id     INT AUTO_INCREMENT PRIMARY KEY,
    decision        VARCHAR(20) NOT NULL,
    comments        TEXT,
    approved_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    paper_id        INT NOT NULL,                      
    hod_id          INT NOT NULL,                      
    CONSTRAINT fk_appr_paper FOREIGN KEY (paper_id)
        REFERENCES EXAM_PAPER(paper_id) ON DELETE CASCADE,
    CONSTRAINT fk_appr_user FOREIGN KEY (hod_id)
        REFERENCES USERS(user_id)
);

CREATE TABLE MEETING_DECISION (
    meeting_id      INT,
    paper_id        INT,
    decision        VARCHAR(30),                       
    PRIMARY KEY (meeting_id, paper_id),
    CONSTRAINT fk_md_meeting FOREIGN KEY (meeting_id)
        REFERENCES BOARD_MEETING(meeting_id) ON DELETE CASCADE,
    CONSTRAINT fk_md_paper FOREIGN KEY (paper_id)
        REFERENCES EXAM_PAPER(paper_id) ON DELETE CASCADE
);


CREATE TABLE DOCUMENT (
    doc_id          INT AUTO_INCREMENT PRIMARY KEY,
    doc_type        VARCHAR(30) NOT NULL,              
    submitted_date  DATE,
    submitted_by    INT NOT NULL,                      
    CONSTRAINT fk_doc_user FOREIGN KEY (submitted_by)
        REFERENCES USERS(user_id)
);

CREATE TABLE DOCUMENT_VERSION (
    version_id      INT AUTO_INCREMENT PRIMARY KEY,
    version_no      INT NOT NULL,
    file_path       VARCHAR(255) NOT NULL,
    uploaded_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    doc_id          INT NOT NULL,                      
    CONSTRAINT fk_ver_doc FOREIGN KEY (doc_id)
        REFERENCES DOCUMENT(doc_id) ON DELETE CASCADE
);

CREATE TABLE NOTIFICATION (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    type            VARCHAR(30),
    message         VARCHAR(255) NOT NULL,
    sent_at         DATETIME DEFAULT CURRENT_TIMESTAMP,
    read_at         DATETIME,
    user_id         INT NOT NULL,                      
    CONSTRAINT fk_notif_user FOREIGN KEY (user_id)
        REFERENCES USERS(user_id) ON DELETE CASCADE
);