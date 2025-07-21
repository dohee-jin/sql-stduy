-- 1
SELECT * -- * 은 실무에서 잘 사용하지 않음, 
FROM HASHTAGS
;

-- 2
SELECT CONTENT, CREATION_DATE
FROM POSTS
;

-- 3
SELECT DISTINCT USER_ID
FROM LIKES
;

-- 4
SELECT 
    FULL_NAME AS "전체 이름",
    BIO AS "자기소개"
FROM USER_PROFILES
;

-- 5
SELECT 
    USER_ID || ' 님이 ' || COMMENT_TEXT 
    || ' 라고 댓글을 남겼습니다.' AS "댓글 알림"
FROM COMMENTS;