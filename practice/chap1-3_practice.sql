-- 1
SELECT *
FROM USERS
WHERE USERNAME = 'pikachu'
;

-- 2
SELECT *
FROM POSTS 
WHERE CREATION_DATE BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD')
            AND TO_DATE('2023-12-31', 'YYYY-MM-DD')
;

-- 3
SELECT USERNAME, EMAIL
FROM USERS
WHERE USER_ID IN(1, 2, 3, 4, 5, 6, 7, 8) 
;

-- 4
SELECT POST_ID, CONTENT
FROM POSTS
WHERE CONTENT LIKE '%먹스타그램'
;

-- 5
SELECT *
FROM POSTS
WHERE USER_ID IN(1) AND POST_TYPE = 'photo'
;

-- 6
SELECT USERNAME
FROM USERS
WHERE USER_ID NOT BETWEEN 9 AND 20
;


