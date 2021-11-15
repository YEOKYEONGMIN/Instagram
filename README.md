# Instagram
인스타그램 클론코딩

로그인, 회원가입, 게시글쓰기, 댓글, 게시글좋아요, 댓글좋아요 구현


### member테이블
```
- CREATE TABLE `member` (
  `id` varchar(20) NOT NULL,
  `passwd` varchar(45) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `web` varchar(50) DEFAULT NULL,
  `memo` varchar(200) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `profileImg` varchar(255) DEFAULT NULL,
  `birthday` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
```
### board테이블
```
CREATE TABLE `board` (
  `num` int NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `content` text,
  `likecount` int DEFAULT '0',
  `regDate` datetime DEFAULT NULL,
  `ipaddr` varchar(20) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`num`)
)
```
### attach테이블
```
CREATE TABLE `attach` (
  `uuid` varchar(36) NOT NULL,
  `uploadpath` varchar(10) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `bno` int DEFAULT NULL,
  PRIMARY KEY (`uuid`)
)
```
### reply테이블
```
CREATE TABLE `reply` (
  `num` int NOT NULL,
  `reply_bno` int DEFAULT NULL,
  `reply_username` varchar(20) DEFAULT NULL,
  `reply_comment` varchar(255) DEFAULT NULL,
  `reply_likecount` int DEFAULT NULL,
  `reply_regDate` datetime DEFAULT NULL,
  PRIMARY KEY (`num`)
)
```
### boardlike테이블
```
CREATE TABLE `boardlike` (
  `username` varchar(20) NOT NULL,
  `bno` int NOT NULL,
  `isLike` bit(1) DEFAULT NULL
)
```
### replylike테이블
```
CREATE TABLE `replylike` (
  `replylike_username` varchar(20) DEFAULT NULL,
  `replylike_num` int DEFAULT NULL,
  `replylike_like` bit(1) DEFAULT NULL,
  `replylike_regDate` datetime DEFAULT NULL,
  `bno` int DEFAULT NULL
)
```
