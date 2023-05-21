package com.koreaIT.kkwo.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.kkwo.exam.demo.service.ArticleService;
import com.koreaIT.kkwo.exam.demo.service.ReplyService;
import com.koreaIT.kkwo.exam.demo.util.Ut;
import com.koreaIT.kkwo.exam.demo.vo.Article;
import com.koreaIT.kkwo.exam.demo.vo.Reply;
import com.koreaIT.kkwo.exam.demo.vo.ResultData;
import com.koreaIT.kkwo.exam.demo.vo.Rq;

@Controller
public class UsrArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private Rq rq;

	public UsrArticleController(ArticleService articleService, ReplyService replyService) {
		this.articleService = articleService;
		this.replyService= replyService;
	}
	
	@RequestMapping("/usr/article/write")
	public String showWriteArticlePage() {
		return "usr/article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(String title, String body) {
		if (Ut.empty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}

		if (Ut.empty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		ResultData writeRd = articleService.writeArticle(title, body, rq.getLoginedMemberId());

		int id = (int) writeRd.getData1();

		return Ut.jsReplace("S-1", Ut.f("%d번 글이 생성되었습니다", id), "/usr/article/list");
	}
	
	@RequestMapping("/usr/article/list")
	public String showArticleListPage(Model model, @RequestParam(defaultValue = "1") int page) {
		
		int articlesCount = articleService.getArticlesCount();

		int itemsInAPage = 10;
		int totalPage = (int) Math.ceil((double) articlesCount / itemsInAPage);
		
		List<Article> articles = articleService.getForPrintArticles(page, itemsInAPage, articlesCount);
		
		model.addAttribute("articles", articles);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", page);
		return "usr/article/list";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showArticleDetailPage(Model model, int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		if(article == null) {
			return rq.jsHistoryBackOnView(Ut.f("%d번 게시물은 존재하지 않습니다", id));
		}
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);
		int repliesCount = replies.size();
		
		model.addAttribute("article", article);
		model.addAttribute("replies", replies);
		model.addAttribute("repliesCount", repliesCount);
		return "usr/article/detail";
	}
	
	/* 게시글 수정 페이지 */
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBackOnView(Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanModifyRd.getMsg());
		}

		model.addAttribute("article", article);
		return "usr/article/modify";
	}

	/* 게시글 수정 */
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		Article article = articleService.getArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return Ut.jsHistoryBack("F-2", actorCanModifyRd.getMsg());
		}

		articleService.modifyArticle(id, title, body);

		return Ut.jsReplace("S-1", Ut.f("%d번 글을 수정했습니다", id), Ut.f("../article/detail?id=%d", id));
	}

	/* 게시글 삭제 */
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Article article = articleService.getArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-4", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		if (article.getMemberId() != rq.getLoginedMemberId()) {
			return Ut.jsHistoryBack("F-4", Ut.f("%d번 글에 대한 권한이 없습니다", id));
		}

		articleService.deleteArticle(id);

		return Ut.jsReplace("S-1", Ut.f("%d번 글을 삭제했습니다", id), "../article/list");
	}
}