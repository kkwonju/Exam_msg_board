package com.koreaIT.kkwo.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private String title;
	private String body;
	private int memberId;
	
	private String extra__writer;
	
	private boolean actorCanDelete;
	private boolean actorCanModify;
}