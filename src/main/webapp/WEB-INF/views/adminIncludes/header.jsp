<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- ============================= -->
<!-- Page Wrapper -->
<!-- ============================= -->
<div id="wrapper">

  <!-- ============================= -->
  <!-- Sidebar -->
  <!-- ============================= -->
  <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/admin">
      <div class="sidebar-brand-icon">
        <figure>
          <img style="width: 100px" src="/resources/img/ds_logo.png" alt="로고이미지">
        </figure>
      </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Dashboard -->
    <li class="nav-item active">
      <a class="nav-link" href="/admin">
        <i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span>
      </a>
    </li>

    <hr class="sidebar-divider">
    <div class="sidebar-heading">MANAGE</div>

    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <c:set var="uri" value="${pageContext.request.requestURI}" />

    <%-- ===== Event Manage ===== --%>
    <c:set var="isEvent" value="${fn:startsWith(uri, ctx.concat('/admin/events'))}" />
    <li class="nav-item ${isEvent ? 'active' : ''}">
      <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEvent"
         aria-expanded="${isEvent ? 'true' : 'false'}" aria-controls="collapseEvent">
        <i class="fas fa-fw fa-calendar-alt"></i> <span>Event Manage</span>
      </a>
      <div id="collapseEvent" class="collapse ${isEvent ? 'show' : ''}" aria-labelledby="headingEvent" data-parent="#accordionSidebar">
        <div class="bg-white py-2 collapse-inner rounded">
          <h6 class="collapse-header">Events</h6>
          <a class="collapse-item ${uri == ctx.concat('/admin/events') ? 'active' : ''}" href="<c:url value='/admin/events'/>">Event List</a>
          <a class="collapse-item ${uri == ctx.concat('/admin/events/form') ? 'active' : ''}" href="<c:url value='/admin/events/form'/>">Create Event</a>
        </div>
      </div>
    </li>

    <%-- ===== Reservation & Payment ===== --%>
    <li class="nav-item">
      <a class="nav-link" href="/admin/reservation-manage">
        <i class="fas fa-fw fa-table"></i> <span>Reservation Manage</span>
      </a>
    </li>
    <%-- <li class="nav-item">
      <a class="nav-link" href="/admin/payment-manage">
        <i class="fas fa-fw fa-table"></i> <span>Payment Manage</span>
      </a>
    </li> --%>

    <%-- ===== Survey Manage ===== --%>
    <c:set var="isSurvey" value="${fn:startsWith(uri, ctx.concat('/admin/surveys'))}" />
    <li class="nav-item ${isSurvey ? 'active' : ''}">
      <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSurvey"
         aria-expanded="${isSurvey ? 'true' : 'false'}" aria-controls="collapseSurvey">
        <i class="fas fa-fw fa-poll"></i> <span>Survey Manage</span>
      </a>
      <div id="collapseSurvey" class="collapse ${isSurvey ? 'show' : ''}" aria-labelledby="headingSurvey" data-parent="#accordionSidebar">
        <div class="bg-white py-2 collapse-inner rounded">
          <h6 class="collapse-header">Surveys</h6>
          <a class="collapse-item ${uri == ctx.concat('/admin/surveys') ? 'active' : ''}" href="<c:url value='/admin/surveys'/>">Survey List</a>
          <a class="collapse-item ${uri == ctx.concat('/admin/surveys/form') ? 'active' : ''}" href="<c:url value='/admin/surveys/form'/>">Create Survey</a>
        </div>
      </div>
    </li>

    <%-- ===== Board Manage ===== --%>
    <li class="nav-item">
      <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseBoard"
         aria-expanded="false" aria-controls="collapseBoard">
        <i class="fas fa-fw fa-folder"></i> <span>Boards</span>
      </a>
      <div id="collapseBoard" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
        <div class="bg-white py-2 collapse-inner rounded">
          <h6 class="collapse-header">Board Manage</h6>
          <a class="collapse-item" href="/admin/notices">Notices</a>
          <a class="collapse-item" href="/admin/qna">Q&amp;A</a>
        </div>
      </div>
    </li>

    <%-- ===== Customers ===== --%>
    <li class="nav-item">
      <a class="nav-link" href="/admin/customers">
        <i class="fas fa-fw fa-users"></i> <span>Customers</span>
      </a>
    </li>

    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler -->
    <div class="text-center d-none d-md-inline">
      <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
  </ul>

  <!-- ============================= -->
  <!-- Content Wrapper -->
  <!-- ============================= -->
  <div id="content-wrapper" class="d-flex flex-column">

    <!-- Main Content -->
    <div id="content">

      <!-- ============================= -->
      <!-- Topbar (로그인/로그아웃) -->
      <!-- ============================= -->
      <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
          <i class="fa fa-bars"></i>
        </button>

        <ul class="navbar-nav ml-auto">
          <div class="topbar-divider d-none d-sm-block"></div>

          <sec:authorize access="isAuthenticated()">
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                 data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                  <sec:authentication property="principal.name" /> 님
                </span>
                <img class="img-profile rounded-circle" src="/resources/img/undraw_profile.svg" alt="profile">
              </a>
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="/">
                  <i class="fas fa-home fa-sm fa-fw mr-2 text-gray-400"></i> 메인으로
                </a>
                <div class="dropdown-divider"></div>
                <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
                  <sec:csrfInput/>
                  <button type="submit" class="dropdown-item text-danger">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> 로그아웃
                  </button>
                </form>
              </div>
            </li>
          </sec:authorize>

          <sec:authorize access="isAnonymous()">
            <li class="nav-item">
              <a href="/login" class="nav-link">
                <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i> 로그인
              </a>
            </li>
          </sec:authorize>
        </ul>
      </nav>
