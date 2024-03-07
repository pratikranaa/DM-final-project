CREATE INDEX "idx_student_enrollments" ON "enrollments" ("student_id");
CREATE INDEX "idx_course_dept_num_semester" ON "courses" ("department", "number", "semester");
CREATE INDEX "idx_course_title_semester" ON "courses" ("title", "semester");
