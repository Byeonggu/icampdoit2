package com.example.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.exam.admin.AdminStatDAO;
import com.exam.admin.AdminUsersDAO;
import com.exam.admin.UsersListTO;
import com.exam.login.SignUpTO;


@RestController
public class Controller_Admin_Home {
	
	@Autowired
	private AdminStatDAO sdao;
	
	@Autowired
	private AdminUsersDAO udao;

	// 관리자페이지
	@RequestMapping(value = "/admin.do")
	public ModelAndView admin(HttpServletRequest request, HttpSession session) {		
		
		String countBoardResult = sdao.countBoard();  //총 게시글 수
		String countFemale = sdao.countFemale(); //여성회원수
		String countMale = sdao.countMale(); //남성회원수
		String weeklyRegistered = sdao.weeklyRegistered(); //이번주 가입자수
		String countReviews = sdao.countReviews();  //review 갯수
		String countTotalVisitor = sdao.countTotalVisitor(); //총 방문자 수
		String countTodayVisitor = sdao.countTodayVisitor(); //오늘 방문자 수
		String countSocialId = sdao.countSocialId(); // 소셜 가입자 수
		//연령대 별 회원 수
		SignUpTO sto = new SignUpTO();
		ArrayList<SignUpTO> lists = sdao.countbyAge(sto);
		
		ModelAndView modelAndView = new ModelAndView();

		if (session.getAttribute("ucode") == null) {
			modelAndView.setViewName("/login/nousers");
			return modelAndView;
		}
		
		if(session.getAttribute("id").equals("admin") ) {
			modelAndView.setViewName("admin/admin");
			modelAndView.addObject( "countBoardResult", countBoardResult );
			modelAndView.addObject( "countFemale", countFemale );
			modelAndView.addObject( "countMale", countMale );
			modelAndView.addObject( "weeklyRegistered", weeklyRegistered );
			modelAndView.addObject( "countReviews", countReviews );
			modelAndView.addObject( "countTotalVisitor", countTotalVisitor );
			modelAndView.addObject( "countTodayVisitor", countTodayVisitor );
			modelAndView.addObject( "countSocialId", countSocialId );
			modelAndView.addObject( "lists", lists );

			return modelAndView;
		}
		
		modelAndView.setViewName("admin/admin_only");
		return modelAndView;
	}
	
	@RequestMapping(value = "/admin_users.do")
	public ModelAndView adminUsers(HttpServletRequest request, HttpSession session) {
		
		int cpage = 1;
		if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
			cpage = Integer.parseInt( request.getParameter( "cpage" ) );
		}
		
		UsersListTO ulistTO = new UsersListTO();
		ulistTO.setCpage(cpage);
		
		ulistTO = udao.usersList(ulistTO);
		
		ModelAndView modelAndView = new ModelAndView();

		if (session.getAttribute("ucode") == null) {
			modelAndView.setViewName("/login/nousers");
			return modelAndView;
		}

		modelAndView.setViewName("admin/admin_users");
		modelAndView.addObject( "ulistTO", ulistTO );
		modelAndView.addObject( "cpage", cpage );

		return modelAndView;
	}
	
	@RequestMapping(value = "/admin_users_view.do")
	public ModelAndView adminUsersView(HttpServletRequest request, HttpSession session) {
		
		SignUpTO sto = new SignUpTO();
		sto.setUcode( request.getParameter( "ucode" ) );
		
		sto = udao.userView(sto);
		
		int cpage = Integer.parseInt( request.getParameter( "cpage" ) );

		ModelAndView modelAndView = new ModelAndView();

		if (session.getAttribute("ucode") == null) {
			modelAndView.setViewName("/login/nousers");
			return modelAndView;
		}
		modelAndView.setViewName("admin/admin_users_view");
		modelAndView.addObject( "sto", sto );
		modelAndView.addObject( "cpage", cpage );

		return modelAndView;
	}
	
	@RequestMapping(value = "/admin_users_modifyOk.do")
	public String adminUsersModifyOk(HttpServletRequest request, HttpSession session) {
		
		int cpage = 1;
		if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
			cpage = Integer.parseInt( request.getParameter( "cpage" ) );
		}
		
		UsersListTO ulistTO = new UsersListTO();
		ulistTO.setCpage(cpage);
		
		SignUpTO sto = new SignUpTO();
		sto.setUcode( request.getParameter( "ucode" ) );
		sto.setName( request.getParameter( "name" ) );
		sto.setEmail( request.getParameter( "email" ) );
		sto.setGen( request.getParameter( "gen" ) );
		sto.setBirth( request.getParameter( "birth" ) );
		
		int flag = 1;
		
		flag = udao.usersModifyOK(sto);

		return Integer.toString(flag);
	}
	
	@RequestMapping(value = "/admin_users_deleteOk.do")
	public int adminUsersDeleteOk(HttpServletRequest request, HttpSession session) {
		
		int flag = 1;
		
		SignUpTO sto = new SignUpTO();
		
		if ( session.getAttribute("id").equals("admin") ) {
			sto.setUcode( request.getParameter( "ucode" ) );

			flag = udao.usersDeleteOK(sto);
		}
		
		return flag;
	}
	
}
