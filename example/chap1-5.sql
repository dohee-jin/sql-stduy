-- 1. POSTS 테이블에 숫자 타입의 view_count 컬럼을 추가합니다.
ALTER TABLE POSTS ADD (view_count NUMBER);

-- 2. 모든 게시물에 100 ~ 50000 사이의 임의의 조회수 데이터를 넣어줍니다.
UPDATE POSTS
SET view_count = TRUNC(DBMS_RANDOM.VALUE(100, 50000));

-- 3. 변경사항을 최종 저장합니다.
COMMIT;

SELECT * FROM POSTS;

SELECT COUNT(*) FROM USERS;

SELECT username FROM USERS;

SELECT COUNT(username) FROM USERS;

-- 모든 집계함수는 NULL 값을 무시합니다.
SELECT COUNT(manager_id) FROM USERS;

-- POSTS 테이블에서 view_count의 최솟값과 최댓값을 찾습니다.
SELECT
    MIN(view_count) AS "최저 조회수",
    MAX(view_count) AS "최고 조회수"
FROM
    POSTS;


-- 모든 게시물의 view_count를 합산합니다.
SELECT SUM(view_count) AS "총 조회수"
FROM POSTS;

SELECT view_count
FROM POSTS;

UPDATE POSTS 
SET VIEW_COUNT = NULL
WHERE POST_ID = 2;

SELECT * FROM POSTS
WHERE post_id BETWEEN 1 AND 3 
;

SELECT SUM(VIEW_COUNT)
FROM POSTS
WHERE POST_ID BETWEEN 1 AND 3 
;

SELECT 
    AVG(VIEW_COUNT) AS "평균 조회수",
    SUM(VIEW_COUNT) AS "총 조회수",
    COUNT(VIEW_COUNT) AS "게시물 수"
FROM POSTS
WHERE POST_ID BETWEEN 1 AND 3 
;

SELECT COUNT(*) AS "총 댓글수" FROM COMMENTS;

-- 유저별로 피드를 몇개씩 썼는지 알고 싶다.
SELECT 
    USER_ID,
    COUNT(*) AS "유저별 피드 수"
FROM POSTS
GROUP BY USER_ID -- USER ID가 같은 게시물끼리 묶는다
ORDER BY USER_ID
;

SELECT 
    USER_ID,
    POST_TYPE,
    CONTENT
FROM POSTS
ORDER BY USER_ID, POST_TYPE
;

SELECT 
    USER_ID, 
    POST_TYPE,
    COUNT(*) AS "유저의 종류별 피드 수"
FROM POSTS
GROUP BY USER_ID, POST_TYPE -- USER ID와 POST_TYPE이 같은 게시물끼리 묶는다
ORDER BY USER_ID
;

SELECT 
    USER_ID, 
    POST_TYPE,
    COUNT(*) AS "유저의 종류별 피드 수"
FROM POSTS
GROUP BY USER_ID, POST_TYPE -- USER ID와 POST_TYPE이 같은 게시물끼리 묶는다
ORDER BY USER_ID
;


SELECT
    user_id,
    COUNT(*) AS post_count
FROM
    POSTS
GROUP BY
    USER_ID
HAVING COUNT(*) >= 10 -- 게시물을 10개 이상 쓴 사용자만 조회
;

-- POSTS 테이블에서 장문(20글자 이상)의 피드를 쓴 게시물들
-- 유저별로 보고 싶음
SELECT
    COUNT(*) AS "장문 게시물 수"
FROM POSTS
WHERE LENGTH(content) >= 25 -- LENGTH 함수로 글자 수를 계산합니다. 
GROUP BY USER_ID
HAVING COUNT(*) >= 5
; 


SELECT
    post_id,
    COUNT(*) AS like_count
FROM
    LIKES
WHERE creation_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') -- 1. 개별 '좋아요' 데이터를 먼저 필터링
GROUP BY
    post_id -- 2. 게시물 ID 별로 그룹화
HAVING COUNT(*) >= 20 -- 3. 그룹별 '좋아요' 수가 20개 이상인 그룹만 필터링
;