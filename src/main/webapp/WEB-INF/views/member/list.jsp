<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@ include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">회원관리</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Member List Page
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Member</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        전체게시물수 : ${total}
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="col-md-1">#번호</th>
                                        <th class="col-md-5">회원아이디</th>
                                        <th class="col-md-1">회원이름</th>
                                        <th class="col-md-1">사용유무</th>
                                        <th class="col-md-2">가입일</th>
                                        <th class="col-md-2">수정일</th>
                                    </tr>
                                </thead>
                                <tbody>
<c:set var="num" value="${total-((cri.pageNum - 1) * cri.amount)}"/>                                
<c:forEach items="${list}" var="member">                                
                                    <tr class="odd gradeX">
                                        <td><c:out value="${num}"/></td>
                                        <td><a class="move" href="${member.userid}">${member.userid}</a></td>
                                        <td>${member.userName}</td>
                                        <td><c:out value="${member.enabled}"/></td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}"/></td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${member.updateDate}"/></td>
                                    </tr>
<c:set var="num" value="${num-1}"/>                                     
</c:forEach>                                    
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            
                            <div class="row">
	                            <div class="col-lg-12">
	                            
	                            	<form role="form" id="searchForm" action="/member/list" method="get">
		                            	<select name="type">
		                            		<option value="" ${pageMaker.cri.type == null ? "selected":""}>--</option>
		                            		<option value="T" ${pageMaker.cri.type eq "T" ? "selected":""}>제목</option>
		                            		<option value="C" ${pageMaker.cri.type eq "C" ? "selected":""}>내용</option>
		                            		<option value="W" ${pageMaker.cri.type eq "W" ? "selected":""}>작성자</option>
		                            		<option value="TC" ${pageMaker.cri.type eq "TC" ? "selected":""}>제목OR내용</option>
		                            		<option value="TW" ${pageMaker.cri.type eq "TW" ? "selected":""}>제목OR작성자</option>
		                            		<option value="TWC" ${pageMaker.cri.type eq "TWC" ? "selected":""}>제목OR내용OR작성자</option>
		                            	</select>
		                            	<input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
										<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
										<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
										<button class="btn btn-default">Search</button>
	                            	</form>
	                            </div>
                            </div>
                            
                            
                            
                            
							<!-- start Pagination -->
							<div class="pull-right">
								<ul class="pagination">
									<c:if test="${pageMaker.prev}">
									<li class="paginate_button first"><a href="1">처음으로</a>
									</li>
									<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">Previous</a>
									</li>
									</c:if>
									
									<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
										<li class="paginate_button ${pageMaker.cri.pageNum == num?"active":"" } ">
										<a href="${num}">${num}</a>
										</li>
									</c:forEach>							
									
									<c:if test="${pageMaker.next}">
									<li class="paginate_button next"><a href="${pageMaker.endPage + 1}">Next</a>
									</li>
									<li class="paginate_button last"><a href="<fmt:formatNumber pattern="0" value= "${total / pageMaker.cri.amount}" />">끝으로</a>
									</li>
									</c:if>
								</ul>
							</div>
							<!-- end Pagination -->
							<!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->

                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            

<form id="actionForm" action="/member/list" method="get">
<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
<input type="hidden" name="type" value="${pageMaker.cri.type}">
<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>


            
<script>
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	
	if(result === '' || history.state){
		console.log("true:"+result);
	} else {
		if(parseInt(result) > 0){
			$(".modal-body").html("게시글 " + result + " 번이 등록되었습니다.");
		}
		$("#myModal").modal("show");
	}
	
	history.replaceState({},null,null);
	
	$("#regBtn").on("click", function(){
		self.location = "/member/register";
		//location.href="/member/register";
	});
	
	var actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		e.preventDefault();
		
		if("${pageMaker.cri.pageNum}" === $(this).attr("href")) {
			return;
		}
		
		actionForm.append("<input type='hidden' name='userid' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/member/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		//console.log("어디??");
		
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return;
		} 
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		searchForm.submit();
	});
	
	
});
</script>            




<%@ include file="../includes/footer.jsp" %>