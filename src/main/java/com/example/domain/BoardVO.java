package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {

	private Integer num;
	private String username;
	private String content;
	private Integer like;
	private Timestamp regDate;
	private String ipaddr;
	private String location;
}




