<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.exam.hboard.HBoardTO" %>
<%@ page import="com.exam.hboard.HBoardListTO" %>
<%@ page import="java.util.ArrayList" %>	
<%
	//session 값 가져오기
	int ucode = -1;
	String id ="";
	if(session.getAttribute("id") != null){
		ucode = (int)session.getAttribute("ucode");
		id = (String)session.getAttribute("id");
	}
	
	HBoardListTO listTO = (HBoardListTO)request.getAttribute("listTO");
	int cpage = (Integer)request.getAttribute( "cpage" );
	
	int recordPerPage = listTO.getRecordPerPage();
	int totalPage = listTO.getTotalPage();
	int blockPerPage = listTO.getBlockPerPage();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	int totalRecord = listTO.getTotalRecord();
	
	ArrayList<HBoardTO> lists = listTO.getBoardLists();
	
	StringBuilder sbHtml = new StringBuilder();
	
	String filename="";
	
	
	for( HBoardTO to : lists ) {
	String seq = to.getSeq();
	String subject = to.getSubject();
	String title = to.getTitle();
	String writer = to.getWriter();
	String content = to.getContent();
		if( to.getFilename() != null ) {
			filename = "./h_upload/" + to.getFilename();
		} else {
			filename = "./resources/bootstrap-5/html/img/noimage.svg";
		}
	String wdate = to.getWdate();
	String hit = to.getHit();
	
		sbHtml.append( "<div class='col-lg-4 col-sm-6 mb-4 hover-animate'>" );
		sbHtml.append( "<div class='card shadow border-0 h-100'>" );
		sbHtml.append( "<a href='./hboardview.do?cpage=" + cpage + "&seq=" + seq + "'>" );
		sbHtml.append( "<img class='img-fluid card-img-top' src='" + filename + "' alt='image'/>" );
		sbHtml.append( "</a>" );
		sbHtml.append( "<div class='card-body'>" );
		sbHtml.append( "<a class='text-uppercase text-muted text-sm letter-spacing-2' ># content </a>" );
		sbHtml.append( "<h5 class='my-2'><a class='text-dark' href='./hboardview.do?cpage=" + cpage + "&seq=" + seq + "'>" + title +"</a></h5>" );
		sbHtml.append( "<p class='text-gray-500 text-sm my-3'><i class='far fa-clock me-2'></i>" + wdate + "</p>" );
		sbHtml.append( "<p class='my-2 text-muted text-sm'><i class='fa-solid fa-bullhorn'<i class='fa-solid fa-bullhorn'></i><strong>&nbsp;&nbsp; Content update for August</strong></p>" );
		sbHtml.append( "<a class='btn btn-link ps-0' href='./hboardview.do?cpage=" + cpage + "&seq=" + seq + "'>더보기<i class='fa fa-long-arrow-alt-right ms-2'></i></a>" );
		sbHtml.append( "</div>" );
		sbHtml.append( "</div>" );
		sbHtml.append( "</div>" );
		
	}
%>

<!DOCTYPE html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>I CAMP DO IT</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <link rel="stylesheet" href="./resources/bootstrap-5/html/css/font.css" type="text/css">
     <!-- Font Awesome 이거 추가함 -->
    <script src="https://kit.fontawesome.com/5251502df3.js" crossorigin="anonymous"></script>   
    <!-- Price Slider Stylesheets -->
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
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
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
    
    <!-- 게시판 시작 --> 
    <section class="position-relative py-6"><img class="bg-image" src="./resources/bootstrap-5/html/img/photo/자료실.png" alt="">
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <div class="card">
              <div class="card-body p-5"><strong class="text-uppercase text-primary d-inline-block mb-2 text-sm" style="font-family: 'Recipekorea';">없는 거 빼고 다 있는</strong>
                <h2 class="mb-3" style="font-family: 'Recipekorea';">혼캠 자료실</h2>
                <p class="text-muted" style="font-family: 'BMJUA';">혼캠족을 위한 자료실입니다.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pb-4 pt-6">
      <div class="container">
        <div class="row mb-5">
          <!-- blog item
          <div class="col-lg-4 col-sm-6 mb-4 hover-animate">
            <div class="card shadow border-0 h-100"><a href="./hboardview.do"><img class="img-fluid card-img-top" src="./resources/bootstrap-5/html/img/photo/원플리1.jpg" alt="..."/></a>
              <div class="card-body"><a class="text-uppercase text-muted text-sm letter-spacing-2" href="#"># playlist </a>
                <h5 class="my-2"><a class="text-dark" href="./hboardview.do">Late Spring breeze          </a></h5>
                <p class="text-gray-500 text-sm my-3"><i class="far fa-clock me-2"></i>July 26, 2022</p>
                <p class="my-2 text-muted text-sm">Pellentesque habitant morbi tristique senectus. Vestibulum tortor quam, feugiat vitae, ultricies ege...</p><a class="btn btn-link ps-0" href="./hboardview.do">더보기<i class="fa fa-long-arrow-alt-right ms-2"></i></a>
              </div>
            </div>
          </div>
          -->
          <%=sbHtml.toString() %>
        <!-- 페이징 -->
        <nav aria-label="Page navigation example">  
          <ul class="pagination pagination-template d-flex justify-content-center pt-5">
         <%			
	//페이지 하단의 << 버튼
	if ( startBlock == 1 ) {
		out.println(" <li class='page-item'><a class='page-link' href='#'><i class='fa fa-thin fa-angles-left'></i></a></li> ");
	} else {
		out.println(" <li class='page-item'><a class='page-link' href='hboardlist.do?cpage="+ (startBlock - blockPerPage) +"'><i class='fa fa-thin fa-angles-left'></i></a></li> ");
	}
	//페이지 하단의 < 버튼 => (cpage-1) 한페이지 앞으로 이동
	if ( cpage == 1 ) {
		out.println(" <li class='page-item'><a class='page-link' href='#'> <i class='fa fa-angle-left'></i></a></li> ");
	} else {
		out.println(" <li class='page-item'><a class='page-link' href='hboardlist.do?cpage="+ (cpage-1) +"'><i class='fa fa-angle-left'></i></a></li> ");
	}
	//현재 페이지
	for ( int i=startBlock; i<=endBlock; i++ ) {
		if ( cpage == i ) { 
			out.println(" <li class='page-item active'><a class='page-link' href='#'>" + i + "</a></li> ");
		} else {
			out.println(" <li class='page-item'><a class='page-link' href='hboardlist.do?cpage=" + i + "'>" + i + "</a></li> ");
		}
	}
	//페이지 하단의 > 버튼
	if ( cpage == totalPage ) {
		out.println(" <li class='page-item'><a class='page-link' href='#'><i class='fa fa-angle-right'></i></a></li> ");
	} else {
		out.println(" <li class='page-item'><a class='page-link' href='hboardlist.do?cpage="+ (cpage+1) +"'><i class='fa fa-angle-right'></i></a></li> ");
	}
	//페이지 하단의 >> 버튼
	if ( endBlock == totalPage ) {
		out.println(" <li class='page-item'><a class='page-link' href='#'><i class='fa fa-thin fa-angles-right'></i></a></li> ");
	} else {
		out.println(" <li class='page-item'><a class='page-link' href='hboardlist.do?cpage="+ (startBlock + blockPerPage) +"'><i class='fa fa-thin fa-angles-right'></i></a></li> ");
	}

%>        
          </ul>
        </nav>
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
                <li class="list-inline-item">
                <a class="text-muted text-sm" href="./admin.do" >관리자 페이지</a>
              	</li>
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