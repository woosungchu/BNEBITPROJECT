'use strict';
window.MessageModule = (function(MessageModule, $, undefined) {
  var ws;
  var client;
  var empEmail = '';

  // 참고: http://netframework.tistory.com/entry/Spring-4x%EC%97%90%EC%84%9C%EC%9D%98-WebSocket-SockJS-STOMP
  // loginEmail의 경우 클라이언트에서 메시지를 받을 때(subscribe의 path) 사용 -> 각자에게 메시지 전송 여부를 전달하기 위해서
  var initMessage = function(loginEmail) {
    ws = new SockJS(contextPath +'/messageSet');        // 웹소켓 연결
    client = Stomp.over(ws);                            // STOMP client 설정
    client.connect({}, connectCallback, errorCallback);
    searchEmployee();
    insertMessage();
    initMessageModal();
    setUnCheckedMessageCount();
    empEmail = loginEmail;
  };

  // 읽지 않은 메시지 개수를 조회
  function setUnCheckedMessageCount() {
    $.ajax({
      type: 'get',
      url: contextPath + '/rest/message/selectUncheckedMessageConut',
      success: function(count) {
        $('#message-unchecked-count').text(count);
      }
    });
  }

  // 검색한 직원을 추가 시 li 태그를 생성해 추가시키는데, 생성된 li 태그에 emlId와 email data 추가
  function selectCreateTag(item) {
    var id = item.id;
    var email = item.value;
    var receiverClass = 'receiver-' + id;
    $('#receiverTag').tagit('createTag', item.label, receiverClass);
    $('.' + receiverClass).attr('data-id', id);
    $('.' + receiverClass).attr('data-email', email);
  }

  // tagIt이라는 라이브러리를 사용 시 jquery에서 제공하는 autocomplete를 적용 시킬 수 있음
  // tagIt 참고: http://aehlke.github.io/tag-it/, autocomplete: https://jqueryui.com/autocomplete/
  function searchEmployee() {
    var autocompleteOption = {
        autoFocus: true,
        source : function(request, response) {
          $.ajax({
          dataType : 'json',
          url : contextPath + '/rest/message/searchEmployee',
          data : {
            searchName : request.term
          },
          type : 'get',
          success : function(employeeList) {
            response($.map( employeeList, function(employee) {
              var empLabel = employee.empName + '(' + employee.email + ')';
              return {
                id: employee.empId,
                label: empLabel,
                value: employee.email
                }
            }));
          },
          error : function(request, status, error) {
            if (request.status == 406) {
              alert(request.responseText);
              location.href = contextPath + '/';
              return false;
            }
          }
          });
        },
        search : function() {
          // custom minLength
          var searchName = this.value;
          if (searchName.length < 2) {
            return false;
          }
        },
        focus: function (event, ui) {
          return false;
        },
        select : function(event, ui) {
          selectCreateTag(ui.item);
          return false;
        }
    };
    $("#receiverTag").tagit({
      autocomplete: autocompleteOption
    });
  }

  // 메시지 전송 전에 수신인에 추가된 직원들(li 태그)에서 empId, email을 array에 저장
  function insertMessage() {
    $('#sendMessageBtn').on('click', function() {
      var receiverIds = [];
      var receiverEmails = [];
      $('.tagit-choice').each(function(){
        receiverIds.push($(this).attr('data-id'));
        receiverEmails.push($(this).attr('data-email'));
      });

      var $messageContent = $('#messageContent');
      var content = $messageContent.val();

      $.ajax({
        url : contextPath + '/rest/message/insertMessage',
        dataType : 'json',
        type : 'post',
        beforeSend : function() {
          if (!receiverIds.length) {
            alert('검색결과를 선택해주세요');
            $('.ui-autocomplete-input').focus();
            return false;
          }

          if (!content) {
            alert('내용을 입력해주세요')
            $messageContent.focus();
            return false;
          }
        },
        data : {
          content : content,
          receiverIdList : receiverIds,
          receiverEmailList : receiverEmails
        },
        success : function(result) {
          if (result.code === 'fail') {
            alert(result.message);
          } else {
            $('#messageModal').modal('hide');
          }
        }
      });
    });
  }

  function initMessageModal() {
    $('#messageModal').on('show.bs.modal', function (e) {
      if (!empEmail) {
        alert('세션이 끊어졌습니다. 다시 로그인 바랍니다');
        location.href = contextPath + '/';
      }
    });
    $('#messageModal').on('hidden.bs.modal', function (e) {
      $('.tagit-choice').remove('');
      $('#receiver\\.empId').val('');
      $('#messageContent').val('');
    });
  }

  function connectCallback(frame) {
    messageSubscribe();
  }

  function errorCallback(error) {
    console.log(error);
  }

  // 메시지 전송 후 서버에서 읽지 않은 메시지 개수를 STOMP를 통해 보내는데, 이를 수신하기 위한 설정.
  function messageSubscribe() {
    client.subscribe('/newMessage/notice/' + empEmail, function(message) {
      var uncheckedCount = message.body;
      if (uncheckedCount) {
        $('#message-unchecked-count').text(uncheckedCount);
      }
    });
  }

  /*function messageSend(data) { TODO-이만섭: messageService에서 template.convertAndSend를 통해 send 거칠 필요가 없음
    client.send('/message/receiverEmpIdList', {}, JSON.stringify(data));
  }*/

  // 받은 메시지함
  var initReceiveMessageList = function() {
    messageRead();
    messageContentShow();
  };

  // 보낸 메시지함
  var initSendMessageList = function() {
    messageContentShow();
  };

  // 받은 메시지의 경우 data-id 값이 있다면 읽지 않은 메시지이기 때문에 내용을 눌렀을 때 읽은 것으로 처리한다.
  function messageRead() {
    $('.collapse').on('shown.bs.collapse', function() {
      var $that = $(this);
      var msgId = $that.attr('data-id');
      if (!msgId) {
        return false;
      }
      $.ajax({
        url: contextPath + '/rest/message/updateReadMessage',
        type: 'post',
        dataType: 'json',
        data: {
          msgId : msgId
        },
        success: function(result) {
          if (result.code === 'fail') {
            alert(result.message);
          } else {
            $that.attr('data-id', '');
            var $count = $('#message-unchecked-count');
            var count = parseInt($count.text()) - 1;
            $count.text(count);
          }
        }
      })
    });
  }

  // ui 설정이 잘못된 것인지... bootstrap accordion 동작이 제대로 안되 추가
  function messageContentShow() {
    $('.collapse').on('show.bs.collapse', function () {
      var $otherPanels = $(this).parents('.panel').siblings('.panel');
      $('.collapse',$otherPanels).removeClass('in');
    });
  }

  return {
    init : initMessage,
    initReceiveList : initReceiveMessageList,
    initSendList : initSendMessageList
  }
})(window.MessageModule || {}, jQuery);