$(document).ready(function(){
	//비밀번호 변경요청 버튼 클릭
	$('#btnChangePwdModal').click(function(){
		//RSA key
		$.ajax({
			url : "/getRSAKey",
			success : function(result){
				$('#RSAModulus').val(result.RSAModulus);
				$('#RSAExponent').val(result.RSAExponent);
				
				console.log($('#RSAExponent').val());
				
				$('#userInfoModal').modal('hide');
				$('#changePwdModal').modal('show');
			}
		});
	})
	//비밀번호 변경 전송
	$('#modifyPwdForm').submit(function(event){
		var cur = $('#currentPwd').val();
		var pwd1 = $('#firstPwd').val();
		var pwd2 = $('#secondPwd').val();
		if(!cur || !pwd1 || !pwd2 || pwd1 != pwd2 ){
			alert("입력값이 없거나 서로 맞지 않습니다");
			event.preventDefault();
			return false;
		}
		
		var rsa = new RSAKey();
		rsa.setPublic($('#RSAModulus').val(), $("#RSAExponent").val());
		cur = rsa.encrypt(cur);
		pwd2 = rsa.encrypt(pwd2); 
		$('#securedCurrentPwd').val(cur);
		$('#securedNewPwd').val(pwd2);
	})
	
	function checkParemeterExists(){
	   var fullQString = window.location.search.substring(1);
	   var paramCount = 0;
	   var queryStringComplete = "?";
	
	   if(fullQString.length > 0){
	       paramArray = fullQString.split("&");
	       
	       for (i=0;i<paramArray.length;i++){
	         currentParameter = paramArray[i].split("=");
	         if(currentParameter[0] === 'MOD_PWD_RESULT'){
	        	 if(currentParameter[1] === 'WRONG_PWD' ){
	        		 $('#btnChangePwdModal').click();
	        		 alert("비밀번호가 맞지 않습니다");
	        	 }else{
	        		 alert("비밀번호가 성공적으로 변경되었습니다");
	        	 }
	        	 return true;
	         }
	       }
	   }
	}

	function init(){
		checkParemeterExists();
	}
	
	init();
});