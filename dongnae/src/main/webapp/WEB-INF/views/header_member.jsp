<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Ogani | Template</title>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/resources/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/style.css" type="text/css">

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script>
var token = $("meta[name='_csrf']").attr('content');
var header = $("meta[name='_csrf_header']").attr('content');
$(function(){
    if(token && header) {
        $(document).ajaxSend(function(event, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    }
	fetchCategories();

})
		 
function fetchCategories() {
        $.ajax({
            url: '/api/getCategories',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                var category1Container = $('.category1');
                var listCategortContainer1 = $('.list_category');
                var category1List = data.category_1;
                
                category1Container.empty();

                // 카테고리1 li 생성
                category1List.forEach(function (categoryMain) {
                    var category1Item = $('<li><a href="#">' + categoryMain.c1_category + '</a></li>');
                    var listCategory1Item = $('<li><a href="#">' + categoryMain.c1_category + '</a></li>');
                    var category2Container = $('<ul class="category2 category2Container"></ul>');
                    
                    // filter 를 통해 category2 list 정리
                    var category2List = data.category_2.filter(function(category2) {
                        return category2.c1_id === categoryMain.c1_id;
                    });

                    category1Item.append(category2Container);

                    category1Item.on('mouseover', function () {
                    	// 기존의 category2Container 비우기
                        category2Container.empty(); 
                        
                        if (category2List.length > 0) {
                            category2List.forEach(function (category2) {
                                var category2Item = $('<li><a href="#">' + category2.c2_category + '</a></li>');
                                category2Container.append(category2Item);
                            });
                        }
                    });
                    
//                     listCategory1Item.onclick(function(){
                    
//                     })

//                     category1Item.on('mouseout', function () {
//                         category2Container.empty();
//                     });

                    //goods_list 테스트
                    listCategortContainer1.append(listCategory1Item);
                    category1Container.append(category1Item);
                    
                });
            },
            error: function (xhr, status, error) {
                alert("데이터 안불러와지는중");
            }
        });
    }
</script>

<body>
	<header>
        <a href="/" class="logo"><img src="/resources/img/logo.png" alt=""></a>
        <nav class="navbar">
        <section class="hero">
	        <div class="container">
	            <div class="row">
	                <!-- 검색 -->
	                <div class="col-lg-9">
	                    <div class="hero__search">
	                        <div class="hero__search__form">
	                           <form id="searchForm" action="#" method="get">
								    <input type="text" placeholder="What do you need?" name="search">
								    <button type="submit" class="site-btn">SEARCH</button>
								</form>
								
								<script>
								document.getElementById("searchForm").addEventListener("submit", function(event) {
								    event.preventDefault();
								    
								    var searchInput = document.querySelector("input[name='search']").value;
								    var encodedSearchInput = encodeURIComponent(searchInput);
								    
								    var newUrl = "/goods/search/" + encodedSearchInput;
								    window.location.href = newUrl;
								});
								</script>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
    	<div style="z-index: 2;">
            <ul>
                <li><a href="/">메인화면</a></li>
                <li><a href="">about</a></li>
                <li><a href="">카테고리</a>
                    <ul class="category1"></ul>
                </li>
                <li><a href="#">Review</a></li>
                <li><a href="#">Gallery +</a>
                    <ul>
                        <li><a href="">grid gallery</a></li>
                        <li><a href="">flex gallery</a></li>
                    </ul>
                </li>
            </ul>
    	</div>
        </nav>
        <sec:authorize access="isAnonymous()">
	        <div class="login_set"><a href="/login"><i class="fa fa-user"></i> Login</a></div>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
        <div class="login_set">
	         <a href="/goods/goods_insert">상품등록</a>
	         <a href="/logout">Logout</a>
	         <a href="/member/detail">마이페이지</a>
        </div>
         </sec:authorize>
    </header>
	<div class="col-lg-3">
	    <div class="header__cart">
	        <ul>
	            <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li>
	            <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a></li>
	        </ul>
	        <div class="header__cart__price">item: <span>$150.00</span></div>
	    </div>
	</div>
    <div class="humberger__open">
        <i class="fa fa-bars"></i>
    </div>	
</body>
</html>