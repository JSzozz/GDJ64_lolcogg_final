<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/top.jsp"/>
<!-- Your own style tag or CSS file -->
<link rel="stylesheet" href="${path}/resources/css/common.css">
<link rel="stylesheet" href="${path}/resources/css/member/member.css">
<!------------------------------------>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<title>로그인</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="navsBgColor" value="nav-black"/>
</jsp:include>
    <section>
        <div class="center-1280 background-img mainpage mainHeight">
            <div class="width-1280 page-margin">
                <!--------------------------------- Code below --------------------------------->
                <!-- 작업영역 -->
                <p class="loginTitle color-white ff-macho fs-30 ">로그인</p>
                <form action="${path }/member/loginCheck" method="post" onsubmit="return frm_check();" >
                    <div class="loginBox">
                        <input type="text" id="logId" class =" ff-suit" placeholder="이메일" name="email">
                        <input type="password" class ="ff-suit" placeholder="비밀번호" name="password">
                    </div>
                    <div class="autoLoginBox">
						<input id="saveId" type="checkbox" value="">
						<p class="fs-15 ff-suit color-white">
						    <label for="saveId">아이디 저장</label>
						</p>
                    </div>
                    <div class="loginButton">
                        <input type="submit" class ="ff-suit fw-bold" value="로그인">
                    </div>
                </form>
                <div class="memberCheckBox">
                    <a href="${path }/member/enrollMember.do" class="ff-suit">회원가입</a>
                    <p class="color-white">&nbsp;&nbsp;|&nbsp;&nbsp;</p>
					<p class="color-white ff-suit" id="passwordSearchModalButton" style="cursor: pointer;">비밀번호 찾기</p>
                </div>
                <div class="socialLoginBox">
                    <img src="${path}/resources/images/member/naver_logo_icon.png" onclick="naverLogin();"  > <!-- REST API -->
                    <div></div>
                    <img src="${path}/resources/images/member/kakaotalk_logo_icon.png" onclick="return kakaologin();"> <!-- JAVASCRIPT -->
                    <div></div>
                </div>
        		<!------------------------------------------------------------------------------>
            </div>
        </div>
    </section>
    <!-- 비밀번호 변경 모달 -->
<div class="modal-background" id="passwordCheckModalBackground">
    <div class="modal" id="passwordModal">
        <div class="modal-header">
            <h5 class="ff-suit fs-20 fw-bold">비밀번호 찾기</h5>
        </div>
        <div class="modal-body">
        	<br>
        	<!-- step 1 : 이메일 확인 -->
			<label for="inputEamil">이메일:</label>
			<input type="email" id="inputEamil" name="inputEamil" placeholder="이메일 입력" required>
			<button type="button" class="btn duplicationCheck ff-suit fs-15" id="passwordModalConfirmButton">이메일 조회</button>
            <h5 class="ff-suit ff-20" style="color : red ; display:none" id="passwordCheck"></h5>
            
            <!-- step 2 : 인증번호 확인 -->
            <label for="inputCertification" style = "display : none;">인증번호:</label>
			<input type="text" id="inputCertification" name="inputCertification" placeholder="인증번호 입력" style = "display : none;" required>
			<button type="button" class="btn duplicationCheck ff-suit " id="certificationModalConfirmButton" style = "display : none;">인증번호 전송</button>
            <h5 class="ff-suit ff-20 color-white" style="display:none;" id="certificationCheck">'인증번호 전송' 클릭 시 메일이 발송됩니다.</h5>
            
            <!-- step 3 : 비밀번호 변경 -->
            <label for="newPassword" style = "display : none;">새 비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="영문, 숫자, 특수문자 포함 8자" style = "display : none;" required ><br>
            <label for="confirmNewPassword" style = "display : none;">비밀번호 확인&nbsp;</label>
            <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="영문, 숫자, 특수문자 포함 8자" style = "display : none;" required >
            <h5 class="ff-suit ff-20" style="color : red ;  display:none;" id="passwordCheck2"></h5>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn duplicationCheck ff-suit fs-15" id="passwordModalConfirmButton3" style = "display : none;">확인</button>
            <button type="button" class="btn duplicationCheck ff-suit fs-15" id="passwordModalConfirmButton2" style = "display : none;">변경</button>
            <button type="button" class="btn duplicationCheck ff-suit fs-15" id="closeModalButton2">닫기</button>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
<script src="${path}/resources/js/script_common.js"></script>
<!-- Your own script tag or JavaScript file -->
<script src="${path}/resources/js/member/login.js"></script>
<!-------------------------------------------->
</body>
</html>