CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	sign_up_at TIMESTAMP NOT NUll,
	country_code CHAR(30),
	acquisition_channel VARCHAR(50)
);

CREATE TABLE activity_log (
    event_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id), -- Foreign Key connects the tables
    action_name VARCHAR(100), -- Example: 'file_uploaded', 'friend_invited'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    plan_name VARCHAR(50), -- 'free', 'pro', 'enterprise'
    status VARCHAR(20), -- 'active', 'churned', 'past_due'
    monthly_revenue DECIMAL(10, 2), -- The actual dollar amount
    start_date DATE,
    end_date DATE -- NULL if still active
);

WITH First_Action AS (
    -- Find the very first time each user did something
    SELECT 
        user_id, 
        MIN(created_at) as first_action_at
    FROM activity_log
    GROUP BY user_id
),
User_Activity_Summary AS (
    SELECT 
        u.user_id,
        u.sign_up_at,
        -- This calculates the time difference
        EXTRACT(DAY FROM (fa.first_action_at - u.sign_up_at)) AS days_to_first_action,
        COUNT(CASE WHEN a.action_name = 'file_uploaded' THEN 1 END) AS total_uploads,
        COUNT(CASE WHEN a.action_name = 'friend_invited' THEN 1 END) AS total_invities,
        COUNT(CASE WHEN a.action_name = 'profile_completed' THEN 1 END) AS profile_steps
    FROM Users u
    LEFT JOIN activity_log a ON u.user_id = a.user_id
    LEFT JOIN First_Action fa ON u.user_id = fa.user_id
    GROUP BY u.user_id, u.sign_up_at, fa.first_action_at
),
Conversion_Status AS (
    SELECT 
        user_id,
        CASE WHEN plan_name != 'free' AND status = 'active' THEN 1 ELSE 0 END AS is_converted
    FROM subscriptions
)

SELECT
	uas.*,
	cs.is_converted
FROM user_activity_summary uas
JOIN Conversion_Status cs ON uas.user_id = cs.user_id;
