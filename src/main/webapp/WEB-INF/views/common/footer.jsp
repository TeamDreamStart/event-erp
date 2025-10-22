<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<footer id="footer" class="container" role="contentinfo">
  <address class="footer_addr">
    <span>경기 수원시 팔달구 덕영대로 895번길 11</span> 
    <span>
      <a href="tel:0314204204" aria-label="대표전화 031-420-4204">
        대표전화. 031-420-4204
      </a>
    </span>
  </address>
  <hr>
  <small class="footer_copy">
    &copy; <fmt:formatDate value="${now}" pattern="yyyy"/> DreamStart. All rights reserved.
  </small>
</footer>
<div class="footer-gap" aria-hidden="true"></div>
