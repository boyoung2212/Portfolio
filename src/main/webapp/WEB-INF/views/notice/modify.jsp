<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<%@ include file="../includes/header.jsp" %>
    <link href="/resources/dist/css/upload.css" rel="stylesheet">

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form role="form" action="/notice/modify" method="post">
                            <input type="hidden" name="bno" value='<c:out value="${board.bno}"/>'/>
							<input type="hidden" name="pageNum" value="${cri.pageNum}">
							<input type="hidden" name="amount" value="${cri.amount}">
							<input type="hidden" name="type" value="${cri.type}">
							<input type="hidden" name="keyword" value="${cri.keyword}">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            	<div class="form-group">
                            		<label>title</label><input type="text" value='<c:out value="${board.title}"/>' name="title" class="form-control" required="required">
                            	</div>
                            	<div class="form-group">
                            		<label>content</label><textarea name="content" rows="5" class="form-control" required="required"><c:out value="${board.content}"/></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>writer</label><input type="text" value='<c:out value="${board.writer}"/>' name="writer" class="form-control" readonly="readonly">
                            	</div>
                            	<div class="form-group">
                            		<label>RegDate</label><input type="text" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' name="regdate" class="form-control" readonly="readonly">
                            	</div>
                            	<div class="form-group">
                            		<label>Update Date</label><input type="text" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}"/>' name="updatedate" class="form-control" readonly="readonly">
                            	</div>
<sec:authentication property="principal" var="pinfo"/>
<sec:authorize access="isAuthenticated()">
	<c:if test="${pinfo.username eq board.writer}">                              	
                            	<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                            	<button type="submit" data-oper="remove" class="btn btn-default">Remove</button>
	</c:if>
</sec:authorize>                             	
                            	<button type="submit" data-oper="list" class="btn btn-default">List</button>
                            </form>                         
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
              <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Files
                        </div>
                        <!-- /.panel-heading -->
		                    <div class="panel-body">
		                    	<div class="form-group uploadDiv">
		                    		<input type="file" name="uploadFile" multiple="multiple">
		                    	</div>		
		                   	<div class="uploadResult">
				                   	<ul>
				                   	</ul>
			                   </div>
            			</div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
<script>
$(document).ready(function(){
	var formObj = $("form");
	
	$("button").on("click", function(e){
		
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action", "/notiec/remove");			
		} else if(operation === 'list'){
			
		}else if(operation == 'modify'){
			
			console.log("submit clicked");
			
			var str = "";
			$(".uploadResult ul li").each(function(i,obj){
				
				var jobj =$(obj);
				console.dir(jobj);
				
				str +- "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str +- "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str +- "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str +- "<input type='hidden' name='attachList["+i+"].filType' value='"+jobj.data("type")+"'>";

				
			});
			
			formObj.append(str).submit();
			
			
		}
		
		//console.log(formObj.attr("method"));
		formObj.submit();
		
	});
	
});
</script>

<script>
$(document).ready(function(){
	var formObj = $("form");
	
	$("button").on("click", function(e){
		
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation === 'remove'){
			formObj.attr("action", "/notiec/remove");			
		} else if(operation === 'list'){
			formObj.attr("action","/notice/list");
			formObj.attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			//console.log(pageNumTag);
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		} else if(operation === 'modify'){
			
			if($.trim("$#title").val()==""){
				alert("제목을입력해주세요");
				$("#title");
				return;
			}if($.trim("$#content").val()==""){
				alert("내용을입력해주세요");
				$("#title");
				return;
			}
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				
				//console.dir(jobj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			formObj.append(str);
		}
		//console.log(formObj.attr("method"));
		formObj.submit();
		
	});
	
});


$(document).ready(function(){
	(function(){
		var bno = "<c:out value="${board.bno}"/>";
		
		$.getJSON("/notice/getAttachList",{bno:bno}, function(arr){
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach) {		
				//파일이면
				if(!attach.fileType){
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
					
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>" + attach.fileName + "</span><br/>";
					str += "<button type='button' data-file='"+fileCallPath+"' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.jpg'>"
					str += "</div></li>";
				} else {
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>" + attach.fileName + "</span>";
					str += "<button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+ fileCallPath + "'>"
					str += "</div></li>";
				}
			});
			$(".uploadResult ul").append(str);
		});
	})();
	
	
	$(".uploadResult").on("click", "button", function(e){
		console.log($(this));
		if(confirm("Remove this file?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;//1024*1024*5

	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
				
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url:"/uploadAjaxAction",
			processData:false,
			contentType:false,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:formData,
			type:"POST",
			dataType:"json",
			success:function(result){
				console.log(result);
				
				//$(".uploadDiv").html(cloneObj.html());
				
				showUploadResult(result);
			}
		});
	});//$("input[type='file']").change(function(e){
		
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj) {		
			
			if(!obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span>" + obj.fileName + "</span>";
				str += "<button type='button' data-file='"+fileCallPath+"' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.jpg'>"
				str += "</div></li>";
			} else {
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span>" + obj.fileName + "</span>";
				str += "<button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+ fileCallPath + "'>"
				str += "</div></li>";
			}
		});
		
		
		uploadUL.append(str);
		
	}
	
	
});
</script>                
            
<%@ include file="../includes/footer.jsp" %>
    