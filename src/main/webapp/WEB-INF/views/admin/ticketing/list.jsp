<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<security:csrfMetaTags/>
<title>예매관리</title>
<!-- admin common file setting -->
<c:import url="../common/adminSettings.jsp"></c:import>
<script src="/resources/admin/js/ticketing.js"></script>
</head>
<body>
	<div class="container-scroller">
		<!-- header -->
		<nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
			<!-- 상단 로고 박스 -->
			<div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center">
				<a class="navbar-brand brand-logo" href="/admin/member/list">
					<img src="/resources/admin/images/logo.svg" alt="logo" />
				</a>
				<a class="navbar-brand brand-logo-mini" href="/admin/member/list">
					<img src="/resources/admin/images/logo-mini.svg" alt="logo" />
				</a>
			</div>
			<!-- //상단 로고 박스 -->
			<!-- 상단 흰색 바 -->
			<div class="navbar-menu-wrapper d-flex align-items-center"></div>
			<!-- //상단 흰색 바 -->
		</nav>
		<!-- header -->
		<!-- main -->
		<div class="container-fluid page-body-wrapper">
			<!-- side menu -->
			<nav class="sidebar sidebar-offcanvas" id="sidebar">
				<ul class="nav">
					<!-- menu title -->
					<li class="nav-item nav-category">Main Menu</li>
					<!-- //menu title -->
					<!-- item -->
					<li class="nav-item">
						<a class="nav-link" href="/admin/member/list"> 
							<i class="menu-icon typcn typcn-document-text"></i>
							<span class="menu-title">회원관리</span>
						</a>
					</li>
					<!-- //item -->
					<!-- item -->
					<li class="nav-item">
						<a class="nav-link" href="/admin/ticketing/list">
							<i class="menu-icon typcn typcn-document-text"></i>
							<span class="menu-title">예매관리</span>
						</a>
					</li>
					<!-- //item -->
					<!-- item -->
					<li class="nav-item">
						<a class="nav-link" href="/admin/questions/list">
							<i class="menu-icon typcn typcn-document-text"></i>
							<span class="menu-title">Q&#38;A 답변관리</span>
						</a>
					</li>
					<!-- //item -->
				</ul>
			</nav>
			<!-- //side menu -->
			<!-- white box  -->
			<div class="main-panel">
				<!-- content box -->
				<div class="content-wrapper">
					<!-- white box -->
					<div class="col-lg-12 grid-margin stretch-card">
						<div class="card">
							<div class="card-body">
								<h3>예매 리스트</h3>
								<br>
								<div class="form-group">
									<c:set var="type" value="${pageMaker.criteria.searchType}"/>
									<select id="searchType" name="searchType" class="form-control col-sm-1" onchange="resetKeyword()">
										<option value="a" ${type eq "a" ? "selected" : ""}>전체</option>
										<option value="1" ${type eq "1" ? "selected" : ""}>예매완료</option>
										<option value="0" ${type eq "0" ? "selected" : ""}>취소</option>
									</select>
									<input type="date" class="form-control col-sm-2" id="keyword" name="keyword" value="${pageMaker.criteria.keyword}" placeholder="날짜선택">
									<input type="button" class="btn btn-secondary" value="검색" onclick="search_btn();">
								</div>
								<!-- table -->
								<table class="table table-bordered" style="table-layout: fixed;">
									<thead>
										<tr>
											<th><input type="checkbox" id="check_all" onclick="check_all()"></th>
											<th>예매번호</th>
											<th>email</th>
											<th>출발지</th>
											<th>도착지</th>
											<th>날짜</th>
											<th>매수</th>
											<th>좌석</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${ticketingList}">
										<tr>
											<td><input type="checkbox" class="select_num" value="${list.ticketing_number}"></td>
											<td class="ellipsis">${list.ticketing_number}</td>
											<td class="ellipsis">${list.email}</td>
											<td>${list.departure_area}</td>
											<td>${list.destination}</td>
											<td class="ellipsis">${list.departure_date}</td>
											<td>${list.number_of_tickets}명</td>
											<td class="ellipsis">${fn:replace(list.seat_number, '/','번 ')}</td>
											<td>
												<c:if test="${list.ticketing_status == 1 && fn:contains(list.departure_date, serverTime)}">예매완료</c:if>
												<c:if test="${list.ticketing_status == 0}">취소완료</c:if>
												<c:if test="${list.ticketing_status == 1 && !fn:contains(list.departure_date, serverTime)}">운행완료</c:if>
											</td>
											<td>
												<c:if test="${list.ticketing_status == 1 && fn:contains(list.departure_date, serverTime)}">
													<button type="button" id="${list.ticketing_number}" class="btn btn-danger cancle">예매 취소</button>
												</c:if>
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:import url="../common/paging.jsp" />
								<!-- //table -->
								<br>
								<div class="form-group">
									<button type="button" class="btn btn-danger" onclick="deleteList()">삭제</button>
								</div>
							</div>
						</div>
					</div>
					<!-- //white box -->
				</div>
				<!-- //content box -->
				<!-- footer -->
				<footer class="footer">
					<div class="container-fluid clearfix">
						<span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © bootstrapdash.com 2020</span>
						<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">
							Free 
							<a href="https://www.bootstrapdash.com/bootstrap-admin-template/" target="_blank">Bootstrap admin templates</a> 
							from Bootstrapdash.com
						</span>
					</div>
				</footer>
				<!-- //footer -->
			</div>
			<!-- //white box  -->
		</div>
		<!-- //main -->
	</div>
</body>
</html>