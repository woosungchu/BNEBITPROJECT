$(document).ready(function(){

	$(window).resize(function(){
		resizing();
	});

	function init(){
		resizing();
		//tooltip bootstrap
		$('[data-toggle="popover"]').popover();
	}

	init();
});

// Methods Declaration

//인증번호 메일로 받기
function validation(){
	$('#btnValid').addClass('disabled');
	document.body.style.cursor='wait';
	
	$.ajax({
		url : "/requestValidation",
		data : {
			empName : $('#inputName').val(),
			email : $('#inputEmail').val()
		},
		success : function(result){
			$('#btnValid').removeClass('disabled');
			window.onload=function(){document.body.style.cursor='default';}
			
			if('ERROR' === result){
				alert("이름과 이메일이 일치하지 않습니다");
			}else if ('SUCCESS' === result){
				alert("인증번호 전송이 완료되었습니다. 이메일을 확인하세요");
				
				$('#helpModal').modal('hide');
				$('#validationModal').modal('show');
			}else{
				alert('인증번호전송 처리결과가 SUCCESS 혹은 ERROR를 리턴하지 않았습니다');
			}
		}
	});
}

//인증번호 확인
function gotoForm(){
	console.log("인증번호 확인 중");
	
	var $code = $('#validCode').val();
	var $firstPwd = $('#firstPwd').val();
	var $secondPwd = $('#secondPwd').val();
	
	if(!$code || !$firstPwd || !secondPwd){
		alert("채워지지 않은 곳이 있습니다");
	}else if($code.trim() === ""){
		alert("인증번호를 입력해주십시오!");
	}else if($firstPwd.trim() === "" 
		|| $secondPwd.trim() === ""){
		alert("비밀번호를 다시 입력해주십시요.");
	}else if($firstPwd !== $secondPwd){
		alert("첫번째와 두번쨰의 비밀번호가 서로 맞지 않습니다");
	}else{
		//RSA
		var rsa = new RSAKey();
		rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
		
		//사용자 계정정보를 암호화 처리
		var newPwd = rsa.encrypt($firstPwd);
		
		//인증
		$.ajax({
			url : '/checkValidation',
			data :{
				code : $code,
				password : newPwd,
				empName : $('#inputName').val(),
				email : $('#inputEmail').val()
			},
			success : function(result){
				if('DENIED' === result){
					alert("인증번호가 만료되었거나 맞지 않습니다.");
				}else if ('PASS' === result){
					$('#validationModal').modal('hide');
					alert("인증이 완료되었습니다. 다음부턴 까먹지마세용~");
					location.href="/";
				}else{
					alert('인증번호전송 처리결과가 PASS 혹은 DENIED 리턴하지 않았습니다');
				}
			}
		})
	}
}

//login
$("#hiddenForm").submit(function(event){
	var uid = $('#user_id').val();//.trim()
	var pwd = $('#user_pwd').val();
	if (!uid || !pwd) {
        alert("아이디와 비밀번호를 입력해주세요.");
        //return false;
        event.preventDefault();
        return false;
    }
	
	//RSA 암호화 생성
	var rsa = new RSAKey();
	rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
	
	//사용자 계정정보를 암호화 처리
	uid = rsa.encrypt(uid);
	pwd = rsa.encrypt(pwd); 
	
	$('#securedId').val(uid);
	$('#securedPwd').val(pwd);
	
});


//responsive login-box configuration
function resizing(){
	var windowH = $(window).height()/2;
//	var logoH = $('#logo').height();
	var contentH = $('#content-box').height()/2;

//	var totalH = windowH - logoH - contentH;
	var totalH = windowH - contentH;

	$('#content-box').css("margin-top", totalH);
}

$('#user_id').dblclick(function(){
	console.log("누르지마 아프잖아");
	$(this).removeAttr('readonly');
	$(this).val("");
})