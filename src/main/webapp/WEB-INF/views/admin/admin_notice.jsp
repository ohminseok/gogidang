<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.gogidang.domain.*"%>

<%@include file="../includes/header_simple.jsp"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal_small.css"
	type="text/css">
	
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/store_reviewStyle.css"
	type="text/css">

<!-- Product Section Begin -->
<section class="product spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-3" id="nav-bar">
	            <div class="hero__categories">
	                  <div class="hero__categories__all">
	                  <span>마이페이지</span>
	              	 </div>
						<ul>
							<li><a href="storeWait.st">대기중인 가게 승인</a></li>
							<li><a href="noticeAdmin.no">공지사항 관리</a></li>
							<li><a href="qnaAdmin.qn">문의 관리</a></li>
							<li><a href="eventAdmin.ev">이벤트 관리</a></li>
						</ul>
					</div>
				</div>
			<div class="col-lg-9">
				<div class="section-title product__discount__title">
					<h2>공지사항 관리</h2>
				</div>
				<div class="container">
					<table class="table table-hover">
						<thead>
							<tr align=center>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th align="center"><button id="write" class="btn btn-primary btn-xs pull-right" style="background: #7fad39; color:white; border: 1px solid #7fad39; margin-top: 0px; padding-top: 0px;padding-bottom: 0px">작성</button></th>
							</tr>
						</thead>
						<tbody id="notice_content" class="text-center">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- The Modal -->
<div id="myModal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
		<span class="close">&times;</span>                                                               
		<form name="noticeInsertForm">
			
			<h3>공지사항 작성</h3>
			<ol>
				<div class="modal-textbox">
				  	<div class="modal-textbox-s">
				    	<ts for="title">제목</ts>
				    	<td><input type="text" id="title" name="title"></td>
				    </div>
			    </div>
			    
			    <div class="modal-textbox">
				  	<div class="modal-textbox-ss"> 
				    	<ts for="content">공지내용</ts>
				    	<td><textarea id="content" name="content"></textarea></td>
				    </div>
			    </div>
			</ol>
			

			<div class="form-checkkkk">
				
			  	<button type="button" id="noticeInsertBtn" name="noticeInsertBtn" class="btn btn-lg btn-block btn-success">작성</button>	  	
			  	<br>
			</div>
			
		</form>
	</div>
</div>
<!-- modal END -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script>

// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById('write');

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];  

$(document).ready(function() {
	
	btn.onclick = function(event) {
	    modal.style.display = "block";
	}
	
	noticeList();
});



$('[name=noticeInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 속성이름 [] 으로 접근 가능
    var insertData = $('[name=noticeInsertForm]').serialize(); //noticeInsertForm의 내용을 가져옴
    alert("insertData = " + insertData);
    noticeInsert(insertData); //Insert 함수호출(아래)
});
	
function noticeInsert(insertData) {
	$.ajax({
		url : 'noticewriteAjax.re',
		type : 'POST',
		data : insertData,
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(data) {
			if (data == "OK") {
				alert("등록!");
				modal.style.display = "none";
				noticeList();
			} else {
				alert("notice insert Fail!!!!");
			}
		}
	});
}

function noticeList(){
	  $.ajax({
	     url : 'noticeListAjax.re',
	     contentType : 'application/x-www-form-urlencoded; charset=utf-8',
	     success : function(data){ 
	        var a ='';
	        $.each(data, function(key,value){
	      		a += '<tr align=center><td>'+ value.notice_num + '</td>';
	      		a += '<td>' + value.title + '</td>';
	      		a += '<td>' + value.u_id + '</td>';
	      		a += '<td>' + value.re_date + '</td>';
	      		a += '<td><button onclick="deleteBtn(' + value.notice_num + ');" id="myBtn" class="btn btn-primary btn-xs pull-right" style="background: white; color:red; border: 1px solid red;margin-top:0px; padding-top:0px; padding-bottom:0px;">삭제</button></td></tr>';
	        });
	        
	        $("#notice_content").html(a); //a내용을 html에 형식으로 .commentList로 넣음
	     },
	     error:function(){
	        alert("ajax통신 실패(list)!!!");
	     }
	  });
	}

function deleteBtn(event) {
	$.ajax({
		url : 'noticeDelete.re',
		type : 'POST',
		data : {'notice_num' : event},
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(data) {
			if (data == "OK") {
				alert("삭제!");
				noticeList();
			} else {
				alert("notice insert Fail!!!!");
			}
		}
	})
}
	


// When the user clicks on <span> (x), close the modal
span.onclick = function(event) {
	modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
}
</script>

<%@include file="../includes/footer.jsp"%>