DROP DATABASE IF EXISTS EXAM_board_db;
CREATE DATABASE EXAM_board_db;
USE EXAM_board_db;

# TB_MEMBER 테이블 추가
CREATE TABLE TB_MEMBER (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(50) NOT NULL,
    email CHAR(50) NOT NULL UNIQUE,
    loginPw CHAR(100) NOT NULL
);

INSERT INTO TB_MEMBER
SET regDate = NOW(),
updateDate = NOW(),
`name` = '홍길동',
email = 'hong@gmail.com',
loginPw = 'pw1';

INSERT INTO TB_MEMBER
SET regDate = NOW(),
updateDate = NOW(),
`name` = '허준',
email = 'joon@gmail.com',
loginPw = 'pw2';

INSERT INTO TB_MEMBER
SET regDate = NOW(),
updateDate = NOW(),
`name` = '임꺽정',
email = 'lim@gmail.com',
loginPw = 'pw3';


# TB_ARTICLE 테이블 추가
CREATE TABLE TB_ARTICLE (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title VARCHAR(100) NOT NULL,
    `body` TEXT NOT NULL,
    memberId INT NOT NULL
);

INSERT INTO TB_ARTICLE
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
memberId = 1;

INSERT INTO TB_ARTICLE
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
memberId = 3;

INSERT INTO TB_ARTICLE
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
memberId = 2;

# TB_REPLY
CREATE TABLE TB_REPLY(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body` TEXT NOT NULL
);

# 2번 회원이 2번 글에 댓글
INSERT INTO TB_REPLY
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 1';

# 2번 회원이 2번 글에 댓글
INSERT INTO TB_REPLY
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 2';

# 3번 회원이 2번 글에 댓글
INSERT INTO TB_REPLY
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 3';

# 3번 회원이 3번 글에 댓글
INSERT INTO TB_REPLY
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 3,
`body` = '댓글 4';

SELECT LAST_INSERT_ID();

##############################
SELECT * FROM TB_MEMBER;
SELECT * FROM TB_ARTICLE;
SELECT * FROM TB_REPLY;