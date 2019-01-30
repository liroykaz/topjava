DELETE FROM user_roles WHERE role <> '';
DELETE FROM users WHERE id <> 0;
ALTER SEQUENCE global_seq RESTART WITH 100000;
ALTER SEQUENCE meal_seq RESTART WITH 100000;

INSERT INTO users (name, email, password) VALUES
('User', 'user@yandex.ru', 'password'),
('Admin', 'admin@gmail.com', 'admin');

INSERT INTO user_roles (role, user_id) VALUES
('ROLE_USER', 100000),
('ROLE_ADMIN', 100001);

INSERT INTO meals (user_id, description, calories) VALUES
(100000, 'Супчик', 250),
(100000, 'Салат', 250),
(100000, 'Капучино', 250),
(100000, 'Второе блюдо', 250),
(100000, 'Катлетка', 250);