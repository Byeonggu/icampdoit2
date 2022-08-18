package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.exam.admin.AdminDAO;
import com.exam.admin.AdminListTO;
import com.exam.admin.AdminStatDAO;
import com.exam.admin.AdminUsersDAO;
import com.exam.admin.UsersListTO;
import com.exam.admin.VisitTO;
import com.exam.hboard.HBoardDAO;
import com.exam.hboard.HBoardTO;
import com.exam.login.SignUpTO;
import com.exam.mboard.BoardDAO;
import com.exam.mboard.BoardListTO;
import com.exam.mboard.BoardTO;
import com.exam.mboard.FileTO;
import com.exam.nboard.NBoardDAO;
import com.exam.nboard.NBoardTO;
import com.exam.nboard.NFileTO;

@RestController
public class Controller_Admin_Home {

	@Autowired
	private BoardDAO dao;

	@Autowired
	private HBoardDAO hdao;

	@Autowired
	private NBoardDAO ndao;
	
	@Autowired
	private AdminDAO adao;
	
	@Autowired
	private AdminStatDAO sdao;
	
	@Autowired
	private AdminUsersDAO udao;

	String url = System.getProperty("user.dir");
	private String mUploadPath = url + "/src/main/webapp/upload/";

	private String hUploadPath = url + "/src/main/webapp/h_upload/";

	private String nUploadPath = url + "/src/main/webapp/n_upload/";

	// 관리자페이지
	@RequestMapping(value = "/admin.do")
	public ModelAndView admin(HttpServletRequest request, HttpSession session) {
		System.out.println("admin() 호출");
		
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
		
		System.out.println( "countBoardResult : " + countBoardResult );

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
		System.out.println("admin_users");

		int cpage = 1;
		if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
			cpage = Integer.parseInt( request.getParameter( "cpage" ) );
		}
		System.out.println("test cpage" + cpage);
		
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
		System.out.println("admin_users_view 호출");
		
		SignUpTO sto = new SignUpTO();
		sto.setUcode( request.getParameter( "ucode" ) );
		System.out.println(  "ucode값:" + sto.getUcode() );
		
		sto = udao.userView(sto);
		
		UsersListTO ulistTO = new UsersListTO();
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
		System.out.println("admin_users_modifyOk 호출");
		
		int cpage = 1;
		if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
			cpage = Integer.parseInt( request.getParameter( "cpage" ) );
		}
		
		UsersListTO ulistTO = new UsersListTO();
		ulistTO.setCpage(cpage);
		
		SignUpTO sto = new SignUpTO();
		sto.setUcode( request.getParameter( "ucode" ) );
		System.out.println( "ucode : " + sto.getUcode() );
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
		System.out.println("admin_users_deleteOk 호출");
		//System.out.println("ucode 파라메터: " + request.getParameter( "ucode" ) );
		
		int flag = 1;
		
		SignUpTO sto = new SignUpTO();
		
		if ( session.getAttribute("id").equals("admin") ) {
			sto.setUcode( request.getParameter( "ucode" ) );
			//System.out.println( "ucode deleteOk에서 : " + sto.getUcode() );	

			flag = udao.usersDeleteOK(sto);
			//System.out.println( "flag 값: " + flag);
		}
		
		//ModelAndView modelAndView = new ModelAndView();

		//modelAndView.setViewName( "/admin/admin_users_delete_ok" );
		//modelAndView.addObject("flag", flag);
		return flag;
	}
	
}
