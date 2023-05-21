<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Member My Page" />
<%@ include file="../common/head.jspf"%>
<%@ page import="com.koreaIT.kkwo.exam.demo.util.Ut"%>

<div class="container">
	<div class="myPage">
		<h1>회원정보</h1>
		<table class="w-100p" border="1">
			<colgroup>
				<col width="40%" />
				<col width="60%" />
			</colgroup>
			<tbody>
				<tr>
					<th>회원 번호</th>
					<td>${member.id }</td>
				</tr>
				<tr>
					<th>가입 날짜</th>
					<td>${member.regDate}</td>
				</tr>
				<tr>
					<th>수정 날짜</th>
					<td>${member.updateDate }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${member.name }</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${member.email }</td>
				</tr>
				<tr>
					<th></th>
					<td class="flex-jc-c"><a class="btn" href="../member/checkPw">수정</a></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>