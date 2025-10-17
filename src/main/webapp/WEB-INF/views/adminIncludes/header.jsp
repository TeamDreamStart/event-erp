<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Sidebar -->
<ul
	class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
	id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a
		class="sidebar-brand d-flex align-items-center justify-content-center"
		href="/admin">
		<div class="sidebar-brand-icon">
			<figure>
				<img style="width: 100px" src="/resources/img/ds_logo.png"
					alt="로고이미지">
			</figure>
			<!-- <div class="sidebar-brand-text mx-3">
				<sup>event-erp</sup>
			</div> -->
		</div>
	</a>

	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<!-- Nav Item - Dashboard -->
	<li class="nav-item active"><a class="nav-link" href="/admin">
			<i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span>
	</a></li>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">Event</div>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true"
		aria-controls="collapseTwo"> <i class="fas fa-fw fa-cog"></i> <span>Components</span>
	</a>
		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Custom Components:</h6>
				<a class="collapse-item" href="buttons.html">Buttons</a> <a
					class="collapse-item" href="cards.html">Cards</a>
			</div>
		</div></li>

	<!-- Nav Item - Utilities Collapse Menu -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseUtilities"
		aria-expanded="true" aria-controls="collapseUtilities"> <i
			class="fas fa-fw fa-wrench"></i> <span>Utilities</span>
	</a>
		<div id="collapseUtilities" class="collapse"
			aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Custom Utilities:</h6>
				<a class="collapse-item" href="utilities-color.html">Colors</a> <a
					class="collapse-item" href="utilities-border.html">Borders</a> <a
					class="collapse-item" href="utilities-animation.html">Animations</a>
				<a class="collapse-item" href="utilities-other.html">Other</a>
			</div>
		</div></li>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">MANAGE</div>
	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapsePages"
		aria-expanded="true" aria-controls="collapsePages"> <i
			class="fas fa-fw fa-folder"></i> <span>Pages</span>
	</a>
		<div id="collapsePages" class="collapse"
			aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Login Screens:</h6>
				<a class="collapse-item" href="login.html">Login</a> <a
					class="collapse-item" href="register.html">Register</a> <a
					class="collapse-item" href="forgot-password.html">Forgot
					Password</a>
				<div class="collapse-divider"></div>
				<h6 class="collapse-header">Other Pages:</h6>
				<a class="collapse-item" href="404.html">404 Page</a> <a
					class="collapse-item" href="blank.html">Blank Page</a>
			</div>
		</div></li>

	<!-- Nav Item - Charts -->
	<li class="nav-item"><a class="nav-link" href="charts.html"> <i
			class="fas fa-fw fa-chart-area"></i> <span>Charts</span></a></li>

	<!-- 관리자 테이블 목록  -->
	<%-- ===== Event Manage ===== --%>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<c:set var="uri" value="${pageContext.request.requestURI}" />
	<c:set var="isEvent" value="${fn:startsWith(uri, ctx.concat('/admin/events'))}" />
	
	<li class="nav-item ${isEvent ? 'active' : ''}">
	  <a class="nav-link collapsed" href="#"
	     data-toggle="collapse" data-target="#collapseEvent"
	     aria-expanded="${isEvent ? 'true' : 'false'}" aria-controls="collapseEvent">
	    <i class="fas fa-fw fa-calendar-alt"></i>
	    <span>Event Manage</span>
	  </a>
	  <div id="collapseEvent"
	       class="collapse ${isEvent ? 'show' : ''}"
	       aria-labelledby="headingEvent" data-parent="#accordionSidebar">
	    <div class="bg-white py-2 collapse-inner rounded">
	      <h6 class="collapse-header">Events</h6>
	
	      <a class="collapse-item ${uri == ctx.concat('/admin/events') ? 'active' : ''}"
	         href="<c:url value='/admin/events'/>">Event List</a>
	
	      <a class="collapse-item ${uri == ctx.concat('/admin/events/form') ? 'active' : ''}"
	         href="<c:url value='/admin/events/form'/>">Create Event</a>
	    </div>
	  </div>
	</li>

	<li class="nav-item"><a class="nav-link" href="/admin/reservation-manage"> <i
			class="fas fa-fw fa-table"></i> <span>Reservation Manage</span></a></li>
	<li class="nav-item"><a class="nav-link" href="/admin/payment-manage"> <i
			class="fas fa-fw fa-table"></i> <span>Payment Manage</span></a></li>

	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<c:set var="uri" value="${pageContext.request.requestURI}" />
	<c:set var="isSurvey" value="${fn:startsWith(uri, ctx.concat('/admin/surveys'))}" />
	<!-- Survey Manage -->	
	<li class="nav-item ${isSurvey ? 'active' : ''}">
	  <a class="nav-link collapsed" href="#"
	     data-toggle="collapse" data-target="#collapseSurvey"
	     aria-expanded="${isSurvey ? 'true' : 'false'}" aria-controls="collapseSurvey">
	    <i class="fas fa-fw fa-poll"></i>
	    <span>Survey Manage</span>
	  </a>
	  <div id="collapseSurvey"
	       class="collapse ${isSurvey ? 'show' : ''}"
	       aria-labelledby="headingSurvey" data-parent="#accordionSidebar">
	    <div class="bg-white py-2 collapse-inner rounded">
	      <h6 class="collapse-header">Surveys</h6>
	      <a class="collapse-item ${uri == ctx.concat('/admin/surveys') ? 'active' : ''}"
	         href="<c:url value='/admin/surveys'/>">Survey List</a>
	      <a class="collapse-item ${uri == ctx.concat('/admin/surveys/form') ? 'active' : ''}"
	         href="<c:url value='/admin/surveys/form'/>">Create Survey</a>
	      <!-- 필요하면 템플릿 고정 리스트로 바로 가기 링크도 가능
	      <a class="collapse-item" href="<c:url value='/admin/surveys?field=isTemplate&keyword=1'/>">Templates</a>
	      -->
	    </div>
	  </div>
	</li>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseBoard"
		aria-expanded="true" aria-controls="collapseBoard"> <i
			class="fas fa-fw fa-folder"></i> <span>Boards</span>
	</a>
		<div id="collapseBoard" class="collapse"
			aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Board Manage</h6>
				<a class="collapse-item" href="/admin/notices">Notices</a> <a
					class="collapse-item" href="/admin/qna">Q&A</a>
			</div>
		</div></li>


	<!-- <li class="nav-item"><a class="nav-link" href="/admin/notices">
			<i class="fas fa-fw fa-table"></i> <span>NOTICE</span>
	</a></li> -->
	<li class="nav-item"><a class="nav-link" href="/admin/customers"> <i
			class="fas fa-fw fa-table"></i> <span>Customers</span></a></li>

	<!-- Divider -->
	<hr class="sidebar-divider d-none d-md-block">

	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>

	<!-- Sidebar Message -->
	<div class="sidebar-card d-none d-lg-flex">
		<img class="sidebar-card-illustration mb-2"
			src="/resources/img/undraw_rocket.svg" alt="...">
		<p class="text-center mb-2">
			<strong>SB Admin Pro</strong> is packed with premium features,
			components, and more!
		</p>
		<a class="btn btn-success btn-sm"
			href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to
			Pro!</a>
	</div>

</ul>
<!-- End of Sidebar -->

<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">

	<!-- Main Content -->
	<div id="content">

		<!-- Topbar -->
		<nav
			class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

			<!-- Sidebar Toggle (Topbar) -->
			<button id="sidebarToggleTop"
				class="btn btn-link d-md-none rounded-circle mr-3">
				<i class="fa fa-bars"></i>
			</button>


			<!-- Topbar Navbar -->
			<ul class="navbar-nav ml-auto">

				<!-- Nav Item - Search Dropdown (Visible Only XS) -->
				<li class="nav-item dropdown no-arrow d-sm-none"><a
					class="nav-link dropdown-toggle" href="#" id="searchDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
				</a> <!-- Dropdown - Messages -->
					<div
						class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
						aria-labelledby="searchDropdown">
						<form class="form-inline mr-auto w-100 navbar-search">
							<div class="input-group">
								<input type="text" class="form-control bg-light border-0 small"
									placeholder="Search for..." aria-label="Search"
									aria-describedby="basic-addon2">
								<div class="input-group-append">
									<button class="btn btn-primary" type="button">
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
							</div>
						</form>
					</div></li>

				<!-- Nav Item - Alerts -->
				<li class="nav-item dropdown no-arrow mx-1"><a
					class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
						<span class="badge badge-danger badge-counter">3+</span>
				</a> <!-- Dropdown - Alerts -->
					<div
						class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="alertsDropdown">
						<h6 class="dropdown-header">Alerts Center</h6>
						<a class="dropdown-item d-flex align-items-center" href="#">
							<div class="mr-3">
								<div class="icon-circle bg-primary">
									<i class="fas fa-file-alt text-white"></i>
								</div>
							</div>
							<div>
								<div class="small text-gray-500">December 12, 2019</div>
								<span class="font-weight-bold">A new monthly report is
									ready to download!</span>
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="mr-3">
								<div class="icon-circle bg-success">
									<i class="fas fa-donate text-white"></i>
								</div>
							</div>
							<div>
								<div class="small text-gray-500">December 7, 2019</div>
								$290.29 has been deposited into your account!
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="mr-3">
								<div class="icon-circle bg-warning">
									<i class="fas fa-exclamation-triangle text-white"></i>
								</div>
							</div>
							<div>
								<div class="small text-gray-500">December 2, 2019</div>
								Spending Alert: We've noticed unusually high spending for your
								account.
							</div>
						</a> <a class="dropdown-item text-center small text-gray-500" href="#">Show
							All Alerts</a>
					</div></li>

				<!-- Nav Item - Messages -->
				<li class="nav-item dropdown no-arrow mx-1"><a
					class="nav-link dropdown-toggle" href="/admin/qna"
					id="messagesDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> <i
						class="fas fa-envelope fa-fw"></i> <!-- Counter - Messages --> <span
						class="badge badge-danger badge-counter">
							<!-- Qna에 답변완료 없는 글 갯수 -->100
					</span>
				</a> <!-- Dropdown - Messages -->
					<div
						class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="messagesDropdown">
						<h6 class="dropdown-header">Message Center</h6>
						<a class="dropdown-item d-flex align-items-center" href="#">
							<div class="dropdown-list-image mr-3">
								<div class="status-indicator bg-success"></div>
							</div>
							<div class="font-weight-bold">
								<div class="text-truncate">Hi there! I am wondering if you
									can help me with a problem I've been having.</div>
								<div class="small text-gray-500">Qna 게시물 올린 회원 이름</div>
							</div>
						</a> <a class="dropdown-item d-flex align-items-center" href="#">
							<div class="dropdown-list-image mr-3">
								<img class="rounded-circle"
									src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="...">
								<div class="status-indicator bg-success"></div>
							</div>
							<div>
								<div class="text-truncate">Am I a good boy? The reason I
									ask is because someone told me that people say this to all
									dogs, even if they aren't good...</div>
								<div class="small text-gray-500">Chicken the Dog · 2w</div>
							</div>
						</a> <a class="dropdown-item text-center small text-gray-500" href="#">답변하러 가기</a>
					</div></li>

				<div class="topbar-divider d-none d-sm-block"></div>

				<!-- Nav Item - User Information -->
				<li class="nav-item dropdown no-arrow"><a
					class="nav-link dropdown-toggle" href="#" id="userDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span
						class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas
							McGee</span> <img class="img-profile rounded-circle"
						src="/resources/img/undraw_profile.svg">
				</a> <!-- Dropdown - User Information -->
					<div
						class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="userDropdown">
						<a class="dropdown-item" href="#"> <i
							class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
						</a> <a class="dropdown-item" href="#"> <i
							class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings
						</a> <a class="dropdown-item" href="#"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
							Log
						</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#logoutModal"> <i
							class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
							Logout
						</a>
					</div></li>

			</ul>

		</nav>
		<!-- End of Topbar -->