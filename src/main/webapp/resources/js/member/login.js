/* 아이디 저장 */
	$(function() {
		fnInit();
	});
	
	function frm_check() {
		saveid();
	}
	
	function fnInit() {
		var cookieid = getCookie("saveid");
		/*console.log(cookieid);*/
		if (cookieid != "") {
			$("input:checkbox[id='saveId']").prop("checked", true);
			$('#logId').val(cookieid);
		}
	}
	function setCookie(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setTime(todayDate.getTime() + 0);
		if (todayDate > expiredays) {
			document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expiredays + ";";
		} else if (todayDate < expiredays) {
			todayDate.setDate(todayDate.getDate() + expiredays);
			document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
		}
		/*console.log(document.cookie);*/
	}
	function getCookie(Name) {
		var search = Name + "=";
		/*console.log("search : " + search);*/
	
		if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면 
			offset = document.cookie.indexOf(search);
			/*console.log("offset : " + offset);*/
			if (offset != -1) { // 쿠키가 존재하면 
				offset += search.length;
				// set index of beginning of value
				end = document.cookie.indexOf(";", offset);
				/*console.log("end : " + end);*/
				// 쿠키 값의 마지막 위치 인덱스 번호 설정 
				if (end == -1)
					end = document.cookie.length;
				/*console.log("end위치  : " + end);*/
	
				return unescape(document.cookie.substring(offset, end));
			}
		}
		return "";
	}
	function saveid() {
		var expdate = new Date();
		if ($("#saveId").is(":checked")) {
			expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30);
			setCookie("saveid", $("#logId").val(), expdate);
		} else {
			expdate.setTime(expdate.getTime() - 1000 * 3600 * 24 * 30);
			setCookie("saveid", $("#logId").val(), expdate);
		}
	}

    // 카카오 SDK 초기화
    Kakao.init('5e6bb71a42bd433b177e7105d219f644');
    const kakaologin=()=>{
        /*console.log(Kakao.isInitialized()); */
         let email,nickname,image;
            Kakao.Auth.login({
               scope:'profile_nickname,account_email,profile_image',
               success:function(authObj){
                  /*console.log(authObj);*/
                  Kakao.API.request({
                     url:'/v2/user/me',
                     success:function(res){
                        const kakao_account=res.kakao_account;
                        /*console.log(kakao_account);*/
                        email=kakao_account.email;
                        nickname=kakao_account.profile.nickname;
                        image=kakao_account.profile.thumbnail_image_url;
                        /*console.log(email,nickname,image);*/
                           $.ajax({
                              type:"get",
                              url:"../login/KakaoLoginCheck",
                              data:{"memberEmail":email,"memberNickname":nickname,"memberImage":image},
                              dataType:"text",
                              success: data=>{
                                 /*console.log(data, typeof data);
                                 console.log(data=='')*/
                                    if(data==''){
                                         location.assign("../login/Kakaoenroll?memberEmail="+email+"&memberNickname="+nickname+"&memberImage="+image);
                                    }else{
                                       location.assign("../login/KakaoLogin?memberEmail="+email+"&memberNickname="+nickname+"&memberImage="+image);
                                    }
                                    },
                              error:(r,m,e)=>{
                                       console.log(r);
                                       console.log(m);
                                    }
                           });
                     }
                  });
               }
            });
        }
        
/* 프로필 이미지 변경, 비밀번호 변경, 회원 탈퇴 기능(ajax) */
	setupModal('passwordSearchModalButton', 'passwordCheckModalBackground', 'closeModalButton2', 'passwordModalConfirmButton');
	function setupModal(showButtonId, modalBackgroundId, closeModalButtonId, confirmButtonId) {
	    const showModalButton = document.getElementById(showButtonId);
	    const modalBackground = document.getElementById(modalBackgroundId);
	    const closeModalButton = document.getElementById(closeModalButtonId);
	    const confirmButton = document.getElementById(confirmButtonId);
	    showModalButton.addEventListener('click', () => {
	        modalBackground.style.display = 'flex';
	    });
	    modalBackground.addEventListener('click', (event) => {
	        if (event.target === modalBackground) {
	            modalBackground.style.display = 'none';
	        }
	    });
	    closeModalButton.addEventListener('click', () => {
	        modalBackground.style.display = 'none';
	    });
	    
	    //비밀번호 찾기 step1
	  	var inputEamil=$("#inputEamil");
	  	var encryptionEamil = ""; //암호화 이메일 받는 용도
	    if (confirmButton==document.getElementById('passwordModalConfirmButton')) {
			/* alert 버블링 현상 있습니다. */
			/* 비밀번호 예외처리 - 빈값 */
	    	confirmButton.addEventListener('click', () => {
	    		if(inputEamil.val()==""){
	    			inputEamil.focus();	
	    			document.querySelector("#passwordCheck").style.display = "inline-block";
	    			document.querySelector("#passwordCheck").innerText = "이메일을 입력해주세요.";
	    			return false;
	    		}
				$.ajax({
					type : 'POST',
					url : '${path}/mypage/emailCheck',
					data : {
						"inputEmail" :$("input[name='inputEamil']").val()
					},
					success : function(response){ //컨트롤러에서 넘어온 cnt값을 받는다 
		                if(response.cnt == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
		        			inputEamil.focus();
		        			document.querySelector("#passwordCheck").innerText = "일치하는 이메일이 없습니다";
		        			document.querySelector("#passwordCheck").style.display = "inline-block";
		                } else if(response.cnt == 1){ // cnt가 1일 경우 -> 이미 존재하는 아이디, 비밀번호 일치
		                	document.querySelectorAll("label[for='inputEamil'], input[type='email'][name='inputEamil'], button[id='passwordModalConfirmButton'], h5[id='passwordCheck']")
		                		.forEach(function(element) {
		                	    element.style.display = "none"; 
		                	});
		                	document.querySelectorAll("label[for='inputCertification'], input[type='text'][name='inputCertification'], button[id='certificationModalConfirmButton'], h5[id='certificationCheck']")
		                		.forEach(function(element) {
		                	    element.style.display = "inline-block";
		                	});
		                } else if (response.cnt == -1){
		        			document.querySelector("#passwordCheck").innerText = "소셜로그인(카카오)에 사용된 계정입니다.(*실제 로그인 이메일과 다릅니다) ";
		        			document.querySelector("#passwordCheck").style.display = "inline-block";
		                } else if (response.cnt == -2){
		        			document.querySelector("#passwordCheck").innerText = "소셜로그인(네이버)에 사용된 계정입니다. (*실제 로그인 이메일과 다릅니다)";
		        			document.querySelector("#passwordCheck").style.display = "inline-block";
		                }
		                inputEamil = $("input[name='inputEamil']").val(); // 이메일 원형
		                encryptionEamil = response.email; // 암호화된 이메일로 값 넣기
		             },
					error : function(request, status, error) { 
				        console.log(error)
				    }
				})
			});
	    }
	    
	    //비밀번호 찾기 step2
	  	var inputCertification=$("#inputCertification");
	    /* console.log(inputCertification); */
	  	document.getElementById('certificationModalConfirmButton').addEventListener('click', () => {
			    const user = {
			        username: inputEamil
			    }
			    const url = "api/mailcheck";
	    		fetch(url, {
	    	        method: "POST",
	    	        body: JSON.stringify(user),
	    	        headers: {
	    	            "Content-Type": "application/json"
	    	        }
	    	    })
	    		.then((response) => {
	    		    if (response.status === 500) {
	    	    	    $email.readOnly = false;
	    	    	    $email.value="";
	    	    	    $email.focus();
	    		        throw new Error("이메일을 다시 확인해주세요.");
	    		    }
	    		    return response.json();
	    		})
	    	    .then((json) => {
	    	        if (json !== null) {
	    	        	alert("입력하신 메일에 인증번호가 전송 되었습니다.\n" + inputEamil + "에서 메일을 확인하여 인증번호를 입력해주세요.");
	    	            authNum = json;
	    	            console.log("authNum");
	    	            $("#certificationCheck").text("인증번호를 입력해주세요.");
		    			document.querySelector("#passwordModalConfirmButton3").style.display = "inline-block";
	    	        } else {
	    	            alert("인증메일 전송에 실패 하였습니다.");
	    	        }
	    	    })
	    	    .catch((error) => {
	    	        console.error("Fetch error:", error);
	    	        alert("에러가 발생하였습니다. 이메일을 다시 확인해주세요.");
	    	    });
	    		
	    		// 인증번호 검증 : 빈값, 일치여부
    	    	var inputCertification = $("#inputCertification");
	    	    $("#passwordModalConfirmButton3").click(function() {
	    	        if (inputCertification.val() === "") {
	    	            inputCertification.focus();
	    	            $("#certificationCheck").css("display", "inline-block");
	    	            $("#certificationCheck").text("인증번호를 입력해주세요.");
	    	            return false;
	    	        }
	    	    });
	    	    var authResult = false; //인증번호 확인 변수
	    	    inputCertification.on("input", function() {
	    	        // 인증번호 입력
	    	        var mailCheckInput = $(this).val();
	    	        var mailCheckWarn = $("#certificationCheck");

	    	        if (mailCheckInput != authNum) {
	    	            mailCheckWarn.text("인증번호가 다릅니다.");
	    	            mailCheckWarn.css("color", "red");
	    	            mailCheckWarn.css("fontSize", "0.75em");
	    	            authResult = false;
	    		        return;
	    	        } else {
	    	            mailCheckWarn.text("인증되었습니다.");
	    	            mailCheckWarn.css("color", "green");
	    	            mailCheckWarn.css("fontSize", "0.75em");
	    	            authResult = true;
	    		        return;
	    	        }
	    	    });
	    	    $("#passwordModalConfirmButton3").click(function(){
	    	    	if(authResult){
                		document.querySelectorAll("label[for='inputCertification'], input[type='text'][name='inputCertification'], button[id='certificationModalConfirmButton'], h5[id='certificationCheck'], button[id='passwordModalConfirmButton3']")
                		.forEach(function(element) {
                	    element.style.display = "none";
                		});
	                	document.querySelectorAll(" label[for='newPassword'], input[type='password'][name='newPassword'], label[for='confirmNewPassword'], input[type='password'][name='confirmNewPassword'], button[id='passwordModalConfirmButton2']")
                		.forEach(function(element) {
                	    element.style.display = "inline-block";
                		});
	    	    	}else{
	    	    		alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
	    	    	}
	    	    	
	    	    });
	    	    
			});
		
		//비밀번호 찾기 step3
		document.getElementById('passwordModalConfirmButton2').addEventListener('click', () => {
			/* alert 버블링 현상 있습니다. */
			/* 비밀번호 예외처리 - 빈값, 정규식, 기존비밀번호와 일치 */
			var newPassword=$("#newPassword");
			var confirmNewPassword=$("#confirmNewPassword");
			if(newPassword.val()==""){
				newPassword.focus();		
				document.querySelector("#passwordCheck2").style.display = "inline-block";
				document.querySelector("#passwordCheck2").innerText = "새 비밀번호를 입력해주세요.";
				return false;
			}
			if(confirmNewPassword.val()==""){
				confirmNewPassword.focus();		  
				document.querySelector("#passwordCheck2").style.display = "inline-block";
				document.querySelector("#passwordCheck2").innerText = "비밀번호 확인을 입력해주세요.";
				return false;
			}
			var regexPw =  /^.*(?=^.{8,99}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
			if(!regexPw.test(newPassword.val())) {
				newPassword.focus();	
				document.querySelector("#passwordCheck2").style.display = "inline-block";
				document.querySelector("#passwordCheck2").innerText = "영문,숫자,특수문자 포함 8자 이상 입력해주세요.";
				return false;
			}
			if(newPassword.val()!=confirmNewPassword.val()) {
				confirmNewPassword.val("");
				confirmNewPassword.focus();	
				document.querySelector("#passwordCheck2").style.display = "inline-block";
				document.querySelector("#passwordCheck2").innerText = "비밀번호가 일치하지 않습니다.";
				return false;
			}
// 			if(newPassword.val()==currentPassword.val()) {
// 				newPassword.focus();	
// 				document.querySelector("#passwordCheck2").style.display = "inline-block";
// 				document.querySelector("#passwordCheck2").innerText = "기존비밀번호입니다.";
// 				return false;
// 			} /* 현재 비밀번호와 일치여부. 비로그인 상태라 ajax로 처리해야함. 가능하긴함  */
			$.ajax({
				type : 'POST',
				url : '${path}/mypage/updatePassword',
				data : {
					"email" : encryptionEamil,
					"updatePassword" :$("input[name='newPassword']").val()
				},
				success : function(){
					location.href='${path}/member/loginPage';
				},
				error : function(request, status, error) { 
			        console.log(error)
			    }
			})
		});
	}        
        
/*네이버 소셜 로그인 */        
const CLIENT_ID = "dNio2a8IwW1bwAeDTYAA";
/*const redirectURI = "http://localhost:7070/login/naverLogin";*/
const redirectURI = "http://14.36.141.71:10005/GDJ64_lolcogg_final/login/naverLogin";
const state ="1";
const naverLogin=()=>{
	/*console.log("여기오니?");*/
	location.assign("https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id="+CLIENT_ID+"&redirect_uri="+redirectURI+"&state="+state);
}