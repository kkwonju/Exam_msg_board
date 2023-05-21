package com.koreaIT.kkwo.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreaIT.kkwo.exam.demo.repository.ArticleRepository;
import com.koreaIT.kkwo.exam.demo.util.Ut;
import com.koreaIT.kkwo.exam.demo.vo.Article;
import com.koreaIT.kkwo.exam.demo.vo.ResultData;

@Service
public class ArticleService {
	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	/* 게시글 작성 */
	public ResultData<Integer> writeArticle(String title, String body, int memberId) {
		articleRepository.writeArticle(title, body, memberId);
		int id = articleRepository.getLastInsertId();
		return ResultData.from("S-1", Ut.f("%d번 글 생성", id), "id", id);
	}

	/* 게시물 가져오기 */
	public Article getArticle(int id) {
		return articleRepository.getArticle(id);
	}

	/* 출력용 게시물 가져오기 */
	public Article getForPrintArticle(int actorId, int id) {
		Article article = articleRepository.getForPrintArticle(id);

		controlForPrintData(actorId, article);

		return article;
	}

	/* 출력용 게시물 리스트 가져오기 */
	public List<Article> getForPrintArticles(int page, int itemsInAPage, int articlesCount) {

		int limitFrom = (page - 1) * itemsInAPage;

		return articleRepository.getForPrintArticles(limitFrom, itemsInAPage);
	}

	// 손 댈 수 있는지 여부
	private void controlForPrintData(int actorId, Article article) {
		if (article == null) {
			return;
		}

		ResultData actorCanModifyRd = actorCanModify(actorId, article);
		article.setActorCanModify(actorCanModifyRd.isSuccess());

		ResultData actorCanDeleteRd = actorCanDelete(actorId, article);
		article.setActorCanDelete(actorCanDeleteRd.isSuccess());
	}

	/* 수정 권한 체크 */
	public ResultData actorCanModify(int actorId, Article article) {
		if (article.getMemberId() != actorId) {
			return ResultData.from("F-3", "해당 글에 대한 권한이 없습니다");
		}
		return ResultData.from("S-1", "수정 가능");
	}

	/* 삭제 권한 체크 */
	private ResultData actorCanDelete(int actorId, Article article) {
		if (article == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다");
		}
		if (article.getMemberId() != actorId) {
			return ResultData.from("F-2", "해당 게시물에 대한 권한이 없습니다");
		}

		return ResultData.from("S-1", "삭제 가능");
	}

	/* 게시글 수정 */
	public ResultData modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);

		Article article = getArticle(id);

		return ResultData.from("S-1", Ut.f("%d번 글을 수정했습니다", id), "Article", article);
	}

	/* 게시글 삭제 */
	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public int getArticlesCount() {
		return articleRepository.getArticlesCount();
	}

}
