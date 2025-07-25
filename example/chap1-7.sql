-- 댓글 테이블 조회
SELECT * FROM COMMENTS;
SELECT * FROM POSTS;

-- 오라클 조인, 표준조인(디비에 따른 분류)
-- 내부 조인, 외부 조인(디비랑 관계없이 분류)

-- 댓글의 게시물과 피드의 내용을 함께 조회
-- 조인 개수는 테이블 개수 - 1
SELECT
    P.USER_ID,
    U.USERNAME,
    P.POST_ID,
    P.CONTENT,
    P.VIEW_COUNT,
    TO_CHAR(P.CREATION_DATE, 'YYYY-MM-DD') AS CREATED_AT,
    U2.USERNAME AS COMMENTER,
    C.COMMENT_TEXT
FROM POSTS P
INNER JOIN COMMENTS C
ON P.POST_ID = C.POST_ID
INNER JOIN USERS U 
ON P.USER_ID = U.USER_ID
INNER JOIN USERS U2
ON C.USER_ID = U2.USER_ID
;

-- OUTER JOIN
SELECT * FROM USERS;         -- 필수 정보
SELECT * FROM USER_PROFILES; -- 선택 정보


-- INNER JOIN의 문제점: 값이 매칭되는 경우만 조회됨
-- 상세 프로필을 적지 않은 회원은 나타나지 않음
SELECT
    U.USER_ID,
    U.USERNAME,
    U.EMAIL,
    UP.FULL_NAME,
    UP.BIO
FROM USERS U
JOIN USER_PROFILES UP
ON U.USER_ID = UP.USER_ID
;

-- 우선 회원정보는 모두 조회하고 단, 상세 프로필이 있으면 걔네만 같이 조회해라
SELECT
    *
FROM USERS U
LEFT JOIN USER_PROFILES UP
ON U.USER_ID = UP.USER_ID
ORDER BY U.USER_ID
;

-- 오라클 외부 조인: LEFT -> 오른쪽 조건에 (+), RIGHT -> 왼쪽 조건에 (+)
-- 오라클은 풀 조인없음: LEFT, RIGHT 조인 후 UNION 연산으로 구현
SELECT
    *
FROM USERS U
, USER_PROFILES UP
WHERE U.USER_ID = UP.USER_ID 
ORDER BY U.USER_ID
;
