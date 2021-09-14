package com.example.domain;


import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String passwd;
	private String name;
	private String username;
	private String web;
	private String memo;
	private String email;
	private String phone;
	private String gender;
	private String profileImg;
	private String birthday;
}
