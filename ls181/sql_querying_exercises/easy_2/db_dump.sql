-- Postgres Schema & Data

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    subscription_status TEXT NOT NULL CHECK (subscription_status IN ('never subscribed', 'active', 'cancelled'))
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    label TEXT NOT NULL UNIQUE,
    description TEXT NOT NULL
);

CREATE TABLE enrollments (
    student_id INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    course_id INTEGER NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('in progress', 'completed', 'not started')),
    PRIMARY KEY(student_id, course_id)
);

-- Courses
INSERT INTO courses (id, label, description) VALUES
-- Orientation
(1,  'LS95',  'Orientation'),

-- Python track
(2,  'PY100', 'Programming & Back-end Prep with Python'),
(3,  'PY101', 'Programming Foundations with Python: Basics'),
(4,  'PY109', 'Assessment: Programming Foundations with Python: Basics'),
(5,  'PY110', 'Programming Foundations with Python: Intermediate'),
(6,  'PY119', 'Assessment: Programming Foundations with Python: Intermediate'),
(7,  'PY120', 'Object-Oriented Programming with Python'),
(8,  'PY129', 'Assessment: Object-Oriented Programming with Python'),
(9,  'PY130', 'More Python Foundations'),
(10, 'PY139', 'Assessment: More Python Foundations'),
(11, 'PY175','Networked Applications with Python'),
(12, 'PY185','Database Applications with Python'),
(13, 'PY189', 'Assessment: Networked and Database Applications with Python'),

-- Ruby track
(14, 'RB100', 'Programming & Back-end Prep with Ruby'),
(15, 'RB101', 'Programming Foundations with Ruby: Basics'),
(16, 'RB109', 'Assessment: Programming Foundations with Ruby: Basics'),
(17, 'RB110', 'Programming Foundations with Ruby: Intermediate'),
(18, 'RB119', 'Assessment: Programming Foundations with Ruby: Intermediate'),
(19, 'RB120', 'Object-Oriented Programming with Ruby'),
(20, 'RB129', 'Assessment: Object-Oriented Programming with Ruby'),
(21, 'RB130', 'Ruby Foundations: More Topics'),
(22, 'RB139', 'Assessment: Ruby Foundations More Topics'),
(23, 'RB175','Networked Applications with Ruby'),
(24, 'RB185','Database Applications with Ruby'),
(25, 'RB189', 'Assessment: Networked and Database Applications with Ruby'),

-- JavaScript track
(26, 'JS100', 'Programming & Back-end Prep with JavaScript'),
(27, 'JS101', 'Programming Foundations with JavaScript: Basics'),
(28, 'JS109', 'Assessment: Programming Foundations with JavaScript: Basics'),
(29, 'JS110', 'Programming Foundations with JavaScript: Intermediate'),
(30, 'JS119', 'Assessment: Programming Foundations with JavaScript: Intermediate'),
(31, 'JS120', 'Object-Oriented Programming with JavaScript'),
(32, 'JS129', 'Assessment: Object-Oriented Programming with JavaScript'),
(33, 'JS130', 'More JavaScript Foundations'),
(34, 'JS139', 'Assessment: More JavaScript Foundations'),
(35, 'JS175','Networked Applications with JavaScript'),
(36, 'JS185','Database Applications with JavaScript'),
(37, 'JS189','Assessment: Networked and Database Applications with JavaScript'),

-- Networking & Database
(38, 'LS170', 'Networking Foundations'),
(39, 'LS171', 'Assessment: Networking Foundations'),
(40, 'LS180','Database Foundations'),
(41, 'LS181','Assessment: Database Foundations'),

-- Front-end
(42, 'LS202', 'HTML and CSS'),
(43, 'JS210', 'Fundamentals of JavaScript for Programmers'),
(44, 'JS211', 'Assessment: Fundamentals of JavaScript for Programmers'),
(45, 'LS215', 'Computational Thinking and Problem Solving'),
(46, 'LS216', 'Assessment: Computational Thinking and Problem Solving'),
(47, 'JS225', 'Object-Oriented JavaScript'),
(48, 'JS229', 'Assessment: Object-Oriented JavaScript'),
(49, 'JS230', 'DOM Manipulation & Browser Events'),
(50, 'JS235', 'Asynchronous JavaScript & APIs'),
(51, 'JS239', 'Assessment: DOM & Asynchronous Programming with JavaScript'),
(52, 'TS240', 'Introduction to TypeScript'),
(53, 'TS249', 'Assessment: Introduction to TypeScript'),
(54, 'LS250', 'Introduction to Data Structures and Algorithms'),
(55, 'LS259', 'Assessment: Data Structures and Algorithms');

-- Students
INSERT INTO students (id, name, email, subscription_status) VALUES
(1,  'Aisha Khan',       'aisha.khan@example.com',       'active'),
(2,  'Miguel Santos',    'miguel.santos@example.com',   'active'),
(3,  'Hiro Tanaka',      'hiro.tanaka@example.com',     'never subscribed'),
(4,  'Fatima Noor',      'fatima.noor@example.com',     'never subscribed'),
(5,  'Liam O’Connor',    'liam.oconnor@example.com',    'active'),
(6,  'Chun-Li Zhang',    'chunli.zhang@example.com',    'active'),
(7,  'Nkechi Okafor',    'nkechi.okafor@example.com',   'cancelled'),
(8,  'Diego Ramirez',    'diego.ramirez@example.com',   'active'),
(9,  'Priya Mehta',      'priya.mehta@example.com',     'never subscribed'),
(10, 'Elena Petrova',    'elena.petrova@example.com',   'active'),
(11, 'Kofi Mensah',      'kofi.mensah@example.com',     'active'),
(12, 'Yara Al-Farsi',    'yara.alfarsi@example.com',    'never subscribed');

-- Student 1: Python track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(1, 1, 'completed'),   -- LS95
(1, 2, 'completed'),   -- PY100
(1, 3, 'completed'),   -- PY101
(1, 4, 'completed'),   -- PY109
(1, 5, 'completed'),   -- PY110
(1, 6, 'completed'),   -- PY119
(1, 7, 'in progress'); -- PY120

-- Student 2: Ruby track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(2, 1, 'completed'),    -- LS95
(2, 14, 'completed'),   -- RB100
(2, 15, 'completed'),   -- RB101
(2, 16, 'completed'),   -- RB109
(2, 17, 'in progress'); -- RB110

-- Student 3: JavaScript track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(3, 1, 'completed'),  -- LS95
(3, 26, 'completed'); -- JS100

-- Student 4: Never subscribed
INSERT INTO enrollments (student_id, course_id, status) VALUES
(4, 1, 'in progress'); -- LS95

-- Student 5: Python track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(5, 1, 'completed'),   -- LS95
(5, 2, 'completed'),   -- PY100
(5, 3, 'completed'),   -- PY101
(5, 4, 'completed'),   -- PY109
(5, 5, 'completed'),   -- PY110
(5, 6, 'completed'),   -- PY119
(5, 7, 'completed'),   -- PY120
(5, 8, 'in progress'); -- PY129

-- Student 6: Ruby then Python
INSERT INTO enrollments (student_id, course_id, status) VALUES
(6, 1, 'completed'),   -- LS95
(6, 14, 'completed'),  -- RB100
(6, 15, 'completed'),  -- RB101
(6, 16, 'completed'),  -- RB109
(6, 17, 'completed'),  -- RB110
(6, 18, 'completed'),  -- RB119
(6, 2, 'completed'),   -- PY100
(6, 3, 'in progress'); -- PY101

-- Student 7: Python then JavaScript
INSERT INTO enrollments (student_id, course_id, status) VALUES
(7, 1, 'completed'),    -- LS95
(7, 2, 'completed'),    -- PY100
(7, 3, 'completed'),    -- PY101
(7, 4, 'completed'),    -- PY109
(7, 26, 'completed'),   -- JS100
(7, 27, 'in progress'); -- JS101

-- Student 8: JavaScript track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(8, 1, 'completed'),    -- LS95
(8, 26, 'completed'),   -- JS100
(8, 27, 'completed'),   -- JS101
(8, 28, 'completed'),   -- JS109
(8, 29, 'completed'),   -- JS110
(8, 30, 'completed'),   -- JS119
(8, 31, 'completed'),   -- JS120
(8, 32, 'completed'),   -- JS129
(8, 33, 'completed'),   -- JS130
(8, 34, 'completed'),   -- JS139
(8, 38, 'completed'),   -- LS170
(8, 39, 'completed'),   -- LS171
(8, 35, 'completed'),   -- JS175
(8, 40, 'completed'),   -- LS180
(8, 41, 'completed'),   -- LS181
(8, 36, 'completed'),   -- JS185
(8, 37, 'completed'),   -- JS189
(8, 42, 'completed'),   -- LS202
(8, 45, 'completed'),   -- LS215
(8, 46, 'completed'),   -- LS216
(8, 49, 'completed'),   -- JS230
(8, 50, 'in progress'); -- JS235

-- Student 9: Never subscribed
INSERT INTO enrollments (student_id, course_id, status) VALUES
(9, 1, 'not started');

-- Student 10: Python track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(10, 1, 'completed'),    -- LS95
(10, 2, 'completed'),    -- PY100
(10, 3, 'completed'),    -- PY101
(10, 4, 'completed'),    -- PY109
(10, 5, 'completed'),    -- PY110
(10, 6, 'completed'),    -- PY119
(10, 7, 'completed'),    -- PY120
(10, 8, 'completed'),    -- PY129
(10, 9, 'completed'),    -- PY130
(10, 10, 'completed'),   -- PY139
(10, 38, 'in progress'); -- LS170

-- Student 11: Ruby track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(11, 1,  'completed'),   -- LS95 Orientation
(11, 14, 'completed'),   -- RB100
(11, 15, 'completed'),   -- RB101
(11, 16, 'completed'),   -- RB109
(11, 17, 'completed'),   -- RB110
(11, 18, 'completed'),   -- RB119
(11, 19, 'completed'),   -- RB120
(11, 20, 'completed'),   -- RB129
(11, 21, 'completed'),   -- RB130
(11, 22, 'completed'),   -- RB139
(11, 38, 'completed'),   -- LS170
(11, 39, 'completed'),   -- LS171
(11, 23, 'completed'),   -- RB175
(11, 40, 'completed'),   -- LS180
(11, 41, 'completed'),   -- LS181
(11, 24, 'completed'),   -- RB185
(11, 25, 'completed'),   -- RB189
(11, 42, 'completed'),   -- LS202
(11, 43, 'completed'),   -- JS210
(11, 44, 'in progress'); -- JS211

-- Student 12: Python track
INSERT INTO enrollments (student_id, course_id, status) VALUES
(12, 1, 'completed'),   -- LS95
(12, 2, 'in progress'); -- PY100
