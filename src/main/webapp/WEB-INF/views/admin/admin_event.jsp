<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.gogidang.domain.*"%>

<%@include file="../includes/header_simple.jsp"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal_event.css"
	type="text/css">
	
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/store_reviewStyle.css"
	type="text/css">
<script src = "${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
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
					<h2>이벤트 관리</h2>
				</div>
				<div class="container">
					<table class="table table-hover">
						<thead>
							<tr align=center>
								<th>번호</th>
								<th>사진</th>
								<th>내용</th>
								<th>등록일</th>
								<th><button id="write" class="btn btn-primary btn-xs pull-right" style="background: #7fad39; color:white; border: 1px solid #7fad39; margin-top: 0px; padding-top: 0px;padding-bottom: 0px">작성</button></th>
							</tr>
						</thead>
						<tbody id="event_content" class="text-center">
							
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
		<form name="eventInsertForm">
			
			<h3>이벤트 작성</h3>
			<ol>
				<div class="modal-textbox-e">
					
				  	<div class="modal-textbox-ev-s">
				    	<ts for="title">제목</ts>
					    <td><input type="text" id="title" name="title"></td>
				  	</div>
				</div>
				<div class="modal-textbox-ev">
				  	<div class="modal-textbox-ev-s">
				    	<ts for="content">이벤트내용</ts>
				    	<td><textarea id="content" name="content" type="text"></textarea>
				    	</td>
				  	</div>	  	
			  	</div>
			  	
				<div class="modal-imgbox">
				   	 <div class="modal-imgbox-ss">
				    	<ts for="photo">메인사진등록</ts>
				    	<!-- <td><input type="text" id="thumbnail" name="thumbnail"></td> -->	    	
			    		<td><img src="resources/img/store/" id="photo" name="photo" width="520px" height="300px" /></td>
				     </div>
			    
			   	 	<div class="modal-imgbox-ss">
			    		<ts for="thumbnail">썸네일등록</ts>
				    	<td><img src="" id="thumbnail1" name="thumbnail1" width="520px" height="300px" /></td>
				    	<td><input id="thumbnail" name="file" type="file" multiple="multiple"/></td>
			     	</div>

			     </div>
			     
				
				
			</ol>
			
			<div class="form-checkkkk">
                 <button type="button"   id="eventInsertBtn" name="eventInsertBtn" class="btn btn-lg btn-block btn-success" >등록</button>
                 <!-- <button type="button" id="closeBtn"  class="btn-j btn-lg btn-block btn-success" >닫기</button> -->
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
	
	eventList();
});

$('[name=eventInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 속성이름 [] 으로 접근 가능
    var insertData = $('[name=eventInsertForm]').serialize(); //noticeInsertForm의 내용을 가져옴
    alert("insertData = " + insertData);
    eventInsert(insertData); //Insert 함수호출(아래)
});
	
function eventInsert(insertData) {
	$.ajax({
		url : 'eventwriteAjax.re',
		type : 'POST',
		data : insertData,
		success : function(data) {
			if (data == "OK") {
				alert("등록!");
				modal.style.display = "none";
				eventList();
			} else {
				alert("event delete Fail!!!!");
			}
		}
	});
}

function eventList(){
	  $.ajax({
	     url : 'eventListAjax.re',
	     contentType : 'application/x-www-form-urlencoded; charset=utf-8',
	     success : function(data){ 
	        var a ='';
	        $.each(data, function(key,value){
	      		a += '<tr align=center><td>'+ value.event_num + '</td>';
	      		a += '<td>' + value.photo + '</td>';
	      		a += '<td>' + value.content + '</td>';
	      		a += '<td>' + value.re_date + '</td>';
	      		a += '<td><button onclick="deleteBtn(' + value.event_num + ');" id="myBtn" class="btn btn-primary btn-xs pull-right" style="background: white; color:red; border: 1px solid red;margin-top:0px; padding-bottom:0px;padding-top:0px;">삭제</button></td></tr>';
	        });
	        
	        $("#event_content").html(a); //a내용을 html에 형식으로 .commentList로 넣음
	     },
	     error:function(){
	        alert("ajax통신 실패(list)!!!");
	     }
	  });
	}

function deleteBtn(event) {
	$.ajax({
		url : 'eventDelete.re',
		type : 'POST',
		data : {'event_num' : event},
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(data) {
			if (data == "OK") {
				alert("삭제!");
				eventList();
			} else {
				alert("event delete Fail!!!!");
			}
		}
	});
}
	
$("#thumbnail").change(function() {
	var reader = new FileReader;
	reader.onload = function(data) {
		$("#thumbnail1").attr("src", data.target.result).width(500);
	}
	reader.readAsDataURL(this.files[0]);
});


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