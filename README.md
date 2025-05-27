

# PostgreSQL এর কিছু টপিক নিয়ে আলোচনা ।

---

### Primary Key & Foreign Key !

PostgreSQL-এ Primary Key এবং Foreign Key হলো দুটি গুরুত্বপূর্ণ Relational Database Constraint, যেগুলো ডেটাবেসে ডেটা সংরক্ষণের সময় Integrity ও Relationship বজায় রাখতে সাহায্য করে।.

---

## Primary Key

**Primary Key** হলো এমন একটি কলাম বা কলামসমষ্টি যা একটি টেবিলের প্রতিটি রেকর্ডকে **অন্যদের থেকে আলাদা ও স্বতন্ত্রভাবে চিহ্নিত করে**।

###  বৈশিষ্ট্যসমূহ:
- প্রতিটি টেবিলে **মাত্র একটি** Primary Key থাকতে পারে।
- এটি স্বয়ংক্রিয়ভাবে **UNIQUE** এবং **NOT NULL** কনস্ট্রেইন্ট প্রয়োগ করে।
- ডুপ্লিকেট মান গ্রহণ করে না।
- NULL মান গ্রহণ করে না।

### উদাহরণ:
```sql
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name TEXT
);
````

এখানে `student_id` একটি Primary Key, যা প্রতিটি শিক্ষার্থীকে স্বতন্ত্রভাবে চিহ্নিত করে।

---

##  Foreign Key

### সংজ্ঞা:

**Foreign Key** হলো এমন একটি কলাম বা কলামসমষ্টি যা অন্য একটি টেবিলের Primary Key বা Unique Key-কে **রেফারেন্স করে**, এবং দুইটি টেবিলের মধ্যে **সম্পর্ক (relationship)** তৈরি করে।

###  বৈশিষ্ট্যসমূহ:

* একটি টেবিলে একাধিক Foreign Key থাকতে পারে।
* এটি ডেটার **referential integrity** নিশ্চিত করে।
* এটি নিশ্চিত করে যে যে মান রেফারেন্স করা হয়েছে, তা মূল টেবিলে (parent table) বিদ্যমান আছে।
* বিভিন্ন action নির্ধারণ করা যায়:
  `ON DELETE CASCADE`, `ON UPDATE CASCADE` ইত্যাদি।

### উদাহরণ:

```sql
CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  course_name TEXT
);

CREATE TABLE enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT,
  course_id INT,
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

এখানে `enrollments` টেবিলের `course_id` কলামটি `courses` টেবিলের `course_id`-কে রেফারেন্স করছে। অর্থাৎ, একজন শিক্ষার্থী কেবলমাত্র সেই কোর্সে রেজিস্টার করতে পারবে, যা আগে থেকেই `courses` টেবিলে আছে।

---

## তুলনামূলক পার্থক্য (Primary Key vs Foreign Key)

| বৈশিষ্ট্য         | Primary Key                  | Foreign Key                       |
| ----------------- | ---------------------------- | --------------------------------- |
| উদ্দেশ্য          | টেবিলের রেকর্ড আলাদা করা     | অন্য টেবিলের রেকর্ড রেফারেন্স করা |
| ইউনিক মান         | হ্যাঁ                        | না (ডুপ্লিকেট থাকতে পারে)         |
| NULL গ্রহণযোগ্যতা | না (NOT NULL)                | হ্যাঁ (NULL থাকতে পারে)           |
| সংখ্যা            | প্রতি টেবিলে একটি            | একাধিক থাকতে পারে                 |
| Integrity         | Entity Integrity নিশ্চিত করে | Referential Integrity নিশ্চিত করে |

---

##  উপসংহার:

* **Primary Key** ব্যবহৃত হয় প্রতিটি রেকর্ডকে ইউনিকভাবে শনাক্ত করতে।
* **Foreign Key** ব্যবহৃত হয় বিভিন্ন টেবিলের মধ্যে সম্পর্ক তৈরি ও ডেটার সঠিকতা বজায় রাখতে।
