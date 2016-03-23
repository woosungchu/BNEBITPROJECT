'use strict';
window.MessageModule = (function(MessageModule, $, undefined) {
  var ws;
  var client;
  var empEmail = '';

  var initMessage = function(loginEmail) {
    ws = new SockJS(contextPath +'/messageSet');
    client = Stomp.over(ws);
    client.connect({}, connectCallback);
    searchEmployee();
    insertMessage();
    initMessageModal();
    setUnCheckedMessageCount();
    empEmail = loginEmail;
  };

  function setUnCheckedMessageCount() {
    $.ajax({
      type: 'get',
      url: contextPath + '/rest/message/selectUncheckedMessageConut',
      success: function(count) {
        $('#message-unchecked-count').text(count);
      }
    });
  }

  function focusAndSelect(item) {
    var id = item.id;
    var receiverClass = 'receiver-' + id;
    $('#receiverTag').tagit('createTag', item.label, receiverClass);
    $('.' + receiverClass).attr('data-id', id);
  }

  var autocompleteOption = {
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
              var empLabel = employee.empName + '(' + employee.position + ')';
              return {
                id: employee.empId,
                label: empLabel,
                value: empLabel
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
        focus: function (event, ui) {
          focusAndSelect(ui.item);
          return false;
        },
        select : function(event, ui) {
          focusAndSelect(ui.item);
          return false;
        }
  };

  function searchEmployee() {
    $("#receiverTag").tagit({autocomplete: autocompleteOption});
  }

  function insertMessage() {
    $('#sendMessageBtn').on('click', function() {
      var receiverIds = [];
      $('.tagit-choice').each(function(){
        receiverIds.push($(this).attr('data-id'));
      });

      $('#receiver\\.empId').val(receiverIds.join(','));
      $('#messageForm').ajaxSubmit({
        url : contextPath + '/rest/message/insertMessage',
        dataType : 'json',
        type : 'post',
        beforeSerialize : function() {
        },
        success : function(result) {
          if (result.code === 'fail') {
            alert(result.message);
          } else {
            /*var sendData = {
                receiverEmpIds: $('#receiver\\.empId').val()
            };
            messageSend(sendData);*/
            $('#messageModal').modal('hide');
          }
        }
      });
    });
  }

  function initMessageModal() {
    $('#receiver\\.empName').autocomplete('option', 'appendTo', '#messageForm');
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

  var initReceiveMessageList = function() {
    messageRead();
    messageContentShow();
  };

  var initSendMessageList = function() {
    messageContentShow();
  };

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