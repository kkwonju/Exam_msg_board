package com.koreaIT.kkwo.exam.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.koreaIT.kkwo.exam.demo.vo.Member;

@Mapper
public interface MemberRepository {

	@Insert("""
			INSERT INTO TB_MEMBER
			SET regDate = NOW(),
			updateDate = NOW(),
			`name` = #{name},
			email = #{email},
			loginPw = #{loginPw}
			""")
	public void doJoin(String name, String email, String loginPw);

	@Select("SELECT * FROM TB_MEMBER WHERE id = #{id}")
	public Member getMemberById(int id);

	@Select("""
			SELECT * 
			FROM TB_MEMBER
			WHERE email = #{email}
			""")
	public Member getMemberByEamil(String email);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();
	
	@Update("""
			<script>
				UPDATE TB_MEMBER
				<set>
					<if test="loginPw != null">
						loginPw = #{loginPw},
					</if>
					<if test="name != null">
						name = #{name},
					</if>
					<if test="email != null">
						email = #{email},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{id}
			</script>
			""")
	public void modifyMember(int id, String name, String email, String loginPw);


}