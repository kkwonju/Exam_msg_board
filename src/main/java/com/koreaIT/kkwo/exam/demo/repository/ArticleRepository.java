package com.koreaIT.kkwo.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.koreaIT.kkwo.exam.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	@Insert("""
			INSERT INTO TB_ARTICLE
			SET regDate = NOW(),
			updateDate = NOW(),
			title = #{title},
			`body` = #{body},
			memberId = #{memberId};
			""")
	public void writeArticle(String title, String body, int memberId);

	@Select("""
			SELECT *
			FROM TB_ARTICLE
			WHERE id = #{id}
			""")
	public Article getArticle(int id);

	@Select("""
			<script>
			SELECT *, M.name AS extra__writer
			FROM TB_ARTICLE AS A
			INNER JOIN TB_MEMBER AS M
			ON A.memberId = M.id
			WHERE A.id = #{id}
			</script>
			""")
	public Article getForPrintArticle(int id);

	@Select("""
			<script>
				SELECT *, M.name AS extra__writer
				FROM TB_ARTICLE AS A
				INNER JOIN TB_MEMBER AS M
				ON A.memberId = M.id
				ORDER BY A.id DESC
				<if test="limitFrom >= 0">
					LIMIT #{limitFrom}, #{itemsInAPage}
				</if>
			</script>
			""")
	public List<Article> getForPrintArticles(int limitFrom, int itemsInAPage);
	
	@Select("""
			SELECT *
			FROM TB_ARTICLE
			ORDER BY id DESC
			""")
	public List<Article> getArticles();

	@Update("""
			UPDATE TB_ARTICLE
			SET updateDate = NOW(),
			title = #{title},
			`body` = #{body}
			WHERE id = #{id};
			""")
	public void modifyArticle(int id, String title, String body);

	@Delete("""
			DELETE FROM TB_ARTICLE
			WHERE id = #{id};
			""")
	public void deleteArticle(int id);

	@Select("""
			SELECT LAST_INSERT_ID();
			""")
	public int getLastInsertId();

	@Select("""
			SELECT COUNT(*)
			FROM TB_ARTICLE
			""")
	public int getArticlesCount();

}