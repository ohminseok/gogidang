<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member_liststoreStyle.css" type="text/css">
<% 
	StoreVO storevo = (StoreVO)session.getAttribute("StoreVO");
	ArrayList<LikeStoreVO>likestore_list = (ArrayList<LikeStoreVO>)request.getAttribute("likestore_list");
%>

    <!--네비게이션바 사용 시작-->
    <%if(memberVO.getSeller_key() == 0){ %>
      <section class="hero">
        <div class="container">
            <div class="hero__item__box2"></div>
                    <div class="EventNav">
                        <ul>
                            <li><a href="./updateList.me">내정보</a></li>
                            <li><a href="./bookingList.bo?u_id=<%=memberVO.getU_id()%>">내예약확인</a>
                            <li><a href="./likeStoreList.li?u_id=<%=memberVO.getU_id()%>">찜목록</a></li>
                            <li><a href="./reviewList.re?u_id=<%=memberVO.getU_id()%>">내가 작성한 후기</a></li>
                            <li><a href="./cartList.ct">장바구니</a></li>
                        </ul>
                    </div>   
            </div>   
        </div>
    </section>
<%
}else{ 
   if(storevo == null || storevo.getConfirm() == 0 || storevo.getS_num() == 0 ){
%>
 <section class="hero">
        <div class="container">
            <div class="hero__item__box2"></div>
                    <div class="EventNav">
                        <ul>
                            <li><a href="./updateList.me">내정보</a></li>
                            <li><a href="./storeRegForm.st">가게 정보</a>
                        </ul>
                    </div>   
            </div>   
        </div>
        </section>  
<%
   }else{
%>
    <section class="hero">
        <div class="container">
            <div class="hero__item__box2"></div>
                    <div class="EventNav">
                        <ul>
                            <li><a href="./updateList.me">내정보</a></li>
                            <li><a href="./storeRegForm.st">가게 정보</a>
                            <li><a href="./menuRegForm.mn">메뉴 정보</a></li>
                            <li><a href="./storeNoticeList.no">문의 관리</a></li>
                            <li><a href="./storereviewList.bo">리뷰 관리</a></li>
                        </ul>
                    </div>   
            </div>   
        </div>
    </section>
<%
   } 
}
%>
<div class="container">
 	<div class="row justify-content-center">
       
           <div class="update">
				<h2 >찜한가게</h2>
				<br><br><br>
				<div class="card_box">
		<% 
					//for(int i=0;i<likestore_list.size();i++){
						//LikeStoreVO likestore=(LikeStoreVO)likestore_list.get(i);
		for(int i=0;i < 7;i++){
						
			if(i % 5 == 0){
		%>	
				<br/><br/><br/>
		<%
			}else{
		%>
				<div id="card">
				<div class="card" style="width: 18rem;">
					<a href="#"><img src="./resources/img/best-re-img5.jpg" class="card-img-top" alt="..."></a>
				    <div class="card-body">
				     <p class="card-text">뚜룹가게</p>
				     <p class="card-text">9:00 ~ 20:00</p>
				     <p class="card-text">010 - 8231 - 9263</p>
				  	</div>
				</div>
				</div>
		<%
			}
		}
		%>
			</div>
		  </div>
	</div>
</div>



<%@include file="../includes/footer.jsp"%>