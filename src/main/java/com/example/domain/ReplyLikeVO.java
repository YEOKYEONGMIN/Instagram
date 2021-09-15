package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyLikeVO {
	private String replylikeUsername;
	private Integer replylikeNum;
	private Integer replylikeLike;
	private Timestamp replylikeRegDate;
}
