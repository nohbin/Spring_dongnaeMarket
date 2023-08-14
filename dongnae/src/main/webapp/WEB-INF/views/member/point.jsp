<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 페이포인트</title>
</head>

<script type="text/javascript">
function kakaopay(){
	 const userCode = "imp18070471";
	let point = Number(${m_point}) + Number($('#pointInput').val() );
	IMP.init(userCode);
	IMP.request_pay({		
		pg : 'kakaopay',
		name : '동네마켓 포인트 충전' ,         // 결제창에 뜨는 이름
		amount : $('#pointInput').val() ,  //가격 
	},function(rsp){
		if(rsp.success){
			alert( "결제 완료") ;
			document.location.href="/member/pointSuccess?m_point="+point;
        }else{
        	alert( "결제 실패") ; 
        	document.location.href="/member/point";
        }
		
	});
}
</script>

<body>
<sec:authentication property="principal" var="member"/>

<jsp:include page="../header_member.jsp"></jsp:include>

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
                <div class="row">
                	<div class="container border my-3 rounded-5">
                		<div class="row">
	                            <div class="col-lg-5 col-md-5  col-sm-11 col-11  my-4 text-center" >
	                           		<h2>내 페이포인트</h2>
	                           	</div>
	                            <div class="col-lg-4 col-md-4 col-sm-11 col-11  my-4  text-center" >
	                           		<h2><fmt:formatNumber value="${m_point}"/> p</h2>
	                           	</div>
	                            <div class="col-lg-3 col-md-3 col-sm-11 col-11  my-4  text-center" >
	                           		<button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#staticBackdrop">충전하기</button>
	                           	</div>
	                        </div>
	                     </div>
	            </div>
	            
                <div class="row">
	                <div class="container border my-3 rounded-5">
	                <!-- <div class="container mx-auto" style="width: 80%;"> -->
	                            <div class="row mt-5  text-center" >
	                           		<h2>페이포인트 사용내역</h2>
	                           	</div>
	                           	<div class="row my-3">
		                        	<div class="col-12 col-md-11 my-3 mx-auto">
		                        		<table class="table table-hover">
											<tr>
												<th>일자</th>
												<th>구분</th>
												<th>금액</th>
											</tr>
												<c:forEach var="d" items="${dealList}">
												<c:choose>
													<c:when test="${d.d_type == 'buy'}">  
													<tr>
														<td>${d.d_regdate}</td>
														<td>출금</td>
														<td>-<fmt:formatNumber value="${d.g_price}"/> p</td>
													</tr>
													</c:when>
													<c:when test="${d.d_type == 'sold'}">  
													<tr>
														<td>${d.d_regdate}</td>
														<td>입금</td>
														<td>+<fmt:formatNumber value="${d.g_price}"/> p</td>
													</tr>
													</c:when>
													<%-- 
													<c:when test="${d.d_type == 'point'}">  
													<tr>
														<td>${d.d_regdate}</td>
														<td>충전</td>
														<td>+<fmt:formatNumber value="${d.g_price}"/> p</td>
													</tr>
													</c:when>
													 --%>
												</c:choose>
											</c:forEach>
										</table>
		                            </div>
	                            </div>
	                        </div>
	                    <!-- </div> -->
	                   </div>
	                   
	            </div>
                </div>
                </div>
    </section>
    <!-- Product Section End -->
	
	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
			      <div class="modal-header">
					  <h5 class="modal-title">충전하기</h5>
			      </div>
			      
			      <div class="modal-body">
					 <input type="text" id="pointInput" name="pointInput" style="width: 100%;"> 포인트
			      </div>
			      
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-warning" onclick="kakaopay()">카카오페이 결제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
		    </div>
		  </div>
		</div>
	
</body>
</html>