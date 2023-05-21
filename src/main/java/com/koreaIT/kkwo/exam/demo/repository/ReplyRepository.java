package com.koreaIT.kkwo.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.koreaIT.kkwo.exam.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	@Select("""
			<script>
				SELECT R.*, M.name AS extra__writer
				FROM TB_REPLY AS R
				INNER JOIN TB_MEMBER AS M
				ON R.memberId = M.id
				WHERE R.relId = #{relId}
				AND R.relTypeCode = #{relTypeCode}
			</script>
			""")
	public List<Reply> getForPrintReplies(int actorId, String relTypeCode, int relId);

	@Insert("""
			<script>
				INSERT INTO TB_REPLY
				SET regDate = NOW(),
				updateDate = NOw(),
				memberId = #{actorId},
				relId = #{relId},
				relTypeCode = #{relTypeCode},
				`body` = #{body}
			</script>
					""")
	public void writeReply(String relTypeCode, int relId, String body, int actorId);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("""
			<script>
				SELECT *
				FROM TB_REPLY
				WHERE id = #{id}
			</script>
			""")
	public Reply getReply(int id);

	@Delete("""
			<script>
				DELETE FROM TB_REPLY
				WHERE id = #{id}
			</script>
			""")
	public void deleteReply(int id);

	@Select("""
				SELECT R.*, M.name AS extra__writer
				FROM TB_REPLY AS R
				INNER JOIN TB_MEMBER AS M
				ON R.memberId = M.id
				WHERE R.id = #{id}
			""")
	Reply getForPrintReply(int id);

	@Update("""
			<script>
				UPDATE TB_REPLY
				<set>
					<if test="body != null and body != ''">
						`body` = #{body},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{id}
			</script>
			""")
	public void modifyReply(int id, String body);
}
