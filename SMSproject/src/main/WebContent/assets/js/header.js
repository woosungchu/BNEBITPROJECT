$(document).ready(function(){
	//비밀번호 변경요청 버튼 클릭
	$('#btnChangePwdModal').click(function(){
		//RSA key
		$.ajax({
			url : "/getRSAKey",
			success : function(result){
				$('#RSAModulus').val(result.RSAModulus);
				$('#RSAExponent').val(result.RSAExponent);

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

	   if(fullQString.length > 0){
	       paramArray = fullQString.split("&");

	       for (i=0;i<paramArray.length;i++){
	         currentParameter = paramArray[i].split("=");
	         if(currentParameter[0] === 'RESULT'){
	        	 switch (currentParameter[1]) {
				case 'PWD_SUCCESS':
					alert("비밀번호가 성공적으로 변경되었습니다");
					break;
				case 'WRONG_PWD':
					$('#btnChangePwdModal').click();
	        		 alert("비밀번호가 맞지 않습니다");
					break;
				case 'IMG_SUCCESS':
					$newImg = $('img[alt=ProfileImg]');
					$newImg.attr('src',$newImg.attr('src')+'?'+ new Date().getTime());
					break;
				}

	        	return true;
	         }
	       }
	   }
	}

	$(document).on('change', '.btn-file :file', function() {
	      $('#modImgForm').submit();
	});
	
	//search하기 전의 페이지 Data
	var backupContainerData ;
	$(window).load(function(){
		backupContainerData = $('#page-content-wrapper').html();
	})
	$('#searchBtn').click(searchKeyword);
	$('#searchInput').keyup(searchKeyword);
	$('#footerInput').keyup(searchKeyword);
	//검색
	function searchKeyword(){
		var $container = $('#page-content-wrapper');
		var keyword = $('#searchInput').val();
		
		$container.html('');
		if(keyword.trim() != ''){
			//성공적으로 검색결과창 불러왔는지 여부
			$container.load('/searchResult?keyword='+encodeURIComponent(keyword) , 
					function(responseText, textStatus, XMLHttpRequest){
				if(textStatus == "success"){
					//load되는 page 안에 script 실행.
				
				}else{//Load SUCCESS
					alert("Load Failed!!!");
				}
			});
		}else{
			$container.html(backupContainerData);
		}
	}
	
	
	
	function init(){
		checkParemeterExists();
		$('.btn-staff-info').on('click',staffInfo);
	}

	init();
});

//staffInfoModal
//staff click event
function staffInfo(){
	var empId = $(this)[0].dataset.empId;
	var html = '';
	$.ajax({
		url : '/staffInfo',
		data : {
			empId : empId
		},
		success : function(result){
			if(result.imgName === 'NONAME' || !result.imgName){
				$('#staffImg').attr('src','/assets/image/noname.png');
			}else{
				$('#staffImg').attr('src','/Upload/'+result.imgName);
			}
			var position;
			if(result.position === 'Salesman'){
				position = ' 팀원'
			}else if(result.position ==='Manager'){
				position = ' 팀장'
			}

			html += '<h4> '+result.empName;
			html += '<small> '+result.dept.deptName + position + '</small>';
			html += '</h4> '
			html += '<h5>연락처 : '+result.phone+'</h5>';
			html += '<h5>이메일 : '+result.email+'</h5>';

			$('#staff-info').html(html);
		}
	})
	$('#staffInfoModal').modal('show');
}


