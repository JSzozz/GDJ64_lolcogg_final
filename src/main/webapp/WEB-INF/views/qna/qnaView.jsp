<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/top.jsp"/>
<!-- Your own style tag or CSS file -->
<link rel="stylesheet" href="${path }/resources/css/qna/insertQna.css">
<!------------------------------------>
<title>QnA</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="navBgColor" value="nav-black"/>
</jsp:include>
    <section>
        <div class="center-1280 background-img mainpage mainHeight">
            <div class="width-1280 page-margin">
                <div>
                    <p class="subTitle fs-20">Q&A</p>
                    <p class="mainTitle fs-35 mainTitleMargin">문의하기</p>
                </div>
                <hr class="hr-3">
                <c:if test="${qb != null || qb != '' }">
                    <div class="tableTitle">
                        <div class="insertqna">
                            <p class="color-white content fs-20 tableTitle">제목</p>
                            <div class="qnaViewInput">
                                <p class="color-white content fs-20 tableTitle">${qb.qaTitle }</p>
                                <p class="color-white content fs-20 tableTitle">${qb.qaDate }</p>
                            </div>
                        </div>
                        <hr class="hr-1">
                        <div class="insertqna">
                            <p class="color-white content fs-20 tableTitle">작성자</p>
                            <div class="qnaViewInput">
                                <p class="color-white content fs-20 tableTitle">${qb.qaWriter.email == null ? "탈퇴한 회원" : qb.qaWriter.nickname }</p>
                            </div>
                        </div>
                        <hr class="hr-1">
                        <div class="insertqna">
                            <p class="color-white content fs-20 tableTitle">문의내용</p>
                            <div class="qnaViewContent">
                                <p class="color-white content fs-20 tableTitle preText">${qb.qaContent }</p>
                                <c:forEach var="f" items="${qb.qaFile }">
                                	<c:if test="${f.qaOriFilename != null }">
	                                    <img src="${path }/resources/upload/qna/${f.qaRnmFilename}" width="500px"><br>
	                                </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        <hr class="hr-1">
                        <div class="insertqna">
                            <p class="color-white content fs-20 tableTitle">첨부파일</p>
                            <div class="qnaViewInput">
                                <div>
                                <c:forEach var="f" items="${qb.qaFile }">
                                	<c:if test="${f.qaOriFilename != null }">
	                                    <p class="color-white content fs-20 tableTitle">${f.qaOriFilename }</p>
	                                </c:if>
	                                <c:if test="${f.qaOriFilename == null }">
	                                	<p class="color-white content fs-20 tableTitle">첨부파일 없음</p>
	                                </c:if>
                                </c:forEach>
                                </div>
                            </div>

                        </div>
                    </div>
                  </c:if>
                    <hr class="hr-3">
                    <div class="insertBtnDiv">
                    <%-- <c:if test="${loginMember.email.equals(qb.qaWriter.email) }"> --%>
                        <button id="updateQna" type="submit" class="insertBtn insertBtnOk content">수정</button>
                        <button id="deleteQna" type="reset" class="insertBtn insertBtnNo content">삭제</button>
					<%-- </c:if> --%>
                    </div>

                <!-- 댓글 -->
                <div class="qnaCommentDiv">
                    <div class="qnaCommentDivSize">
                        <p class="title qnaCommentTitle fs-20">댓글</p>
                        <!-- 댓글 작성 -->
                        <form id="commentForm" method="post" onsubmit="return fn_insertComment();">
                            <div class="insertCommentDiv">
                                <textarea type="text" class="insertComment content fs-20"
                                    style="resize: none;"></textarea>
                                <div class="countBtnDiv">
                                    <div class="countBtn">
                                        <span id="letterSpan" class="content fs-20">0/150</span>
                                    </div>
                                    <div class="iconBtn">
                                        <ion-icon name="happy-outline"></ion-icon>
                                        <button class="commentBtn content">등록</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- 댓글 목록 -->
                        <div class="qnaCommentListDiv">
                            <hr class="hr-1 hr-op">
		                    <c:if test="${not empty qbc }">
		                    	<c:forEach var="c" items="${qbc }">
		                    <div class="commentListDiv">
		                    	<div class="commentList">
                                <div class="">
                                    <img src="${path}/resources/upload/profile/${c.qaCommentWriter.profile}"
                                        style="width: 70px; height: 70px; border-radius: 70px; border:1px solid var(--lol-white)">
                                </div>

                                <div class="commentDetail">
                                    <div class="commentInfo">
                                        <p class="content fs-20 nickname">${c.qaCommentWriter.nickname}</p>
                                    </div>
                                    <div>
                                        <p class="content fs-20 commentContent">${c.qaCommentContent}</p>
                                        <span class="dateSpan content">${c.qaCommentDate}</span>
                                    </div>
                                </div>

                                <div class="optionDiv">
                                    <button class="moreIconBtn">
                                        <ion-icon class="moreIcon" name="ellipsis-horizontal"
                                            style="font-size: 28px;"></ion-icon>
                                    </button>
                                    <ul id="${c.qaCommentNo }" class="optionUl">
                                        <li>
                                       		 <label class="cUpBtn">
                                            <button><ion-icon class="optionIcon"
                                                    name="create-outline"></ion-icon>수정</button>
                                                    </label>
                                         <hr class="hr-op">
                                         <label class="cDelBtn">
                                            <button><ion-icon class="optionIcon"
                                                    name="trash-bin-outline"></ion-icon>삭제</button>
                                         </label>          
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <hr class="hr-1 hr-op">
                                </c:forEach>
                               </c:if>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<script src="${path}/resources/js/script_common.js"></script>
<!-- Your own script tag or JavaScript file -->
 <!-- icon -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script>
/* 댓글 글자 수 제한 */
$(".insertComment").keyup(e=>{
	let content = $(e.target).val();
    
    // 글자수 세기
    if (content.length == 0 || content == '') {
    	$('#letterSpan').text('0/150');
    } else {
    	$('#letterSpan').text(content.length + '/150');
    }
    
    // 글자수 제한
    if (content.length > 150) {
        $(e.target).val($(e.target).val().substring(0, 150));
        alert('댓글은 150자 이하로 작성해주세요.');
    };
});

/* 댓글 권한 */
$(".insertComment").focus(e=>{
	if('${loginMember.authority}' != '관리자'){
		alert("문의하기 댓글은 관리자만 작성할 수 있습니다.");
		$(".insertComment").blur();
	}
});

/* 댓글 등록 ajax */
const fn_insertComment=()=>{
	const auth = '${loginMember.authority}'; // 로그인 회원 권한
	const qaNo = '${qb.qaNo}'; // 문의글 번호
	
    if (auth != '관리자') {
      alert( '문의하기 댓글은 관리자만 작성할 수 있습니다.' );
      return false;
    } else {
    	const writer = '${loginMember.email}';
    	const content = $(".insertComment").val();
    	
    	$.ajax({
    		type: "POST",
    		url: "/qna/insertComment",
    		data:{
    			"qaCommentWriter": writer,
    			"qaCommentContent": content,
    			"qaNo": qaNo
    		},
    		dataType: "json",
    		success : function(data){
    			const commentList = $(".commentListDiv");
    			commentList.html('');
    			$("#letterSpan").text('0/150');
    			let html = '';
    			data.forEach(function(item) {
    				html += "<div class='commentList'>";
    				html += "<div class='profileImg'>";
    				html += "<img src='" + "${path}/resources/upload/profile/" + item.qaCommentWriter.profile
    						+ "' style='width: 70px; height: 70px; border-radius: 70px; border: 1px solid var(--lol-white);'>";
    				html += "</div>";
    				
    				html += "<div class='commentDetail'>";
    				html += "<div class='commentInfo'>";
    				html += "<p class='content fs-20 nickname'>";
    				html += (item.qaCommentWriter.nickname != null) ? item.qaCommentWriter.nickname : "탈퇴한 회원";
    				html += "</p>";
    				html += "</div>";
    				html += "<div>";
    				html += "<p class='content commentContent'>" + item.qaCommentContent + "</p>";
                    html += "<span class='dateSpan content'>" + item.qaCommentDate + "</span>";
                    html += "</div></div>";
                    
    				html += "<div class='optionDiv'>";
    				html += "<button class='moreIconBtn'>";
    				html += "<ion-icon class='moreIcon' name='ellipsis-horizontal' style='font-size: 28px;'></ion-icon>";
    				html += "</button>";
    				
    				html += "<ul id='${c.qaCommentNo }' class='optionUl'><li>";
    				html += "<label class='cUpBtn'><button id='${c.qaCommentNo}' class='cUpBtn'><ion-icon class='optionIcon' name='create-outline'></ion-icon>수정</button></label>";
    				html += "<hr class='hr-op'>";
    				html += "<label class='cDelBtn'><button id='${c.qaCommentNo}' class='cDelBtn'><ion-icon class='optionIcon cDelBtn' name='trash-bin-outline'></ion-icon>삭제</button></label>";
    				html += "</li></ul></div></div>";
    				html += "<hr class='hr-1 hr-op'>";
    			});
    			commentList.append(html);
    			$(".insertComment").val('');
    		},
    		error: function(err){
    			console.log("요청 실패", err);
    		}
    	});
    	return false;
    }
}

/* 문의글 삭제 */
$("#deleteQna").click(e=>{
	if(confirm("정말 삭제하시겠습니까?")) { 
		location.replace('${path}/qna/deleteQna?no=${qb.qaNo}');
	}
})

/* 댓글 - 수정, 삭제 버튼 토글 */
/* 동적 태그에 이벤트 위임해줘야 함 */
$(document).on("click", ".moreIconBtn", function(e) {
    const optionUl = $(e.target).closest(".optionDiv").find(".optionUl");
    optionUl.toggle();
});

/* 댓글 수정 */
$(document).on("click", ".cUpBtn", function(e) {
	const qaNo = $(e.target).attr('id');
	console.log($(e.target).closest("ul").attr('id'));
});












// 페이지 로딩 시 댓글 조회
/* window.onload = () => {
    findAllComment();
} */

// 전체 댓글 조회
/* function findAllComment() {
	
	$.ajax({
	    url : '${path}/qna/qnaView?no=${qb.qaNo}',
	    type : 'get',
	    async : false,
	    success : (data)=> {
	        console.log(data.length);
	    },
	    error : function (request, status, error) {
	        console.log("에러났다!");
	    }
	}) 
	
	    window.onload = () => {
        findAllComment();
    } 
} */


</script>
<!-------------------------------------------->
</body>
</html>
