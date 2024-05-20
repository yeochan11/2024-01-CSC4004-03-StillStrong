-- user 테이블에 데이터 삽입
insert into user(user_nickname, user_age, user_gender, user_image, user_allergy, user_favorite) values('유저1', 20, true, '경로', '사과', '돼지고기');
insert into user(user_nickname, user_age, user_gender, user_image, user_allergy, user_favorite) values('유저2', 30, true, '경로', '사과', '돼지고기');
insert into user(user_nickname, user_age, user_gender, user_image, user_allergy, user_favorite) values('유저3', 40, true, '경로', '사과', '돼지고기');

-- refrigeList 테이블에 데이터 삽입
insert into refrige_list(user_id, refrige_name) values(1, '기본냉장고1');
insert into refrige_list(user_id, refrige_name) values(2, '기본냉장고2');
insert into refrige_list(user_id, refrige_name) values(3, '기본냉장고3');

