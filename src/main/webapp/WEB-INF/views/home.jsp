<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.exam.search.SearchkeyTO"%>
<%@ page import="java.util.ArrayList" %>
<%@page import="com.exam.weather.WeatherTO"%>
<%
	//session 값 가져오기
	int ucode = -1;
	String id ="";
	if(session.getAttribute("id") != null){
		ucode = (int)session.getAttribute("ucode");
		id = (String)session.getAttribute("id");
	}
	
	ArrayList<SearchkeyTO> lists = (ArrayList)request.getAttribute( "lists" ); 
	
	StringBuilder sbHtml = new StringBuilder();
	
	for( SearchkeyTO to : lists ) {
		String contentId = to.getContentId();
		String campNm = to.getFacltNm();
		String mainImg = to.getFirstImageUrl();
		if( mainImg.equals("default") ) {
			mainImg = "./resources/bootstrap-5/html/img/noimg.png";
		}
		String addr1 = to.getDoNm();
		String addr2 = to.getSigunguNm();

		sbHtml.append( "<div class='swiper-slide h-auto px-2'>" );
		sbHtml.append( "<div class='card card-poster gradient-overlay hover-animate mb-4 mb-lg-0'>" );
		sbHtml.append( "<a class='tile-link' href='./campview.do?contentId=" + contentId + "'></a>" );
		sbHtml.append( "<img class='bg-image' src='" + mainImg + "' alt='Card image'>" );
		sbHtml.append( "<div class='card-body overlay-content'>" );
		sbHtml.append( "<h5 class='card-title text-shadow text-uppercase' style=\"font-family: 'Recipekorea';\">" + campNm + "</h5>" );
		sbHtml.append( "<p class='card-text text-sm' style=\"font-family: 'BMJUA';\">" + addr1 + " " + addr2 + "</p>" );
		sbHtml.append( "</div>" );
		sbHtml.append( "</div>" );
		sbHtml.append( "</div>" );
	}
	
	//날씨 
	ArrayList<WeatherTO> wlists = (ArrayList)request.getAttribute( "wlists" );
	
	StringBuilder wHtml = new StringBuilder();
	
	for( WeatherTO wto : wlists ) {
		
	wHtml.append("<div class=\"swiper-slide h-auto d-flex align-items-center justify-content-center\">");
	wHtml.append("<div class=\"tit_weather\"> <strong>"+ wto.getDate()+"</strong><br/></div>");
	if(Integer.parseInt(wto.getPop())>=30){
		wHtml.append("<img class=\"weatherimage\" src=\"./resources/bootstrap-5/html/img/weathericon/NB03.png\"/>");
	}else if( (wto.getSky()=="6"||wto.getSky()=="7"||wto.getSky()=="8"||wto.getSky()=="9"||wto.getSky()=="10")&&(Integer.parseInt(wto.getPop())>30)){
		wHtml.append("<img class=\"weatherimage\" src=\"./resources/bootstrap-5/html/img/weathericon/NB03.png\"/>");
	}else if(wto.getSky().indexOf("눈")!= -1){
		wHtml.append("<img class=\"weatherimage\" src=\"./resources/bootstrap-5/html/img/weathericon/NB04.png\"/>");
	}else if(wto.getSky().equals("1")||wto.getSky().equals("2")||wto.getSky().equals("3")||wto.getSky().equals("4")||wto.getSky()=="5"||wto.getSky().indexOf("맑음")!= -1){
		wHtml.append("<img class=\"weatherimage\" src=\"./resources/bootstrap-5/html/img/weathericon/NB01.png\"/>");
	}else{
		wHtml.append("<img class=\"weatherimage\" src=\"./resources/bootstrap-5/html/img/weathericon/NB02.png\"/>");
	}
	
	wHtml.append( wto.getTaMin()+"°C/"+wto.getTaMax() +"°C<br/>");
	wHtml.append("강수 : "+wto.getPop() +"%");
	wHtml.append("</div>");
		
	}
	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>I CAMP DO IT</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <link rel="stylesheet" href="./resources/bootstrap-5/html/css/font.css" type="text/css">
    <!-- Price Slider Stylesheets -->
    <!--<link rel="stylesheet" href="vendor/nouislider/nouislider.css"> -->
    <link rel="stylesheet" href="./resources/bootstrap-5/html/vendor/nouislider/nouislider.css">
    <!-- Google fonts - Playfair Display-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,700">
    <!-- Google fonts - Poppins-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,400i,700">
    <!-- swiper-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.4.1/css/swiper.min.css">
    <!-- Magnigic Popup-->
    <link rel="stylesheet" href="./resources/bootstrap-5/html/vendor/magnific-popup/magnific-popup.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="./resources/bootstrap-5/html/css/style.green.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="./resources/bootstrap-5/html/css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="./resources/bootstrap-5/html/img/logo2.svg">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <!-- Font Awesome 이거 추가함 -->
    <script src="https://kit.fontawesome.com/5251502df3.js" crossorigin="anonymous"></script>
  </head>
  <body style="padding-top: 72px;">
    <header class="header">
    
      <!-- Navbar 로고부분-->
      <nav class="navbar navbar-expand-lg fixed-top shadow navbar-light bg-white">
        <div class="container-fluid">
          	<a class="navbar-brand py-1" href="./home.do"><img src="./resources/bootstrap-5/html/img/logo.svg" alt="Directory logo"></a>          
          <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-bars"></i></button>
          
          <div class="collapse navbar-collapse justify-content-center" id="navbarCollapse">      
	          <ul class="navbar-nav">
	          
	              <!-- About 페이지 링크 -->
	              <li class="nav-item">
	              	<a class="nav-link" href="./about.do">About</a>
	              </li>
	              
	              <!-- Customer Care 페이지 -->
				  <li class="nav-item dropdown">
				  	<a class="nav-link dropdown-toggle" id="noticeDropdownMenuLink" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Customer Care</a>
	                <div class="dropdown-menu" aria-labelledby="noticeDropdownMenuLink"><a class="dropdown-item" href="./notice.do">공지사항</a><a class="dropdown-item" href="/faq.do">FAQ</a></div>
	              </li>
	              
	              <!-- Search 페이지 -->
	              <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="searchDropdownMenuLink" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                   Search</a>
	                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="searchDropdownMenuLink">
	                  <a class="dropdown-item" href="./searchkey.do">일반검색</a><a class="dropdown-item" href="./searchmapgugun.do?sido=&gugun=">지도검색</a>
	                </div>
	              </li>
	              
	              <!-- Communication 페이지 -->      
	              <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="communicationDropdownMenuLink" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                   Communication</a>
	                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="communicationDropdownMenuLink">
	                  <a class="dropdown-item" href="./mboardlist.do">게시판</a><a class="dropdown-item" href="./hboardlist.do">혼캠 자료실</a>
	                </div>
	              </li>
	              
	              <!-- MyPage 페이지 -->      
	              <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="mypageDropdownMenuLink" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                   MyPage</a>
	                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="mypageDropdownMenuLink">
	                  <a class="dropdown-item" href="./mypage.do">내 정보</a><a class="dropdown-item" href="./mypagesub.do">찜한 목록</a><a class="dropdown-item" href="./mypagemylist.do">내가 쓴 글</a>
	                </div>
	              </li>
	            </ul>
         	</div>
         	
         	<form class="d-flex">
         		<%if(ucode == -1){ %>
             	<button class="btn btn-outline-primary btn-sm" type="button" onclick="location.href='./login.do'">Login</button>
             	<%}else{ %>
             	<span class="mx-2"><strong><%=id%></strong>님 </span>
             	<button class="btn btn-outline-primary btn-sm" type="button" onclick="location.href='./logout.do'">Logout</button>
             	<%}; %>
             </form>
         </div>
      </nav>
      <!-- /Navbar -->
    </header>
    
    <!-- 메인 검색 배경부분 -->
    <section class="hero-home">
      <div class="swiper-container hero-slider">
        <div class="swiper-wrapper dark-overlay">
          <div class="swiper-slide" style="background-image:url(./resources/bootstrap-5/html/img/photo/camping.jpg)"></div>
          <div class="swiper-slide" style="background-image:url(./resources/bootstrap-5/html/img/photo/camping2.jpg)"></div>
          <div class="swiper-slide" style="background-image:url(./resources/bootstrap-5/html/img/photo/camping3.jpg)"></div>
          <div class="swiper-slide" style="background-image:url(./resources/bootstrap-5/html/img/photo/camping4.jpg)"></div>
        </div>
      </div>   
      <div class="container py-6 py-md-7 text-white z-index-20">
        <div class="row">
          <div class="col-xl-10">
            <div class="text-center text-lg-start">
              <h1 class="display-3 fw-bold text-shadow">I Camp Do It</h1>
            </div>   
                   
            <form action="searchkey.do" method="post"> 
              <div class="search-bar mt-5 p-3 p-lg-1 ps-lg-4">             
                <div class="row">
                  <div class="col-lg-7 d-flex align-items-center form-group">
                    <input class="form-control border-0 shadow-0" type="text" name="keysearch" id="keysearch" placeholder="키워드 검색">
                  </div>
                  <div class="col-lg-3 d-flex align-items-center form-group no-divider">
                    <button type="button" class="btn btn-outline-white" id="filteringButton" data-style="btn-form-control" data-bs-toggle="modal" data-bs-target="#filteringModal"><i class="fa-solid fa-magnifying-glass-plus"></i>
                      캠핑장 상세조건 검색
                    </button>
                  </div>
                  <div class="col-lg-2 d-grid">
                    <button class="btn btn-primary rounded-pill h-100" type="submit">검색하기 </button>
                  </div>
                </div>             
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
    
    <!-- 상세보기 팝업 -->
    <form id="campSearchForm" action="./searchdetail.do" method="post">
    <div class="modal fade" id="filteringModal">
		<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
					
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" style="font-family: 'GmarketSansBold';"><img src="./resources/bootstrap-5/html/img/photo/캠핑아이콘.png">&nbsp;&nbsp;원하는 캠핑장의 상세조건을 검색해보세요.</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
					
				<!-- Modal body -->
				<div class="modal-body">
						<!-- 지역 필터링 -->
						<div class="form-group row" id="doNm">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<strong>지역</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="locationSeoul" name="doNmS" value="서울">
									<label class="from-check-label" for="locationSeoul">
										서울시
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="locationIncheon" name="doNmI" value="인천">
									<label class="from-check-label" for="locationIncheon">
										인천시
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="locationGyeonggi" name="doNmG" value="경기">
									<label class="from-check-label" for="locationGyeonggi">
										경기도
									</label>
								</div>
							</div>
						</div>
						<br>
						<!-- 캠핑장 유형 -->
						<div class="form-group row" id="induty">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<strong>캠핑 유형</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="typeCamping" name="indutyNor" value="일반야영장">
									<label class="from-check-label" for="typeCamping">
										일반 야영장
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="typeCar" name="indutyCar" value="자동차야영장">
									<label class="from-check-label" for="typeCar">
										자동차 야영장
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="typeGlamping" name="indutyGl" value="글램핑">
									<label class="from-check-label" for="typeGlamping">
										글램핑
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="typeCaraban" name="indutyVan" value="카라반">
									<label class="from-check-label" for="typeCaraban">
										카라반
									</label>
								</div>
							</div>
						</div>
						<br>
						<!-- 입지 -->
						<div class="form-group row" id="lctCl">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<strong>입지</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeMountain" name="lctClMount" value="산">
									<label class="from-check-label" for="placeMountain">
										산
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeForest" name="lctClForest" value="숲">
									<label class="from-check-label" for="placeForest">
										숲
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeStream" name="lctClValley" value="계곡">
									<label class="from-check-label" for="placeStream">
										계곡
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeCity" name="lctClCity" value="도심">
									<label class="from-check-label" for="placeCity">
										도심
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeRiver" name="lctClRiver" value="강">
									<label class="from-check-label" for="placeRiver">
										강
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeLake" name="lctClLake" value="호수">
									<label class="from-check-label" for="placeLake">
										호수
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeBeach" name="lctClBeach" value="해변">
									<label class="from-check-label" for="placeBeach">
										해변
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="placeIsland" name="lctClIsland" value="섬">
									<label class="from-check-label" for="placeIsland">
										섬
									</label>
								</div>
							</div>
						</div>
						<br>
						<!-- 바닥형태 -->
						<div class="form-group row" id="siteBottomCl">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<strong>바닥 형태</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="floorGrass" name="siteBottomCl1" value="0">
									<label class="from-check-label" for="floorGrass">
										잔디
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="floorRock" name="siteBottomCl2" value="0">
									<label class="from-check-label" for="floorRock">
										파쇄석
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="floorTeck" name="siteBottomCl3" value="0">
									<label class="from-check-label" for="floorTeck">
										테크
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="floorPebble" name="siteBottomCl4" value="0">
									<label class="from-check-label" for="floorPebble">
										자갈
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="floorDirt" name="siteBottomCl5" value="0">
									<label class="from-check-label" for="floorDirt">
										맨흙
									</label>
								</div>						
							</div>
						</div>
						<br>
						<!-- 부대시설 -->
						<div class="form-group row" id="sbrsCl">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<strong>부대 시설</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facElectro" name="sbrsClElectro" value="전기">
									<label class="from-check-label" for="facElectro">
										전기
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facWarmwater" name="sbrsClHwater" value="온수">
									<label class="from-check-label" for="facWarmwater">
										온수
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facGym" name="sbrsClGym" value="운동시설">
									<label class="from-check-label" for="facGym">
										운동시설
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facWifi" name="sbrsClWifi" value="무선인터넷">
									<label class="from-check-label" for="facWifi">
										무선인터넷
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facWood" name="sbrsClFirewood" value="장작판매">
									<label class="from-check-label" for="facWood">
										장작판매
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facPool" name="sbrsClPool" value="물놀이장">
									<label class="from-check-label" for="facPool">
										물놀이장
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facMart" name="sbrsClMart" value="마트">
									<label class="from-check-label" for="facMart">
										마트
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facConv" name="sbrsClCstore" value="편의점">
									<label class="from-check-label" for="facConv">
										편의점
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="facWalk" name="sbrsClWalk" value="산책로">
									<label class="from-check-label" for="facWalk">
										산책로
									</label>
								</div>
							</div>
						</div>
						<br>
						<!-- 캠핑장비 대여 -->
						<div class="form-group row" id="eqpmnLendCl">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<strong>캠핑장비 대여</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="rentTent" name="eqpmnLendClTent" value="텐트">
									<label class="from-check-label" for="rentTent">
										텐트
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="rentFire" name="eqpmnLendClBrazier" value="화로대">
									<label class="from-check-label" for="rentFire">
										화로대
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="rentHeat" name="eqpmnLendClHeater" value="난방기구">
									<label class="from-check-label" for="rentHeat">
										난방기구
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="rentDish" name="eqpmnLendClTableware" value="식기">
									<label class="from-check-label" for="rentDish">
										식기
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="rentBed" name="eqpmnLendClSbag" value="침낭">
									<label class="from-check-label" for="rentBed">
										침낭
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="rentWire" name="eqpmnLendClRwire" value="릴선">
									<label class="from-check-label" for="rentWire">
										릴선
									</label>
								</div>							
							</div>
						</div>
						<br>
						<!-- 기타정보 -->
						<div class="form-group row" id="etcFilter">
							<div class="col-sm-2" style="font-family: 'GmarketSansBold';">&nbsp;<i class="fa-solid fa-period"></i><strong>기타 정보</strong></div>
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="etcTrailer" name="trlerAcmpnyAt" value="Y">
									<label class="from-check-label" for="etcTrailer">
										개인 트레일러 입장 가능
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="etcCaraban" name="caravAcmpnyAt" value="Y">
									<label class="from-check-label" for="etcCaraban">
										개인 카라반 입장 가능
									</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" id="etcPet" name="animalCmgCl" value="불가능">
									<label class="from-check-label" for="etcPet">
										반려견 동반 가능
									</label>
								</div>					
							</div>
						</div>
				</div>
					
				<!-- Modal footer -->
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-dark" id="allNonChk">&nbsp;&nbsp;초기화&nbsp;&nbsp;</button>
					<button type="submit" class="btn btn-primary text-white" id="detailSearch">&nbsp;&nbsp;검색하기&nbsp;&nbsp;</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	
<!-- 캠핑장 조회수 TOP 5 -->
	<section class="py-6">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-8">
            <p class="subtitle text-primary">MOST POPULAR CAMPSITES</p>
            <h2 style="font-family: 'Recipekorea';">캠핑장 조회수 TOP 5</h2>
          </div>
          <div class="col-md-4 d-lg-flex align-items-center justify-content-end"><a class="text-muted text-sm" href="./searchkey.do" style="font-family: 'BMJUA';">
               더 많은 캠핑장 보러가기<i class="fas fa-angle-double-right ms-2"></i></a></div>
        </div>
        <div class="swiper-container guides-slider mx-n2 pt-3">
          <!-- Additional required wrapper-->
          <div class="swiper-wrapper pb-5">
            <!-- Slides -->
            <!-- 
            <div class="swiper-slide h-auto px-2">
              <div class="card card-poster gradient-overlay hover-animate mb-4 mb-lg-0"><a class="tile-link" href="./campview.do"></a><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/top1예시.jpg" alt="Card image">
                <div class="card-body overlay-content">
                  <h5 class="card-title text-shadow text-uppercase" style="font-family: 'Recipekorea';">대궐 오토캠핑장</h5>
                  <p class="card-text text-sm" style="font-family: 'BMJUA';">경기도 포천시</p>
                </div>
              </div>
            </div>
            -->
            <%=sbHtml.toString() %>
          </div>
          <div class="swiper-pagination d-md-none"> </div>
        </div>
      </div>
    </section>
    <!-- Our picks section-->
    <section class="py-6 bg-gray-100">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-8">
            <p class="subtitle text-primary">THE STARRY NIGHT</font></p>
            <h2 style="font-family: 'Recipekorea';">별보기 좋은 캠핑장 Best 5</h2>
          </div>
          <div class="col-md-4 d-md-flex align-items-center justify-content-end"><a class="text-muted text-sm" href="./searchkey.do" style="font-family: 'BMJUA';">
               더 많은 캠핑장 보러가기<i class="fas fa-angle-double-right ms-2"></i></a></div>
        </div>
        <div class="row">  
          <div class="d-flex align-items-lg-stretch mb-4 col-lg-8">
            <div class="card shadow-lg border-0 w-100 border-0 hover-animate" data-bs-toggle="tooltip" title="경기도 양주" style="background: center center url(./resources/bootstrap-5/html/img/photo/해피캠핑장.jpg) no-repeat; background-size: cover;"><a class="tile-link" href="./campview.do?contentId=3472"> </a>
              <div class="d-flex align-items-center h-100 text-white justify-content-center py-6 py-lg-7">
                <h3 class="text-shadow text-uppercase mb-0" style="font-family: 'Recipekorea';">해피 캠핑장</h3>
              </div>
            </div>
          </div>
          <div class="d-flex align-items-lg-stretch mb-4 col-lg-4">
            <div class="card shadow-lg border-0 w-100 border-0 hover-animate" data-bs-toggle="tooltip" title="경기도 연천" style="background: center center url(./resources/bootstrap-5/html/img/photo/한탄강캠핑장.jpg) no-repeat; background-size: cover;"><a class="tile-link" href="./campview.do?contentId=3423"> </a>
              <div class="d-flex align-items-center h-100 text-white justify-content-center py-6 py-lg-7">
                <h3 class="text-shadow text-uppercase mb-0" style="font-family: 'Recipekorea';">한탄강 오토캠핑장</h3>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="d-flex align-items-lg-stretch mb-4 col-lg-4">
            <div class="card shadow-lg border-0 w-100 border-0 hover-animate" data-bs-toggle="tooltip" data-bs-placement="bottom" title="경기도 포천" style="background: center center url(./resources/bootstrap-5/html/img/photo/광릉숲이야기캠핑장.jpg) no-repeat; background-size: cover;"><a class="tile-link" href="./campview.do?contentId=329"> </a>
              <div class="d-flex align-items-center h-100 text-white justify-content-center py-6 py-lg-7">
                <h3 class="text-shadow text-uppercase mb-0" style="font-family: 'Recipekorea';">광릉숲 이야기 관광농원</h3>
              </div>
            </div>
          </div>
          <div class="d-flex align-items-lg-stretch mb-4 col-lg-4">
            <div class="card shadow-lg border-0 w-100 border-0 hover-animate" data-bs-toggle="tooltip" data-bs-placement="bottom" title="경기도 가평" style="background: center center url(./resources/bootstrap-5/html/img/photo/자라섬캠핑장.jpg) no-repeat; background-size: cover;"><a class="tile-link" href="./campview.do?contentId=2616"> </a>
              <div class="d-flex align-items-center h-100 text-white justify-content-center py-6 py-lg-7">
                <h3 class="text-shadow text-uppercase mb-0" style="font-family: 'Recipekorea';">자라섬 캠핑장</h3>
              </div>
            </div>
          </div>
          <div class="d-flex align-items-lg-stretch mb-4 col-lg-4">
            <div class="card shadow-lg border-0 w-100 border-0 hover-animate" data-bs-toggle="tooltip" data-bs-placement="bottom" title="경기도 양평" style="background: center center url(./resources/bootstrap-5/html/img/photo/중미산자연휴양림.jpg) no-repeat; background-size: cover;"><a class="tile-link" href="./campview.do?contentId=2782"> </a>
              <div class="d-flex align-items-center h-100 text-white justify-content-center py-6 py-lg-7">
                <h3 class="text-shadow text-uppercase mb-0" style="font-family: 'Recipekorea';">중미산 자연휴양림</h3>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 컨텐츠추천 시작 -->
    <section class="py-6">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-8">
            <p class="subtitle text-primary">Stay and chill at camping</p>
            <h2 style="font-family: 'Recipekorea';">혼캠족을 위한 컨텐츠 추천</h2>
          </div>
          <div class="col-md-4 d-lg-flex align-items-center justify-content-end"><a class="text-muted text-sm" href="./hboardlist.do" style="font-family: 'BMJUA';">
               혼캠 자료실<i class="fas fa-angle-double-right ms-2"></i></a></div>
        </div>
        <div class="swiper-container guides-slider mx-n2 pt-3">
          <!-- Additional required wrapper-->
          <div class="swiper-wrapper pb-5">
            <!-- Slides-->
            <div class="swiper-slide h-auto px-2">
              <div class="card card-poster gradient-overlay hover-animate mb-4 mb-lg-0"><a class="tile-link" href="https://www.youtube.com/watch?v=saXEu2GNeY0"></a><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/원플리1.jpg" alt="Card image">
                <div class="card-body overlay-content">
                  <h6 class="card-title text-shadow text-uppercase">Late Spring breeze</h6>
                  <p class="card-text text-sm"># Playlist</p>
                </div>
              </div>
            </div>
            <div class="swiper-slide h-auto px-2">
              <div class="card card-poster gradient-overlay hover-animate mb-4 mb-lg-0"><a class="tile-link" href="https://www.youtube.com/watch?v=tOI-csUHoP8"></a><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/원플리2.jpg" alt="Card image">
                <div class="card-body overlay-content">
                  <h6 class="card-title text-shadow text-uppercase">Park & Picnic Mood</h6>
                  <p class="card-text text-sm"># Playlist</p>
                </div>
              </div>
            </div>
            <div class="swiper-slide h-auto px-2">
              <div class="card card-poster gradient-overlay hover-animate mb-4 mb-lg-0"><a class="tile-link" href="https://www.youtube.com/watch?v=D5TRWi6y8DI"></a><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/원플리3.jpg" alt="Card image">
                <div class="card-body overlay-content">
                  <h6 class="card-title text-shadow text-uppercase">Chill Vibe</h6>
                  <p class="card-text text-sm"># Playlist</p>
                </div>
              </div>
            </div>
            <div class="swiper-slide h-auto px-2">
              <div class="card card-poster gradient-overlay hover-animate mb-4 mb-lg-0"><a class="tile-link" href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%EC%98%81%ED%99%94+%EC%9D%B8%ED%84%B4"></a><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/인턴.png" alt="Card image">
                <div class="card-body overlay-content">
                  <h6 class="card-title text-shadow text-uppercase">Intern</h6>
                  <p class="card-text text-sm"># Movie</p>
                </div>
              </div>
            </div>
            <div class="swiper-slide h-auto px-2">
              <div class="card card-poster gradient-overlay hover-animate mb-4 mb-lg-0"><a class="tile-link" href="https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EC%98%81%ED%99%94+%EB%84%88%EC%9D%98%EC%9D%B4%EB%A6%84%EC%9D%80&oquery=%EC%98%81%ED%99%94+%EC%9D%B8%ED%84%B4&tqi=hW%2B0BsprvmZssOgHNcsssssssdZ-107965"></a><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/너의이름은.jpg" alt="Card image">
                <div class="card-body overlay-content">
                  <h6 class="card-title text-shadow text-uppercase" style="font-family: 'BMJUA';">너의 이름은</h6>
                  <p class="card-text text-sm"># Movie</p>
                </div>
              </div>
            </div>  
          </div>
          <div class="swiper-pagination d-md-none"> </div>
		</div>
      </div>
    </section>
    <!-- 컨텐츠추천 끝 -->
    
    <!-- 설문목록 시작 -->  
    <section class="py-6 bg-gray-100">
      <div class="container">
        <div class="row mb-lg-6">
          <div class="col-md-8">
            <p class="subtitle text-primary">Survey</p>
            <h2 class="mb-md-0" style="font-family: 'Recipekorea';">설문조사 결과를 참고하세요!</h2>
          </div>
        </div>
        <div class="row">
          <div class="mb-3 mb-lg-0 col-sm-6 col-lg-3">
            <div class="card border-0 hover-animate bg-transparent"><a class="position-relative" ><img class="card-img-top team-img" src="./resources/bootstrap-5/html/img/avatar/여가.jpg" style="border-radius: 8px;" alt="여가"/>
                <div class="team-circle bg-primary-light"></div></a>
            </div>
          </div>
          <div class="mb-3 mb-lg-0 col-sm-6 col-lg-3">
            <div class="card border-0 hover-animate bg-transparent"><a class="position-relative" ><img class="card-img-top team-img" src="./resources/bootstrap-5/html/img/avatar/혼캠장점.jpg" style="border-radius: 8px;" alt="장점"/>
                <div class="team-circle bg-primary-light"></div></a>
            </div>
          </div>
          <div class="mb-3 mb-lg-0 col-sm-6 col-lg-3">
            <div class="card border-0 hover-animate bg-transparent"><a class="position-relative" ><img class="card-img-top team-img" src="./resources/bootstrap-5/html/img/avatar/준비물.jpg" style="border-radius: 8px;" alt="준비물"/>
                <div class="team-circle bg-primary-light"></div></a>
            </div>
          </div>
          <div class="mb-3 mb-lg-0 col-sm-6 col-lg-3">
            <div class="card border-0 hover-animate bg-transparent"><a class="position-relative" ><img class="card-img-top team-img" src="./resources/bootstrap-5/html/img/avatar/캠핑종류.jpg" style="border-radius: 8px;" alt="캠핑종류"/>
                <div class="team-circle bg-primary-light"></div></a>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- 설문목록 끝 -->
        
    <!-- 날씨 -->
    <section class="py-6 " >
      <div class="container">
      <p class="subtitle text-primary">weekly forecast</p>
        <h3 class="text-left text-uppercase letter-spacing-3 mb-5" style="font-family: 'Recipekorea';">주간 예보</h3>
        <!-- Brands Slider-->
        <div class="swiper-container brands-slider">
          <div class="swiper-wrapper pb-5">
          <%=wHtml.toString()%>
            <!-- today -->
            <!--  
            <div class="swiper-slide h-auto d-flex align-items-center justify-content-center">
			   	<div class="tit_weather"> <strong>7.26</strong><br/>화</div>
			   	<img class="weatherimage" src="./resources/bootstrap-5/html/img/weathericon/NB01.png"/>
			   	25°C/32°C<br/>
			    강수 : 10%
		   	</div>
 			-->
          </div>
        </div>
      </div>
    </section>
     
    <!-- Footer - 관리자 페이지 이동 부분 넣을 곳 -->
    <footer class="position-relative z-index-10 d-print-none">
           
      <!-- Copyright section of the footer-->
      <div class="py-4 fw-light bg-gray-800 text-gray-300">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
              <p class="text-sm mb-md-0">&copy; 2022, I Camp Do It.  All rights reserved.</p>
            </div>
            <div class="col-md-6">
             <!-- 관리자페이지 바로가기 -->
             	
              	<ul class="list-inline mb-0 mt-2 mt-md-0 text-center text-md-end">
                <li class="list-inline-item"><a class="text-muted text-sm" href="./admin.do" >
              	관리자 페이지</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </footer>
    <!-- JavaScript files-->
    <script>
      // ------------------------------------------------------- //
      //   Inject SVG Sprite - 
      //   see more here 
      //   https://css-tricks.com/ajaxing-svg-sprite/
      // ------------------------------------------------------ //
      function injectSvgSprite(path) {
      
          var ajax = new XMLHttpRequest();
          ajax.open("GET", path, true);
          ajax.send();
          ajax.onload = function(e) {
          var div = document.createElement("div");
          div.className = 'd-none';
          div.innerHTML = ajax.responseText;
          document.body.insertBefore(div, document.body.childNodes[0]);
          }
      }    
      // to avoid CORS issues when viewing using file:// protocol, using the demo URL for the SVG sprite
      // use your own URL in production, please :)
      // https://demo.bootstrapious.com/directory/1-0/icons/orion-svg-sprite.svg
      //- injectSvgSprite('${path}icons/orion-svg-sprite.svg'); 
      injectSvgSprite('https://demo.bootstrapious.com/directory/1-4/icons/orion-svg-sprite.svg'); 
      
    </script>
    
    <script type="text/javascript">
 	window.onload = function() {
 		// 전체 선택해제
 		document.getElementById( 'allNonChk' ).onclick = function() {
 			 $(":checkbox").prop("checked",false);
 		}
 		
 		document.getElementById( 'detailSearch' ).onclick = function() {
 			$("#searchdetail").submit();
 		}
 	}
  	</script>
  	
    <!-- jQuery-->
    <script src="./resources/bootstrap-5/html/vendor/jquery/jquery.min.js"></script>
    <!-- Bootstrap JS bundle - Bootstrap + PopperJS-->
    <script src="./resources/bootstrap-5/html/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Magnific Popup - Lightbox for the gallery-->
    <script src="./resources/bootstrap-5/html/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
    <!-- Smooth scroll-->
    <script src="./resources/bootstrap-5/html/vendor/smooth-scroll/smooth-scroll.polyfills.min.js"></script>
    <!-- Bootstrap Select-->
    <script src="./resources/bootstrap-5/html/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <!-- Object Fit Images - Fallback for browsers that don't support object-fit-->
    <script src="./resources/bootstrap-5/html/vendor/object-fit-images/ofi.min.js"></script>
    <!-- Swiper Carousel                       -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.4.1/js/swiper.min.js"></script>
    <script>var basePath = ''</script>
    <!-- Main Theme JS file    -->
    <script src="./resources/bootstrap-5/html/js/theme.js"></script>
  </body>
</html>