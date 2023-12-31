<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매내역</title>
</head>

<body>
<sec:authentication property="principal" var="member"/>

<jsp:include page="../common/Category.jsp"></jsp:include>

 <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="/resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>My Page</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb Section End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
             <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="sidebar">
                    	<jsp:include page="./sidebar.jsp"></jsp:include>
                    </div>
                </div>
                <div class="col-lg-9 col-md-9">
	                <div class="container border my-3 rounded-5">
	                <!-- <div class="container mx-auto" style="width: 80%;"> -->
	                
	                            <div class="row mt-5  text-center" >
	                           		<h2>판매내역</h2>
	                           	</div>
	                           	
	                           	<div  ${ (soldList == "[]" )? '' : 'style="display: none;"' }  class="row mt-5  text-center" >
	                           		<div>판매 내역이 존재하지 않습니다.</div>
	                           	</div>
	                           	
	                           	<div class="row my-3">
		                        	<div class="col-12 col-md-11 my-3 mx-auto">
		                        		<c:forEach var="s" items="${soldList}">
		                        		<div class="row col-12 col-md-11 container border my-3 rounded-5" style="float: none; margin: 0 auto;">
		                        			<div class ="col-6 col-md-3 m-auto">
		                        			<!-- 
		                        				<img src="https://image.istarbucks.co.kr/upload/store/skuimg/2021/08/[11123351]_20210803101044084.jpg" style="width: 100%" />
		                        				 -->
		                        				<img src="/resources/upload/goods/${s.g_picpath}/${s.g_pic01 }" style="width: 100%" />
		                        			</div>
		                        			
		                        			<div class ="col-12 col-md-9 my-auto">
			                        			<div class="row my-3">
			                        				<div class="col-lg-3 col-md-6  col-sm-12 col-12 font-weight-bold" >
			                        				상품이름
			                        				</div>
			                        				<div class="col-lg-8 col-md-6  col-sm-12 col-12 ">
			                        				${s.g_name}
			                        				</div>
			                        			</div>	
			                        			<div class="row my-3">
			                        				<div class="col-lg-3 col-md-6 col-sm-12 col-12 font-weight-bold " >
			                        				가격
			                        				</div>
			                        				<div class=" col-lg-8 col-md-6 col-sm-12 col-12 ">
			                        				 <fmt:formatNumber value="${s.g_price}"/>원
			                        				</div>
			                        			</div>	
			                        			<div class="row my-3">
			                        				<div class="col-lg-3 col-md-6 col-sm-12 col-12 font-weight-bold " >
			                        				판매일
			                        				</div>
			                        				<div class=" col-lg-8 col-md-6 col-sm-12 col-12 ">
			                        				 ${s.d_regdate}
			                        				</div>
			                        			</div>	
		                        			</div>
		                        			
		                        		</div>
		                        		</c:forEach>
		                            </div>
	                            </div>
	                            
	                            
	                            <div class="row my-3">
	                            <div class="col-12 col-md-11 my-3 mx-auto">
	                            	<nav aria-label="Page navigation example  ">
									  <ul class="pagination justify-content-center">
									   
									   <c:set var="p" value="${page}" /> 
									   
									   <c:choose>
										   <c:when test="${p.prev > 0}" >
										    	<li class="page-item"><a class="page-link" href="/member/soldList?p=${p.prev}">Previous</a></li>
										   </c:when>
										   <c:otherwise>
										    	<li class="page-item disabled"><a class="page-link">Previous</a></li>
										   </c:otherwise>
									   </c:choose>
									   
									    <c:forEach var="pageNum" begin="${p.startPageNum}" end="${p.endPageNum}">
									    	<li class="page-item ${ (p.nowpage == pageNum )?  'active' : '' } " >
									    		<a class="page-link" href="/member/soldList?p=${pageNum}">${pageNum}</a>
									    	</li>
									    </c:forEach>
									    
									 	<c:choose>
										   <c:when test="${p.next <= p.realEndPageNum}" >
										    	<li class="page-item"><a class="page-link" href="/member/soldList?p=${p.next}">Next</a></li>
										   </c:when>
										   <c:otherwise>
										    	<li class="page-item disabled"><a class="page-link">Next</a></li>
										   </c:otherwise>
									   </c:choose>
									  </ul>
									</nav>
	                            </div>
	                        </div>
	                        
	                            
	                        </div>
	                    <!-- </div> -->
	                    </div>
                </div>
                </div>
    </section>
    <!-- Product Section End -->
	
	<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>