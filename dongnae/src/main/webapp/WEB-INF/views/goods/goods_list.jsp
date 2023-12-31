<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script>

$(function(){
	var token = $("meta[name='_csrf']").attr('content');
	var header = $("meta[name='_csrf_header']").attr('content');
    if(token && header) {
        $(document).ajaxSend(function(event, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    }
	getListCategoryAjax();

})
		 
function getListCategoryAjax() {
	    $.ajax({
	        url: '/api/getCategories',
	        type: 'post',
	        dataType: 'json',
	        success: function (data) {
	            var listContainer1 = $('.list_category');
	            var listCategory1 = data.category_1;
				
	            listCategory1.forEach(function(category1){
	            	var list1 = $('<li></li>'); // <li> 요소 생성

	            	var divContainer = $('<div class="justify-content-between"></div>'); // <div> 요소 생성
	            	var labelElement = $('<label class="flex"><span class="relative">' + category1.c1_category + '</span></label>'); // <label> 요소 생성

	            	var add = $('<div class="justify-end cursir-pointer"><i class="fa fa-plus"></i></div>');
	            	var listContainer2;	
	            	
	            	
	            	divContainer.append(labelElement); // <label> 요소를 <div> 요소 내에 추가
	            	divContainer.append(add); // <label> 요소를 <div> 요소 내에 추가
	            
	            	list1.append(divContainer); // <div> 요소를 <li> 요소 내에 추가
	            	var listCategory2 = data.category_2.filter(function(category2){
	            		return category2.c1_id === category1.c1_id;	
	            	});
	            	
	            	add.on('click', function() {
	            	    listContainer2.toggleClass('hidden');
	            	});
	            	
	            	listContainer2 = $('<ul class = "pt-4 hidden"></ul>');
	            	listCategory2.forEach(function(category2){
	            		var category2Id = category2.c2_id;
	            		var list2 = $('<li class="mt-2">- ' + category2.c2_category + '</li>');
	            		listContainer2.append(list2);
	            		
	            		list2.on('click', function() {
                            var categoryId = category2.c2_id; // 카테고리 ID 가져오기
                            var searchValue = document.querySelector(".searchName").textContent.trim();// .search 클래스를 가진 요소의 텍스트 콘텐츠 가져오기
                            console.log(searchValue);
                            var encodedSearchValue = encodeURIComponent(searchValue);
                            var baseNewUrl = "${pageContext.request.contextPath }/goods/search/";
                            var query = "";
                            
                            if (searchValue != null) {
                                query = encodedSearchValue +"?category=" + categoryId;
                            } else {
                                query = "?category=" + categoryId;
                            }
                            
                            var newUrl = baseNewUrl + query;
                            
                            // 페이지 이동
                            window.location.href = newUrl;
                        });
	            	});
	            	
	            	list1.append(listContainer2);
	            	listContainer1.append(list1);
	            	
	            	labelElement.on('click', function() {
                        var categoryId = category1.c1_id; // 카테고리 ID 가져오기
                        var searchValue = document.querySelector(".searchName").textContent.trim();// .search 클래스를 가진 요소의 텍스트 콘텐츠 가져오기
                        console.log(searchValue);
                        var encodedSearchValue = encodeURIComponent(searchValue);
                        var baseNewUrl = "${pageContext.request.contextPath }/goods/search/";
                        var query = "";
                        
                        if (searchValue != null) {
                            query = encodedSearchValue +"?category=" + categoryId;
                        } else {
                            query = "?category=" + categoryId;
                        }
                        
                        var newUrl = baseNewUrl + query;
                        
                        // 페이지 이동
                        window.location.href = newUrl;
                    });
	        	});
	        },
	        error: function (xhr, status, error) {
	        }
	    });
	}
</script>


<style>
	li:hover {
    	color: black !important;
    }
    li{
    	cursor: pointer !important;
    }
    span{
    	cursor: pointer !important;
    }
}
</style>
<body>
	<jsp:include page="../common/Category.jsp"></jsp:include>
	
    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-5">
                    <div class="sidebar">
                        <div class="sidebar__item">
                            <h4>필터</h4>
                            <div>
	                           	<c:out value="${search }"></c:out>
                            </div>
                            <hr>
                            <div class="category row ">
	                            <h4>카테고리</h4>
	                            <ul class="list_category mt-2"></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-7">
                    <div class="product__discount">
                        <div class="section-title product__discount__title searchName">
                            <h2>${search }</h2>
                        </div>
                    </div>
                    <div class="filter__item">
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
                                <div class="filter__sort">
                                    <span>분류</span>
                                    <select>
                                        <option value="0">Default</option>
                                        <option value="0">Default</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4">
                                <div class="filter__found">
                                    <h6><span><b>${goodsLists.size()} </b></span> 개의 상품을 찾았습니다.</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 상품 리스트 -->
                       <div class="row goodsList">
					    <c:choose>
					        <c:when test="${not empty goodsLists}">
					            <c:forEach items="${goodsLists}" var="goods">
					                <div class="col-lg-4 col-md-6 col-sm-6">
					                    <div class="featured__item">
					                        <div class="featured__item__pic set-bg" data-setbg="/resources/upload/goods/${goods.g_picpath}/${goods.g_pic01}">
					                            <ul class="featured__item__pic__hover">
					                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
					                            </ul>
					                        </div>
					                        <div class="featured__item__text">
					                            <a class="move" href="<c:out value='${pageContext.request.contextPath }/goods/goods_detail/${goods.g_id}' />">
					                                <h6><c:out value="${goods.g_name }"/></h6>
					                            </a>
					                            <h5><fmt:formatNumber value="${goods.g_price}"  pattern="#,###"/>원</h5>
					                        </div>
					                    </div>
					                </div>
					            </c:forEach>
					        </c:when>
					        <c:otherwise>
					            <p><c:out value="${search}" /> 해당 상품을 찾을 수 없습니다.</p>
					        </c:otherwise>
					    </c:choose>
					</div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->
	
	<jsp:include page="../common/footer.jsp"></jsp:include>


</body>
</html>