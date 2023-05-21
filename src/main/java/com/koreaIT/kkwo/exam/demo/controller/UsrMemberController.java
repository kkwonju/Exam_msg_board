package com.koreaIT.kkwo.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.kkwo.exam.demo.service.MemberService;
import com.koreaIT.kkwo.exam.demo.util.Ut;
import com.koreaIT.kkwo.exam.demo.vo.Member;
import com.koreaIT.kkwo.exam.demo.vo.ResultData;
import com.koreaIT.kkwo.exam.demo.vo.Rq;

@Controller
public class UsrMemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;

	public UsrMemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@RequestMapping("/usr/member/join")
	public String showJoinPage() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String name, String email, String loginPw) {

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-0", "로그아웃 후 이용해주세요");
		}
		
		if(Ut.empty(name)) {
			return Ut.jsHistoryBack("F-1", "이름을 입력하세요");
		}
		if(Ut.empty(email)) {
			return Ut.jsHistoryBack("F-1", "이메일을 입력하세요");
		}
		if(Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-1", "비밀번호를 입력하세요");
		}

		ResultData<Integer> joinRd = memberService.doJoin(name, email, loginPw);

		if (joinRd.isFail()) {
			return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		return Ut.jsReplace("S-1", Ut.f("회원가입이 완료되었습니다"), "/");
	}

	@RequestMapping("/usr/member/login")
	public String showLoginPage(Model model) {
		return "usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String email, String loginPw) {
		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-0", "이미 로그인 상태입니다");
		}

		if (Ut.empty(email)) {
			return Ut.jsHistoryBack("F-1", "이메일을 입력해주세요");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");
		}

		Member member = memberService.getMemberByEamil(email);

		if (member == null) {
			return Ut.jsHistoryBack("F-3", "존재하지 않는 계정입니다");
		}
		
		if(!member.getLoginPw().equals(loginPw)) {
			return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다");
		}

		rq.login(member);

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getName()), "/");
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {

		rq.logout();

		return Ut.jsReplace("S-1", "로그아웃 되었습니다", "/");
	}

	@RequestMapping("/usr/member/myPage")
	public String showMyPage(Model model) {
		Member member = rq.getLoginedMember();
		model.addAttribute("member", member);
		return "usr/member/myPage";
	}

	@RequestMapping("/usr/member/checkPw")
	public String showCheckPw(Model model) {
		return "usr/member/checkPw";
	}

	@RequestMapping("/usr/member/doCheckPw")
	@ResponseBody
	public String checkPw(String loginPw) {

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-1", "비밀번호를 입력해주세요");
		}

		if (!loginPw.equals(rq.getLoginedMember().getLoginPw())) {
			return Ut.jsHistoryBack("F-1", "비밀번호가 틀립니다");
		}

		return Ut.jsReplace("S-1", "비밀번호 일치", "/usr/member/modify");
	}

	@RequestMapping("/usr/member/modify")
	public String showModifyForm() {
		return "usr/member/modify";
	}

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String name, String email, String loginPw) {

		if (Ut.empty(name)) {
			return Ut.jsHistoryBack("F-1", "이름을 입력해주세요");
		}
		if (Ut.empty(email)) {
			return Ut.jsHistoryBack("F-1", "이메일을 입력해주세요");
		}
		if (Ut.empty(loginPw)) {
			loginPw = null;
		}

		Member member = memberService.getMemberById(rq.getLoginedMemberId());

		ResultData memberModifyRd = memberService.modifyMember(rq.getLoginedMemberId(), name, email, loginPw);

		return Ut.jsReplace(memberModifyRd.getResultCode(), memberModifyRd.getMsg(), "../member/myPage");
	}
}