package com.koreaIT.kkwo.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginPw;
	private String name;
	private String email;
	
	private boolean actorCanDelete;
	private boolean actorCanModify;
}
