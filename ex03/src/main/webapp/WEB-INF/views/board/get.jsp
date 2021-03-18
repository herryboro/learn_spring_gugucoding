<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">Board Read</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
      
      <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno'
          	value='<c:out value="${board.bno}"/>' readonly="readonly">
      </div>
             
      <div class="form-group">
        <label>Title</label> 
        <input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
      </div>

      <div class="form-group">
        <label>Text area</label>
        <textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content}"/></textarea>
      </div>

      <div class="form-group">
        <label>Writer</label> 
        <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
      </div>
     
     <!-- 직접 버튼에 링크를 처리하는 방법
     <button data-oper='modify' class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">
       Modify
     </button>
     <button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">
        List   
     </button>  -->  
     
     <!-- form태그로 처리 -->
     <button data-oper='modify' class="btn btn-default">Modify</button>
     <button data-oper='list' class="btn btn-info">List</button>
     
     <form action="/board/modify" method="get" id="operForm">
     	<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
     	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
     	<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
     	<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
     	<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
     </form>
     </div>
     <!--  end panel-body -->

   </div>
   <!--  end panel-body -->
 </div>
 <!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("===============");
		console.log("JS TEST");
		
		let bnoValue = '<c:out value="${board.bno}"/>';
		
		// for replyService add test
		replyService.add(
			{reply: "JS Test", replyer: "tester", bno: bnoValue},
			function(result) {
				alert("RESULT: " + result);
			}
		)
	});
</script>
<!-- form 태그로 처리시 필요한 script -->
<script type="text/javascript">
	$(document).ready(function() {
		let operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list").submit();
		});
	});
</script>
<%@include file="../includes/footer.jsp"%>
