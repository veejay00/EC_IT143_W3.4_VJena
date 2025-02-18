-- Create the Community Users table
CREATE TABLE community_users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(255),
    join_date DATE
);

-- Create the Community Posts table
CREATE TABLE community_posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    post_content TEXT,
    post_date DATE,
    FOREIGN KEY (user_id) REFERENCES community_users(user_id)
);

-- Create the Community Replies table
CREATE TABLE community_replies (
    reply_id INT PRIMARY KEY,
    post_id INT,
    user_id INT,
    reply_content TEXT,
    reply_date DATE,
    FOREIGN KEY (post_id) REFERENCES community_posts(post_id),
    FOREIGN KEY (user_id) REFERENCES community_users(user_id)
);

-- Insert sample data for community_users
INSERT INTO community_users (user_id, user_name, join_date) VALUES
(1, 'Alice Johnson', '2024-01-10'),
(2, 'Bob Smith', '2024-02-15'),
(3, 'Charlie Brown', '2024-03-01'),
(4, 'David Lee', '2024-03-10'),
(5, 'Eve Adams', '2024-04-05');

-- Insert sample data for community_posts
INSERT INTO community_posts (post_id, user_id, post_content, post_date) VALUES
(1, 1, 'How do I start learning SQL?', '2024-04-10'),
(2, 2, 'Best SQL resources for beginners?', '2024-04-12'),
(3, 3, 'What is the difference between JOIN and UNION?', '2024-04-15'),
(4, 4, 'SQL optimization techniques', '2024-04-18'),
(5, 5, 'How to use stored procedures?', '2024-04-20');

-- Insert sample data for community_replies
INSERT INTO community_replies (reply_id, post_id, user_id, reply_content, reply_date) VALUES
(1, 1, 2, 'Start with W3Schools and practice daily.', '2024-04-11'),
(2, 1, 3, 'Try SQLZoo for interactive learning.', '2024-04-12'),
(3, 2, 1, 'I recommend reading the SQL for Dummies book.', '2024-04-13'),
(4, 3, 4, 'JOIN is for combining rows, UNION is for merging results.', '2024-04-16'),
(5, 5, 2, 'Stored procedures are useful for reusable SQL logic.', '2024-04-21');

-- Create the Events table
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255),
    category VARCHAR(100),
    event_date DATE,
    organizer_id INT
);

-- Create the Event Attendees table
CREATE TABLE event_attendance (
    attendance_id INT PRIMARY KEY,
    event_id INT,
    user_id INT,
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (user_id) REFERENCES community_users(user_id)
);

-- Insert sample data for events
INSERT INTO events (event_id, event_name, category, event_date, organizer_id) VALUES
(1, 'SQL Workshop', 'Technology', '2024-05-10', 1),
(2, 'Database Security Seminar', 'Cybersecurity', '2024-05-15', 2),
(3, 'Community Meetup', 'Networking', '2024-05-20', 3),
(4, 'AI and Data Science Talk', 'Technology', '2024-05-25', 4),
(5, 'Web Development Bootcamp', 'Programming', '2024-05-30', 5);

-- Insert sample data for event_attendance
INSERT INTO event_attendance (attendance_id, event_id, user_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 4),
(5, 2, 5),
(6, 3, 1),
(7, 3, 2),
(8, 4, 3),
(9, 4, 4),
(10, 5, 5);

-- Question 1: Which posts have more than one reply, and who are the users who replied to them?
SELECT p.post_id, p.post_content, u.user_name AS reply_user
FROM community_posts p
JOIN community_replies r ON p.post_id = r.post_id
JOIN community_users u ON r.user_id = u.user_id


-- Question 2: What are the most recent posts created by users who joined after '2024-02-01'?
SELECT p.post_id, p.post_content, p.post_date, u.user_name
FROM community_posts p
JOIN community_users u ON p.user_id = u.user_id
WHERE u.join_date > '2024-02-01'
ORDER BY p.post_date DESC;


-- 3. List all users who have made at least one post.
SELECT DISTINCT cu.user_id, cu.user_name 
FROM community_users cu
JOIN community_posts cp ON cu.user_id = cp.user_id;

-- 4. Get the total number of posts made by each user.
SELECT cu.user_id, cu.user_name, COUNT(cp.post_id) AS total_posts
FROM community_users cu
LEFT JOIN community_posts cp ON cu.user_id = cp.user_id
GROUP BY cu.user_id, cu.user_name;



-- dataset 2
-- Question 1: What are the event names and their categories for events happening after '2024-05-15'?
SELECT event_name, category
FROM events
WHERE event_date > '2024-05-15';

-- Question 2: How many attendees participated in each event?
SELECT e.event_name, COUNT(ea.attendance_id) AS number_of_attendees
FROM events e
LEFT JOIN event_attendance ea ON e.event_id = ea.event_id
GROUP BY e.event_name;

-- Question 3: What are the names and categories of events that have more than two attendees?
SELECT e.event_name, e.category
FROM events e
JOIN event_attendance ea ON e.event_id = ea.event_id
GROUP BY e.event_name, e.category
HAVING COUNT(ea.attendance_id) > 2;

-- Question 4: What are the names and categories of events that 
SELECT e.event_name, e.category
FROM events e
JOIN event_attendance ea ON e.event_id = ea.event_id
GROUP BY e.event_name, e.category


