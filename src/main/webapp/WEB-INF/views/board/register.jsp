<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>
    <!-- Custom CSS -->
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
                            <form role="form" action="/board/register" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            	<div class="form-group">
                            		<label>title</label><input type="text" name="title" id="title" class="form-control" required="required">
                            	</div>
                            	<div class="form-group">
                            		<label>content</label><textarea name="content" id="" rows="5" class="form-control" required="required"></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>writer</label><input type="text" name="writer" class="form-control" value="<sec:authentication property="principal.member.userid"/>" readonly="readonly">
                            	</div>
                            	<button type="submit" class="btn btn-default">Submit Button</button>
                            	<button type="reset" class="btn btn-default">Reset Button</button>
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
                            File Attach
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<div class="form-group uploadDiv">
                        		<input type="file" name="uploadFile" multiple>
                        	</div>
                        	<div class="uploadResult">
                        		<ul></ul>
                        	</div>
                        	
            			</div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
<script>
$(document).ready(function (e){
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		
		//console.log("submit clicked");
		
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

		formObj.append(str).submit();
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
	
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url:"/deleteFile",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:{fileName:targetFile, type:type},
			dataType:"text",
			type:"POST",
			success:function(result){
				alert(result);
				targetLi.remove();
			}
		});
	});	
	
	
});//$(document).ready(function (e){
</script>            
            
<%@ include file="../includes/footer.jsp" %>
    