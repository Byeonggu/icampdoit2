<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	out.println( "<script type='text/javascript'>" );
	if( flag != 1 ) {
		//세션 등록
		out.println( "alert( '게시글 삭제 성공' );" );
		out.println( "location.href='/admin_board.do';" );
	} else {
		out.println( "alert( '게시글 삭제 실패' );" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>