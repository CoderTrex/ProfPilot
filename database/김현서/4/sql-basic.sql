-- update users set role = 'prof'  where id = '2'

-- drop table attendance
-- drop table lecture_users
-- drop table flight
-- drop table lecture
-- drop table users

-- select * from flight
-- select * from users
-- select * from attendance
-- select * from lecture
-- select * from users_lectures
-- select * from building

-- delete from lecture
-- where id < 10
-- where name = '풀스텍네트워크서비스'

-- delete from flight
-- where id < 10

delete from attendance
where id < 100000


-- INSERT INTO building (university_id, building_name, building_lat, building_lon, building_allowed_distance)
-- VALUES (1, '전자정보대학', '37.239481', '127.083433', '70');
-- value(1, '예술디자인종합대학', '37.241788', '127.084421', '65')