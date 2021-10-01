package com.example.domain;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class ReplyVO {
	private Integer num;
	private Integer replyBno;
	private String replyUsername;
	private String replyComment;
	private Integer replyLikecount;
	private Timestamp replyRegDate;
	
}
