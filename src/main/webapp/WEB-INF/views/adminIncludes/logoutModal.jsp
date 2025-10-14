<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>

      <div class="modal-body">
        Select "Logout" below if you are ready to end your current session.
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>

        <!-- 기존 <a href="login.html">Logout</a> 를 폼 제출로 교체 -->
        <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
          <input type="hidden" name="from" value="admin"/>
          <sec:csrfInput/>
          <button type="submit" class="btn btn-primary">Logout</button>
        </form>
      </div>
    </div>
  </div>
</div>
