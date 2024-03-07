SELECT to_user_id
FROM messages INDEXED BY search_messages_by_from_user_id
WHERE from_user_id = (SELECT id FROM users WHERE username = 'creativewisdom377')
GROUP BY to_user_id
ORDER BY COUNT(*) DESC
LIMIT 3;
