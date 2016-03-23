$(document).ready(function(){
	var configEmailFlag = 0;
	var configPasswordFlag = 0;
	$('#employeeAddForm').submit(function(event){
		if(configEmailFlag===0){
			alert("Error : E-mail 설정을 다시 확인하여 주세요!");
			return false;
		}
		if(configPasswordFlag===0){
			alert("Error : password 설정을 다시 확인하여 주세요!");
			return false;
		}
	});

	$('#employeeUpdateForm').submit(function(event){
		if(configPasswordFlag===0){
			alert("Error : password 설정을 다시 확인하여 주세요!");
			return false;
		}
	});

	function validateEmail(email) {
		var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(email);
	}
	$('#email').focus(function(){
		$("#duplicateResult").text("");
	});
	$('#email').blur(function(){
		if(validateEmail($('#email').val()))
		{
			$.ajax({
				url:'/admin/employee/configEmailDuplicate',
				type:'post', // get 방식은 딱 1번만 요청 가능. post 사용 하도록...
				data:{'email':$('#email').val()},
				success:function(data)
				{
					if(data==="\"사용 가능\"")
					{
						$("#duplicateResult").text("사용 가능한 E-mail 입니다.").attr("style","color: blue;");
						configEmailFlag = 1;
					}
					else
					{
						$("#duplicateResult").text("Error : 이미 존재하는 E-mail 입니다 !").attr("style","color: red;");
						configEmailFlag = 0;
					}
				}
			});
		}
		else
		{
			if($('#email').val()=="")
				return;
			$("#duplicateResult").text("Error : E-mail 형식으로 입력해 주세요!").attr("style","color: red;");
			configEmailFlag = 0;
		}
	});
	$('#realPassword').focus(function(){
		$("#agreementPassword").text("");
	});
	$('#configPassword').focus(function(){
		$("#agreementPassword").text("");
	});
	$('#realPassword').blur(function(){
		if($('#realPassword').val()!="" && $('#configPassword').val()!="")
		{
			if($('#realPassword').val() != $('#configPassword').val())
			{
				configPasswordFlag = 0;
				$("#agreementPassword").text("Error : 비밀번호가 일치하지 않습니다!").attr("style","color: red;");
			}
			else
				configPasswordFlag = 1;
		}
	});
	$('#configPassword').blur(function(){
		if($('#realPassword').val()!="" && $('#configPassword').val()!="")
		{
			if($('#realPassword').val() != $('#configPassword').val())
			{
				configPasswordFlag = 0;
				$("#agreementPassword").text("Error : 비밀번호가 일치하지 않습니다!").attr("style","color: red;");
			}
			else
				configPasswordFlag = 1;
		}
	});

});