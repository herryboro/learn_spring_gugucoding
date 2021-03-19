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

<div class='row'>
  <div class="col-lg-12">

    <!-- /.panel -->
    <div class="panel panel-default">
    	<!--  
    	<div class="panel-heading">
       		<i class="fa fa-comments fa-fw"></i> Reply
      	</div>-->      
      	<div class="panel-heading">
	        <i class="fa fa-comments fa-fw"></i> Reply
	        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
      	</div>   
      
      	<!-- /.panel-heading -->
      	<div class="panel-body">              
        	<ul class="chat">
        		<li class="left clearfix" data-rno="12">
        			<div>
        				<div class="header">
        					<strong class="primary-font">user00</strong>
        					<small class="pull-right text-muted">2021-03-19</small>
        				</div>
        				<p>Good job!</p>
        			</div>
        		</li>
        	</ul>
        <!-- ./ end ul -->
      	</div>
      <!-- /.panel .chat-panel -->
		<div class="panel-footer"></div>
	</div>
  </div>
  <!-- ./ end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
        	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              	<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
            	<div class="form-group">
	                <label>Reply</label> 
	                <input class="form-control" name='reply' value='New Reply!!!!'>
           		</div>      
	            <div class="form-group">
		            <label>Replyer</label> 
		            <input class="form-control" name='replyer' value='replyer'>
	            </div>
	            <div class="form-group">
		            <label>Reply Date</label> 
		            <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
	            </div>     
            </div>
			<div class="modal-footer">
		        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
		        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
		        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
		        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
		    </div>          
		</div>
        <!-- /.modal-content -->
     </div>
  	 <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("===============");
		console.log("JS TEST");
		
		let bnoValue = '<c:out value="${board.bno}"/>';
		let replyUL = $(".chat");
		
		showList(1);
		function showList(page) {
			replyService.getList({bno: bnoValue, page: page || 1}, function(list) {
				let str = "";
				if(list == null || list.length == 0) {
					replyUL.html("");
					return;
				}
				
				for (var i = 0, len = list.length || 0; i < len; i++) {
		           str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
		           str +="	<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>"; 
		           str +="    <small class='pull-right text-muted'>"+ replyService.displayTime(list[i].replyDate) + "</small></div>";
		           str +="    <p>"+list[i].reply+"</p></div></li>";
		         }
				
				replyUL.html(str);
			});
		}
		
		let modal = $(".modal");
		let modalInputReply = modal.find("input[name = 'reply']");
		let modalInputReplyer = modal.find("input[name = 'replyer']");
		let modalInputReplyDate = modal.find("input[name = 'replyDate']");
		
		let modalModBtn = $("#modalModBtn");
		let modalRemoveBtn = $("#modalRemoveBtn");
		let modalRegisterBtn = $("#modalRegisterBtn");
		
		$("#addReplyBtn").on("click", function(e) {
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		modalRegisterBtn.on("click", function(e) {
			let reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bnoValue
			};
			replyService.add(reply, function(result) {
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(1);
			});
		});
		
		$(".chat").on("click", "li", function(e) {
			let rno = $(this).data("rno");
			replyService.get(rno, function(reply) {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		modalModBtn.on("click", function(e) {
			let reply = {rno: modal.data("rno"), reply: modalInputReply.val()};
			replyService.update(reply, function(result) {
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		modalRemoveBtn.on("click", function (e){		   	  
			var rno = modal.data("rno");		   	  
		   	replyService.remove(rno, function(result){		   	        
	   	    	alert(result);
	   	      	modal.modal("hide");
	   	      	showList(1);	   	      
	   	  	});	   	  	 
		});
		
		// for replyService add test
		/*
		replyService.add(
			{reply: "JS Test", replyer: "tester", bno: bnoValue},
			function(result) {
				alert("RESULT: " + result);
			}
		); */
		
		/*
		replyService.getList(
			{bno:bnoValue, page:1}, 
			function(list) {		    
				for(var i = 0,  len = list.length||0; i < len; i++ ) {
			    	console.log(list[i]);
				}
			}
		);*/
		
		/*
		replyService.remove(
			14, 
			function(count) {
				console.log(count);
				
				if(count == "success") {
					alert("REMOVED");
				}
			},
			function(err) {
				alert("Error....");
			}
		);*/
		
		/*
		replyService.update(
			{rno: 17, bno: bnoValue, reply: "Modified Reply...."},
			function(result) {
				alert("수정 완료..");
			}
		);*/
		
		/*
		replyService.get(10, function(data){
			console.log(data);      
	    });*/
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