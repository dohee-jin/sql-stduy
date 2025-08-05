
-- 라이언이 작성한 모든 게시물을 조회
SELECT * 
FROM POSTS      -- 서브쿼리는 () 안에 작성
WHERE USER_ID IN (  -- '=' 하나의 값만 들어가야되기 때문에 두개 이상의 결과를 반환할때는 IN으로 사용해야 한다.
    SELECT USER_ID
    FROM USERS 
    WHERE USERNAME = 'choonsik' OR USERNAME = 'ryan'
)
;

-- 우리 피드 데이터에서 평균 조회수보다 높은 조회수를 가진 게시물 조회
SELECT AVG(VIEW_COUNT) 
FROM POSTS
;

SELECT *
FROM POSTS
WHERE VIEW_COUNT > (
    SELECT AVG(VIEW_COUNT) 
    FROM POSTS
)
;

-- 카카오그룹에 있는 사용자의 모든 아이디를 조회
SELECT user_id, USERNAME
FROM USERS
WHERE MANAGER_ID = 1
;

-- 카카오 그룹에 있는 사용자들이 작성한 모든 피드 조회
SELECT *
FROM POSTS
WHERE user_id IN(
    SELECT user_id
    FROM USERS
    WHERE MANAGER_ID IS NULL
)
;

-- ANY 는 서브쿼리의 결과 중 하나라도 만족하는 경우를 찾음
-- ALL 은 서브쿼리의 결과 전체를 만족하는 경우만 찾음
SELECT *
FROM POSTS         
WHERE VIEW_COUNT > ALL (
    SELECT AVG(VIEW_COUNT) 
    FROM POSTS
    GROUP BY USER_ID
)
;

-- =, <>, <, >, <=, >= 단일행 연산자는 단일행 서브쿼리에만 가능
-- IN, ANY, ALL 다중행 연산자는 다중행 서브쿼리에만 가능

SELECT *
FROM POSTS 
;

SELECT TAG_ID
FROM HASHTAGS
WHERE TAG_NAME = '#포켓몬'
;

SELECT POST_ID 
FROM POST_TAGS
WHERE TAG_ID = 1003
;


SELECT *
FROM POSTS
WHERE POST_ID IN (
    SELECT POST_ID 
    FROM POST_TAGS
    WHERE TAG_ID = (
        SELECT TAG_ID
        FROM HASHTAGS
        WHERE TAG_NAME = '#포켓몬'
    )
)
;

SELECT P.*, U.USERNAME
FROM POSTS P 
LEFT JOIN USERS U  
ON P.USER_ID = U.USER_ID
WHERE P.POST_ID IN (
    SELECT POST_ID
    FROM POST_TAGS
    WHERE TAG_ID = (
        SELECT TAG_ID
        FROM HASHTAGS
        WHERE TAG_NAME = '#포켓몬'
    )
)
;

-- 피카츄가 올린 피드에 좋아요 찍은 사람들의 이름을 조회
SELECT * FROM LIKES;

-- 피카츄가 올린 피드의 POST_ID를 찾음
SELECT POST_ID
FROM POSTS 
WHERE USER_ID = 21;

-- 피카츄 유저 아이디 찾기
SELECT USER_ID
FROM USERS
WHERE USERNAME = 'pikachu'
;

-- 피카츄가 올린 피드에 좋아요 찍은 내용들을 필터링
SELECT USERNAME 
FROM LIKES L
JOIN USERS U
ON L.USER_ID = U.USER_ID
WHERE POST_ID IN (
    SELECT POST_ID
    FROM POSTS 
    WHERE USER_ID = (
        SELECT USER_ID
        FROM USERS
        WHERE USERNAME = 'pikachu'
    )
)
;

-- From 절 서브쿼리: 인라인 뷰
-- 인라인 뷰 서브쿼리 (FROM 절에 서브쿼리 사용)
-- 사용자별 피드 작성 개수
SELECT
    PC.USER_ID,
    U.USERNAME,
    PC.POST_COUNT
FROM USERS U
JOIN (
    SELECT USER_ID, COUNT(*) AS POST_COUNT
    FROM POSTS 
    GROUP BY USER_ID
) PC
ON PC.USER_ID = U.USER_ID
;

SELECT 
    USER_ID,
    COUNT(*) AS total_likes
FROM LIKES
GROUP BY USER_ID
ORDER BY USER_ID
;

SELECT
    A.USER_ID,
    U.USERNAME,
    A.total_likes
FROM (
    SELECT 
        USER_ID,
        COUNT(*) AS total_likes
    FROM LIKES
    GROUP BY USER_ID
) A, USERS U 
WHERE A.USER_ID = U.USER_ID
;

SELECT
    A.USER_ID,
    U.USERNAME,
    A.total_likes
FROM (
    SELECT 
        USER_ID,
        COUNT(*) AS total_likes
    FROM LIKES
    GROUP BY USER_ID
) A
JOIN USERS U 
ON A.USER_ID = U.USER_ID
;

SELECT
    USER_ID,
    U.USERNAME,
    A.total_likes
FROM (
    SELECT 
        USER_ID,
        COUNT(*) AS total_likes
    FROM LIKES
    GROUP BY USER_ID
) A
NATURAL JOIN USERS U 
-- ON A.USER_ID = U.USER_ID
;

-- 스칼라 서브쿼리 (SELECT 절에 서브쿼리 사용)
-- 유저정보를 조회(USERS) + 상세 bio(USER_PROFILES)도 같이 조회

-- 스칼라 서브쿼리 == 연관 서브쿼리
-- 연관 서브쿼리: 서브쿼리가 한 번 실행되고 끝나는게 아니라 
-- 바깥쪽 메인 쿼리 한 행을 실행할 때 마다 반복 실행
SELECT
    U.USER_ID,
    U.USERNAME,
    (SELECT BIO FROM USER_PROFILES UP WHERE U.USER_ID = UP.USER_ID) AS BIO
FROM USERS U 
;

SELECT *
FROM USERS
;

-- 피드별로 피드의 ID와 피드의 내용과 각 피드가 받은 좋아요 수를 한번에 조회
SELECT
    -- 피드의 ID ,
    -- 피드의 내용,
    POST_ID,
    CONTENT
FROM POSTS
ORDER BY POST_ID 
;

SELECT COUNT(*) AS LIKE_COUNT
FROM LIKES;

SELECT 
    P.POST_ID, 
    P.CONTENT,
    NVL(LC.LIKE_COUNT, 0) AS LIKE_COUNT,
    NVL(RC.REPLY_COUNT, 0) AS REPLY_COUNT
FROM POSTS P
LEFT OUTER JOIN (
    SELECT POST_ID, COUNT(*) AS LIKE_COUNT
    FROM LIKES
    GROUP BY POST_ID
) LC
ON P.POST_ID = LC.POST_ID
LEFT OUTER JOIN (
    SELECT 
        POST_ID, COUNT(*) AS REPLY_COUNT
    FROM COMMENTS
    GROUP BY POST_ID
) RC
ON RC.POST_ID = P.POST_ID
ORDER BY P.POST_ID
;


SELECT 
    POST_ID, COUNT(*) AS REPLY_COUNT
FROM COMMENTS
GROUP BY POST_ID
ORDER BY POST_ID
;

-- 게시물을 한 번이라도 작성한 적이 있는 모든 사용자의 이름을 알려주세요. 
SELECT 
    P.USER_ID, 
    U.USERNAME 
FROM POSTS P 
JOIN USERS U 
ON P.USER_ID = U.USER_ID
ORDER BY USER_ID
;


SELECT
    u.username
FROM
    USERS u
WHERE
    EXISTS (SELECT 1 -- SELECT 절에 무엇이 오든 상관없어요. 존재 여부만 체크!
            FROM POSTS p
            WHERE p.user_id = u.user_id); -- 바깥 쿼리의 사용자가 쓴 게시물이 있는지 확인


SELECT 
    u.user_id, u.username
FROM 
    USERS u 
ORDER BY u.user_id
;

SELECT
    u.username
FROM
    USERS u
WHERE
    NOT EXISTS (SELECT 1 -- SELECT 절에 무엇이 오든 상관없어요. 존재 여부만 체크!
            FROM POSTS p
            WHERE p.user_id = u.user_id); -- 바깥 쿼리의 사용자가 쓴 게시물이 있는지 확인


SELECT 1 FROM USERS;

