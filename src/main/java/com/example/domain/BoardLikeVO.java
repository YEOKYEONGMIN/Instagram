package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardLikeVO {
	private String username;
	private Integer bno;
	private int isLike;
}
