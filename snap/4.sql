SELECT "username" FROM "users"
JOIN "messages" ON "messages"."to_user_id" = "users"."id"
GROUP BY "to_user_id"
ORDER BY COUNT("to_user_id") DESC, "username" ASC
LIMIT 1;