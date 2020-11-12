<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Member Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Member Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form id="operform" role="form" action="/member/register" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            	<div class="form-group">
                            		<label>Userid</label><input type="text" name="userid" class="form-control" required="required">
                            	</div>
                            	<div class="form-group">
                            		<label>Userpw</label><input type="password" name="userpw" class="form-control" required="required">
                            	</div>
                            	<div class="form-group">
                            		<label>Userpw 확인</label><input type="password" name="userpw2" class="form-control" required="required">
                            	</div>
                            	<div class="form-group">
                            		<label>UserName</label><input type="text" name="userName" class="form-control" required="required">
                            	</div>
                            	<div class="form-group">
                            		<label>Auth</label>
                            		<SELECT name="auth" class="form-control">
                            		<option value="ROLE_USER">ROLE_USER</option>
                            		<option value="ROLE_MEMBER">ROLE_MEMBER</option>
                            		<option value="ROLE_ADMIN">ROLE_ADMIN</option>
                            		</SELECT>
                            	</div>
                            	<button type="submit" data-oper="register" class="btn btn-default">Submit Button</button>
                            	<button type="reset" class="btn btn-default">Reset Button</button>
                            </form>                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
<script>
$(document).ready(function(){
	var operForm = $("#operform");
	
	$("button[data-oper='register']").on("click", function(e){
		e.preventDefault();

		var userid = $("input[name='userid']").val();
		var userpw = $("input[name='userpw']").val();
		var userpw2 = $("input[name='userpw2']").val();
		var userName = $("input[name='userName']").val();
				
		if(userid.length == 0){
			alert("Userid를 입력해 주세요.");	
			$("input[name='userid']").focus();
			return;
		}
		
		if(userpw.length < 4){
			alert("비밀번호의 글자수를 4글자이상 입력해 주세요.");	
			return;
		}
		
		if(userpw != userpw2){
			alert("비밀번호가 일치하지 않습니다.");
			return ;
		}
		
		operForm.submit();
	});
	
});
</script>            
            
<%@ include file="../includes/footer.jsp" %>
    