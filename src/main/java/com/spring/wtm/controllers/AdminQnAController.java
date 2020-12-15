package com.spring.wtm.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminQnAController {
	/**
	 * @description 관리자 상품문의게시판(admin_qna.jsp)
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin_qna.do", method = RequestMethod.GET)
	public ModelAndView adminQnA(Model model, HttpServletResponse response) {
		return new ModelAndView("admin/admin_qna");
	}
	
	/**
	 * @description 관리자 상품문의 게시판 답글 (admin_answer.jsp)
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin_answer.do", method = RequestMethod.GET)
	public ModelAndView adminAnswer(Model model, HttpServletResponse response) {
		return new ModelAndView("admin/admin_answer");
	}
	
	/**
	 * @description 관리자 상품문의 답변 수정(admin_answerupt.jsp)
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin_answerupt.do", method = RequestMethod.GET)
	public ModelAndView adminAnswerUpt(Model model, HttpServletResponse response) {
		return new ModelAndView("admin/admin_answerupt");
	}

}
