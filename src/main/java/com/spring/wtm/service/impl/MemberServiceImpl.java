package com.spring.wtm.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wtm.model.Member;
import com.spring.wtm.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	/** MyBatis */
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 회원 로그인
	 * @param Member (로그인목적의) 조회할 회원의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	@Override
	public Member login(Member input) throws Exception {
		Member result = null;

		try {
			result = sqlSession.selectOne("MemberMapper.login", input);
			if (result == null) {
				throw new NullPointerException("result=null");
			}
			
            // 로그인에 성공하면 result에 저장되어 있는 PK를 활용하여 로그인 시간을 갱신한다.
			// 비밀번호 재발급 후 로그인한 경우에는 재발급컬럼을 'N'으로 업데이트.
            sqlSession.update("MemberMapper.updateLoginDate", result);
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
            throw new Exception("없는 회원이거나 정보가 일치하지 않습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}

		return result;
	}
	
	/**
	 * 회원 데이터 상세 조회
	 * @param Member 조회할 회원의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	@Override
	public Member getMemberItem(Member input) throws Exception {
		Member result = null;

		try {
			result = sqlSession.selectOne("MemberMapper.selectItem", input);

			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}

		return result;
	}

	/**
	 * 회원 데이터 목록 조회
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	@Override
	public List<Member> getMemberList(Member input) throws Exception {
		List<Member> result = null;

		try {
			result = sqlSession.selectList("MemberMapper.selectList", input);

			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}

		return result;
	}
    
    /** 중복 조회 아이디/이메일/전화번호 시작 */
    public Member idCheck(Member input) throws Exception {
    	Member result = null;

		try {
			result = sqlSession.selectOne("MemberMapper.idCheck", input);
			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (Exception e) {
			// 데이터 조회에 실패한 경우 (회원 데이터가 0개인 경우) rt값을 True라고 return한다.
			// UserRestController
			log.error(e.getLocalizedMessage());
			throw new Exception("True");
		}

		return result;
    }
    public Member emailCheck(Member input) throws Exception {
    	Member result = null;

		try {
			result = sqlSession.selectOne("MemberMapper.emailCheck", input);
			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (Exception e) {
			// 데이터 조회에 실패한 경우 (회원 데이터가 0개인 경우) rt값을 True라고 return한다.
			// UserRestController
			log.error(e.getLocalizedMessage());
			throw new Exception("존재하지 않는 이메일 입니다.");
		}

		return result;
    }
    public Member telCheck(Member input) throws Exception {
    	Member result = null;

		try {
			result = sqlSession.selectOne("MemberMapper.telCheck", input);
			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (Exception e) {
			// 데이터 조회에 실패한 경우 (회원 데이터가 0개인 경우) rt값을 True라고 return한다.
			// UserRestController
			log.error(e.getLocalizedMessage());
			throw new Exception("True");
		}

		return result;
    }
    /** 중복 조회 아이디/이메일/전화번호 끝 */
    
    /**
     * id 찾기
     * @param input
     * @return
     * @throws Exception
     */
    public Member idFind(Member input) throws Exception {
    	Member result = null;

		try {
			result = sqlSession.selectOne("MemberMapper.idFind", input);
			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (Exception e) {
			// id 찾기 실패, 일치하는 회원 정보가 없는 경우
			log.error(e.getLocalizedMessage());
			throw new Exception("일치하는 회원 정보가 존재하지 않습니다.");
		}

		return result;
    }
    
    /**
     * 비밀번호 재발급
     * @param input
     * @return
     * @throws Exception
     */
    public void pwFind(Member input) throws Exception {
    	// 해당 이메일이 존재하는지 확인한다.
    	emailCheck(input);
    	
    	// 이메일이 존재한다면 이름, 아이디, 이메일과 일치하는 회원의 비밀번호를 update한다.
		try {
			int result = sqlSession.update("MemberMapper.pwFind", input);
			if (result == 0) {
				throw new NullPointerException("result=0");
			}			
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("일치하는 회원정보가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("비밀번호 재발급에 실패했습니다.");
		}
    }
    
    /**
     * 재발급 스케쥴링
     * @param Member
     */
    public int pwFind2(Member input) throws Exception{
		int result = 0;

		try {
			result = sqlSession.update("MemberMapper.pwFind2", input);

			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
		}
		return result;
    }
    
	/**
	 * 회원 데이터가 저장되어 있는 갯수 조회
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int getMemberCount(Member input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.selectOne("MemberMapper.selectCountAll", input);
			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (Exception e) {
			// 데이터 조회에 실패한 경우 (회원 데이터가 0개인 경우) rt값을 False라고 return한다.
			// UserRestController
			log.error(e.getLocalizedMessage());
			throw new Exception("False");
		}

		return result;
	}

	/**
	 * 회원 데이터 등록하기
	 * @param Member 저장할 정보를 담고 있는 Beans
	 * @throws Exception
	 */
	@Override
	public int addMember(Member input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.insert("MemberMapper.insertItem", input);

			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("저장된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 저장에 실패했습니다.");
		}

		return result;
	}

	/**
	 * 회원 데이터 수정하기
	 * @param Member 수정할 정보를 담고 있는 Beans
	 * @throws Exception
	 */
	@Override
	public int editMember(Member input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.update("MemberMapper.updateItem", input);

			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("수정된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}

		return result;
	}

	/**
	 * 회원 데이터 삭제하기
	 * @param Member 삭제할 회원의 일련번호를 담고 있는 Beans
	 * @throws Exception
	 */
	@Override
	public int deleteMember(Member input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.delete("MemberMapper.deleteItem", input);
			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("(회원탈퇴) 수정된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("(회원탈퇴) 데이터 수정에 실패했습니다.");
		}

		return result;
	}
	
    /**
     * 회원 데이터 삭제하기
     * @param Member 삭제할 회원의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int dropMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("MemberMapper.dropItem", input);
			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
		}
		return result;
    }

}