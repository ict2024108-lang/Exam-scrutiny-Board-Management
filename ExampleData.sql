USE ScrutinyBoardDB;

INSERT INTO DEPARTMENT (dept_id, dept_name) VALUES
(1, 'Information and Communication Technology'),
(2, 'Mathematics'),
(3, 'Physical Sciences');

INSERT INTO ROLE (role_id, role_name) VALUES
(1, 'Head of Department'),
(2, 'Lecturer'),
(3, 'Moderator'),
(4, 'Board Member'),
(5, 'Administrator');

INSERT INTO USERS (user_id, name, email, phone, dept_id) VALUES
(1, 'Nimal Perera',          'nimal@uni.lk',    '0711234567', 1),
(2, 'Kamala Silva',          'kamala@uni.lk',   '0712345678', 1),
(3, 'Sunil Fernando',        'sunil@uni.lk',    '0713456789', 1),
(4, 'Anura Jayasinghe',      'anura@uni.lk',    '0714567890', 2),
(5, 'Dilani Wickramasinghe', 'dilani@uni.lk',   '0715678901', 2),
(6, 'Ruwan Bandara',         'ruwan@uni.lk',    '0716789012', 3),
(7, 'Nadeesha Karunaratne',  'nadeesha@uni.lk', '0717890123', 1),
(8, 'System Admin',          'admin@uni.lk',    NULL,         NULL);

INSERT INTO USER_ROLE (user_id, role_id, assigned_date, is_active) VALUES
(1, 1, '2024-01-10', TRUE),
(1, 4, '2024-02-01', TRUE),
(2, 2, '2023-08-15', TRUE),
(3, 3, '2024-01-20', TRUE),
(3, 4, '2024-02-01', TRUE),
(4, 1, '2023-09-01', TRUE),
(4, 4, '2024-02-01', TRUE),
(5, 2, '2023-08-20', TRUE),
(6, 2, '2022-07-05', FALSE),
(7, 4, '2024-02-01', TRUE),
(8, 5, '2022-01-01', TRUE);

INSERT INTO SUBJECT (subject_id, subject_name, credits, semester, dept_id) VALUES
(1, 'C Programming',    3, 1, 1),
(2, 'Electronics',      3, 1, 1),
(3, 'Probability',      2, 2, 2),
(4, 'Database Systems', 3, 2, 1),
(5, 'Calculus',         3, 1, 2),
(6, 'Mechanics',        2, 2, 3);

INSERT INTO SCRUTINY_BOARD (board_id, board_name, status, dept_id) VALUES
(1, 'ICT Scrutiny Board',         'Active', 1),
(2, 'Mathematics Scrutiny Board', 'Active', 2);

INSERT INTO BOARD_MEMBER (user_id, board_id) VALUES
(1, 1), (3, 1), (7, 1),
(4, 2), (5, 2);

INSERT INTO BOARD_MEETING (meeting_id, meeting_date, venue, mode, quorum, status, board_id) VALUES
(1, '2026-10-05', 'Conference Room A', 'Physical', 3, 'Completed', 1),
(2, '2026-10-12', 'Online',            'Online',   3, 'Scheduled', 1),
(3, '2026-10-08', 'Maths Seminar Room','Physical', 2, 'Completed', 2);

INSERT INTO MEMBER_ATTENDANCE (attendance_id, present, join_time, leave_time, meeting_id, user_id) VALUES
(1, TRUE,  '2026-10-05 09:00:00', '2026-10-05 11:00:00', 1, 1),
(2, TRUE,  '2026-10-05 09:05:00', '2026-10-05 11:00:00', 1, 3),
(3, FALSE, NULL,                  NULL,                  1, 7),
(4, TRUE,  '2026-10-08 10:00:00', '2026-10-08 11:30:00', 3, 4),
(5, TRUE,  '2026-10-08 10:02:00', '2026-10-08 11:30:00', 3, 5);

INSERT INTO EXAM (exam_id, exam_time, start_date, status, board_id) VALUES
(1, '09:00:00', '2026-11-20', 'Scheduled', 1),
(2, '13:30:00', '2026-11-25', 'Scheduled', 2);

INSERT INTO EXAM_PAPER (paper_id, title, exam_date, status, subject_id, exam_id, board_id, prepared_by) VALUES
(1, 'C Programming Final Paper',    '2026-11-20', 'Approved',         1, 1, 1, 2),
(2, 'Database Systems Final Paper', '2026-11-22', 'Under moderation', 4, 1, 1, 2),
(3, 'Electronics Final Paper',      '2026-11-24', 'Paper setting',    2, 1, 1, 2),
(4, 'Calculus Final Paper',         '2026-11-25', 'Approved',         5, 2, 2, 5),
(5, 'Probability Final Paper',      '2026-11-27', 'Submitted',        3, 2, 2, 5);

INSERT INTO PAPER_STATUS_HISTORY (history_id, status, change_date, paper_id) VALUES
(1,  'Paper setting',    '2026-09-20 10:00:00', 1),
(2,  'Submitted',        '2026-10-01 14:30:00', 1),
(3,  'Under moderation', '2026-10-05 09:00:00', 1),
(4,  'Approved',         '2026-10-10 16:00:00', 1),
(5,  'Paper setting',    '2026-09-22 11:00:00', 2),
(6,  'Submitted',        '2026-10-02 15:00:00', 2),
(7,  'Under moderation', '2026-10-05 09:30:00', 2),
(8,  'Paper setting',    '2026-10-03 09:00:00', 3),
(9,  'Paper setting',    '2026-09-25 10:00:00', 4),
(10, 'Approved',         '2026-10-09 12:00:00', 4),
(11, 'Submitted',        '2026-10-11 10:00:00', 5);

INSERT INTO HOD_APPROVAL (approval_id, decision, comments, approved_at, paper_id, hod_id) VALUES
(1, 'Approved',           'Meets syllabus coverage.',            '2026-10-10 15:30:00', 1, 1),
(2, 'Revision requested', 'Question 4 needs clearer wording.',   '2026-10-06 13:00:00', 2, 1),
(3, 'Approved',           'Good balance of easy and hard items.','2026-10-09 11:45:00', 4, 4);

INSERT INTO MEETING_DECISION (meeting_id, paper_id, decision) VALUES
(1, 1, 'Accepted'),
(1, 2, 'Minor changes'),
(3, 4, 'Accepted');

INSERT INTO DOCUMENT (doc_id, doc_type, submitted_date, submitted_by) VALUES
(1, 'Question Paper',    '2026-10-01', 2),
(2, 'Marking Scheme',    '2026-10-01', 2),
(3, 'Moderator Report',  '2026-10-04', 3),
(4, 'Question Paper',    '2026-10-11', 5),
(5, 'Marking Scheme',    '2026-10-11', 5);

INSERT INTO DOCUMENT_VERSION (version_id, version_no, file_path, uploaded_at, doc_id) VALUES
(1, 1, '/files/c_programming_paper_v1.pdf',  '2026-10-01 14:30:00', 1),
(2, 2, '/files/c_programming_paper_v2.pdf',  '2026-10-07 10:15:00', 1),
(3, 1, '/files/c_programming_scheme_v1.pdf', '2026-10-01 14:35:00', 2),
(4, 1, '/files/moderator_report_v1.pdf',     '2026-10-04 17:00:00', 3),
(5, 1, '/files/probability_paper_v1.pdf',    '2026-10-11 10:00:00', 4),
(6, 1, '/files/probability_scheme_v1.pdf',   '2026-10-11 10:05:00', 5);

INSERT INTO NOTIFICATION (notification_id, type, message, sent_at, read_at, user_id) VALUES
(1, 'Approval',  'Paper "Database Systems Final Paper" needs your approval.', '2026-10-02 15:05:00', '2026-10-02 16:00:00', 1),
(2, 'Meeting',   'Scrutiny board meeting on 2026-10-12 at 09:00 (Online).',  '2026-10-08 08:00:00', NULL,                  3),
(3, 'Revision',  'Please revise Question 4 of your Database Systems paper.',  '2026-10-06 13:05:00', '2026-10-06 14:20:00', 2),
(4, 'Approved',  'Your Calculus Final Paper has been approved.',              '2026-10-09 12:05:00', '2026-10-09 13:00:00', 5),
(5, 'Reminder',  'Submit the Electronics paper before 2026-10-20.',           '2026-10-15 09:00:00', NULL,                  2);