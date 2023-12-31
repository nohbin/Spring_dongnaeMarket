<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<jsp:include page="../common/Category.jsp"></jsp:include>
<section class="breadcrumb-section set-bg" data-setbg="/resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                 
                    <div class="breadcrumb__text">
                   <h2 >Community</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
<div style="display: flex;">

	<div  style=" width: 15%; float: left  ; box-sizing: border-box; ">


		<div class="container" style="margin-left:50px;margin-top:100px;">

		<div >
			<table class="table table-borderless">	
			<thead>
			 <tr><th><a href="/community/main" class="fs-3">Community</a></th></tr>
			</thead>
			<tbody>		
			
			<c:forEach var="categorys" items="${categorys}"  >
			<tr><td><a  href="/community/pageCategory?ca_l=${categorys.ca_l}&num=1"> ${categorys.ca_l}</a></td></tr>
			</c:forEach>
			
			</tbody>
			
			</table>
		
			
		</div>
		
		
	</div>
	</div>

	<div  class="container" style=" width: 85%;   box-sizing: border-box; margin-top:100px;" >
		
		
		<div class="container"  style="float: right; width: 400px;" >
		  <div class="row no-gutters" >
		    <div class="col-sm-1 " >
		      <select class="form-select" name="searchType" id="searchType" style="width: 120px; ">
				<option value="mu_name" <c:if test="${page.searchType eq 'mu_name'}">selected</c:if> >제목</option>
				<option value="mu_detail" <c:if test="${page.searchType eq 'mu_detail'}">selected</c:if> >내용</option>
				<option value="mu_name_mu_detail" <c:if test="${page.searchType eq 'mu_name_mu_detail'}">selected</c:if> >제목+내용</option>
				<option value="m_id" <c:if test="${page.searchType eq 'm_id'}">selected</c:if> >작성자</option>
			  </select>
		    </div>
		    <div class="col-sm-2 " style="margin-left:90px"  >
		    	<input class="form-control" style="width: 200px;" type="text" id="keyword" name="keyword" value="${page.keyword}">
		    </div>
		    <div class="col-sm-1" style="margin-left:140px" >
		    	<button class="btn btn-outline-dark"  style="width: 60px;" id="search" type="button">검색</button>
		    </div>
		  </div>
		</div>
		
		
		
			
			
			
		
	<div class="container"  >
	 <p class="text-dark fw-bold " style="margin-top:30px;">최신게시물</p>
	<div class="card shadow" >
		
		<table class=" table table-borderless align-middle table-hover">
			<thead class=" text-center">
				<tr>
					<th>지역</th>
					<th>사진</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>좋아요</th>
					<th>댓글수</th>
					<th>작성시간</th>
				</tr>
			</thead>
	
			<tbody class=" text-center" >
				<c:forEach var="list" items="${list}" begin="0" end="4" >
					<tr onclick="location.href='/community/communityDetail?mu_id=${list.mu_id}' ">
						<td class="align-middle">${list.si_area}</td>
						<c:choose>
						    <c:when test="${not empty list.previewImageUrl}">
						        <td class="align-middle">
								  <img class="img-thumbnail" src="${list.previewImageUrl}" style="width: 100px; border:0px;">
							   </td>
						    </c:when>
						    <c:otherwise>
						        <td></td>
						    </c:otherwise>
						</c:choose>
						<td class="align-middle">
							${list.mu_name}
						</td>
						<td class="align-middle">${list.m_id}</td>
						
						<td class="align-middle">
						<i class="bi bi-eye fs-5">${list.mu_c}</i>
						
						
						</td>
						<td class="align-middle"><i class="bi bi-chat-square-heart fs-5">${list.heart}</i></td>
						<td class="align-middle"><i class="bi bi-chat-right fs-5">${list.comment}</i></td>
						<td class="align-middle">
							<fmt:formatDate value="${list.mu_data}" pattern="yyyy-MM-dd " />
							<br>
							<fmt:formatDate value="${list.mu_data}" pattern=" HH:mm" />
						</td>
					</tr>
				</c:forEach>
			</tbody>	
			
		</table>
  
 	 <a href="/community/page?key=1&num=1"  class="btn btn-light" >더보기</a>
	
 
 </div>
 <p class="text-dark fw-bold" style="margin-top:50px;">인기게시물</p>
 <div class="card shadow" >
		<table  class=" table table-borderless align-middle table-hover">
			<thead class=" text-center">
				<tr>
					<th>지역</th>
					<th>사진</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>좋아요</th>
					<th>댓글수</th>
					<th>작성시간</th>
				</tr>
			</thead>
	
		
			<tbody class=" text-center" >
				<c:forEach var="list" items="${sorted}" begin="0" end="4" >
					<tr onclick="location.href='/community/communityDetail?mu_id=${list.mu_id}'" >
						<td class="align-middle">${list.si_area}</td>
						<c:choose>
						    <c:when test="${not empty list.previewImageUrl}">
						        <td class="align-middle">
								  <img class="img-thumbnail" src="${list.previewImageUrl}" style="width: 100px; border:0px;">
							   </td>
						    </c:when>
						    <c:otherwise>
						        <td></td>
						    </c:otherwise>
						</c:choose>
						<td class="align-middle">
							${list.mu_name}
						</td>
						<td class="align-middle">${list.m_id}</td>
						
						<td class="align-middle">
						<i class="bi bi-eye fs-5">${list.mu_c}</i>
						
						
						</td>
						<td class="align-middle"><i class="bi bi-chat-square-heart fs-5">${list.heart}</i></td>
						<td class="align-middle"><i class="bi bi-chat-right fs-5">${list.comment}</i></td>
						<td class="align-middle">
							<fmt:formatDate value="${list.mu_data}" pattern="yyyy-MM-dd " />
							<br>
							<fmt:formatDate value="${list.mu_data}" pattern=" HH:mm" />
						</td>
					</tr>
				</c:forEach>
			</tbody>	
		</table>
	
 
 	<a href="/community/page?key=2&num=1" class="btn btn-light" >더보기</a>
	
  </div>
 </div> 
</div>		
	 </div> 	
		
<jsp:include page="../common/footer.jsp"></jsp:include>	
</body>
<script type="text/javascript">
$("#search").on('click',function(){
	var keyword = $("#keyword").val();
	var searchType = $("#searchType").val();
	if (keyword == null) {
		confirm("검색할 키워드를 입력하세요");
		location.reload(); 
	}else{
	
		$.ajax({
			url: "/community/communitySearch",
			method:"GET",
			data:{
				"keyword":keyword,
				"searchType":searchType,
				"num":1
			},
			success:function(){
				
				 location.href='/community/communitySearch?num=1'+ "&searchType=" + searchType + "&keyword=" + keyword;
			
			}
		});
	}	
	
  });
	
	
sessionStorage.setItem('previousURL', window.location.href);
 
</script>
</html>