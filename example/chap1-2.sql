-- USERS 테이블의 모든 컬럼과 데이터를 조회한다
SELECT *
FROM USERS
;

-- USERS 테이블에서 사용자 이름과 이메일만 보고싶음
SELECT USERNAME, EMAIL
FROM USERS
;

-- POSTS 테이블에서 모든 게시물의 정보를 보고 싶음
SELECT *
FROM POSTS
;

-- POSTS 테이블에서 게시물의 타입 정보를 보고 싶음
SELECT POST_TYPE
FROM POSTS
;

-- SELECT 뒤에는 ALL 이 생략되어 있음, ALL - 중복 상관없이 모두, 전체
SELECT ALL POST_TYPE
FROM POSTS
;

-- DISTINCT: 중복값을 제거하고 조회
SELECT DISTINCT POST_TYPE
FROM POSTS
;

-- 열 별칭 정하기
SELECT 
    USERNAME AS "사용자 이름", 
    EMAIL AS "이메일"
FROM USERS
;

-- AS 는 생략이 가능
SELECT 
    USERNAME "사용자 이름", 
    EMAIL "이메일"
FROM USERS
;

-- 별칭: 띄어쓰기가 없으면 "" 따옴표 생략 가능, 쌍따옴표 대신 '' 홑따옴표 사용 X
SELECT 
    USERNAME "사용자 이름", 
    EMAIL 이메일
FROM USERS
;

-- 사용자이름에 추가 문자열을 연결해서 조회, || <- 파이프연산자는 오라클만 가능
-- '' <- 스트링, 문자열 / "" <- 별칭
SELECT USERNAME || '님 환영합니다!!' as "사용자 이름"
FROM USERS
;

SELECT FOLLOWER_ID || '님이' || FOLLOWING_ID || '님을 팔로우합니다.' AS "팔로우 목록"
FROM FOLLOWS
;

-- 사용자의 이름과 가입일을 조합
SELECT USERNAME || '(가입일 :' || REGISTRATION_DATE || ')' AS "시용자 정보"
FROM USERS
;

