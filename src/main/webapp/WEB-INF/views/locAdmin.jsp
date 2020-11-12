<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board List Page
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        전체게시물수 : ${total}
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="col-md-1">날짜</th>
                                        <th class="col-md-3">경도</th>
                                        <th class="col-md-1">위도</th>
                                        <th class="col-md-2">ip</th>
                                        <th class="col-md-2">지도</th>
                                   
                                    </tr>
                                    <c:forEach items="${list}" var="myloc">                                
                                    <tr class="odd gradeX">
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${myloc.inputDate}"/></td>                                        
                                        <td><c:out value="${myloc.lng}"/></td>
                                        <td><c:out value="${myloc.lat}"/></td>
                                        <td><c:out value="${myloc.ip}"/></td>
                                        <td><a href="https://www.google.com/maps/dir/${myloc.lat},${myloc.lng}/@${myloc.lat},${myloc.lng}/" target="_blank" >지도</a></td>
                                    </tr>
									</c:forEach>      
                                     
                                </thead>
                                <tbody>
            						
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            
                           
                            
                            
                            
                     
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            



 


<%@ include file="includes/footer.jsp" %>