'use strict';
window.AdminMessageModule = (function(AdminMessageModule, $, undifined) {

  var messagePopup;
  var idMap;
  var ws;
  var client;

  // 관리자 받은 메시지함 jqGrid option
  var customOption = {
    url : contextPath + '/rest/admin/message/sendMessageList',
    jsonReader : {
      id : 'msgId'
    },
    colNames : [
        'msgId',
        '메시지',
        '직원',
        '소속',
        '직급',
        '등록일'
    ],
    colModel : [
      { name : 'msgId', hidden:true},
      { name : 'content', width:400,  align:'center', sortable: false, classes: 'ellipsis pointer' },
      { name : 'receiver.empName', width:200,  align:'center', sortable: false},
      { name : 'receiver.dept.deptName', width:150,  align:'center', sortable: false},
      { name : 'receiver.position', width:150,  align:'center', sortable: false},
      { name : 'msgDate', width:200,  align:'center', sortable: false}
    ],
    width : '1000',
    caption: '메시지 목록',
    onSelectRow: function(id, isSelected) {
      var row = $grid.jqGrid('getRowData', id);
      JqGridCommons.setSelectedValue(row.msgId, isSelected);
    },
    onSelectAll: function(msgIdArr, isSelected){
      var i, count, id;
      for (i = 0, count = msgIdArr.length; i < count; i++) {
        id = msgIdArr[i];
        var row = $grid.jqGrid('getRowData', id);
        JqGridCommons.setSelectedValue(row.msgId, isSelected);
      }
    },
    onCellSelect: function(rowid, index) {
      var columns = $grid.jqGrid('getGridParam','colModel');
      var row = $grid.getRowData(rowid);
      var currentPage = $grid.jqGrid('getGridParam', 'page');
      if ('content' == columns[index].name) {
        var content = '받은 사람: '
          + row['receiver.empName']
          + '\n메시지:\n'
          + row.content;
        $('#content').text(content);
      }
    }
  };

  // 검색결과, 정렬등의 history 처리
  function setPageOption(jsonPage) {
    if (jsonPage) {
      var pageSet = JSON.parse(jsonPage);
      customOption.sortname = pageSet.sortName;
      customOption.sortorder = pageSet.sortBy;
      customOption.rowNum = pageSet.selectPostList;
      customOption.page = pageSet.currentPage;
    }
  }

  // 메시지 목록 초기화
  var initGrid = function(jsonPage) {
    setPageOption(jsonPage);

    $grid = $grid || $('#grid');
    $grid.jqGrid(JqGridCommons.init(customOption));

    removeMessageList();
    JqGridCommons.resetSelect();
  };

  // 메시지 선택 삭제
  function removeMessageList() {
    $('#removeSelectedList').on('click', function() {
      var cookies = $.cookie();
      var messageIdArr = [];
      for (var cookie in cookies) {
        if (cookie != 'JSESSIONID') {
          messageIdArr.push(cookie);
          $.removeCookie(cookie);
        }
      }

      $.ajax({
        url: contextPath + '/rest/admin/message/deleteMessageList',
        type: 'post',
        data: {
          messageIdList : messageIdArr
        },
        beforeSend : function() {
          if (!messageIdArr.length) {
            alert('삭제할 메시지를 선택해주세요')
            return false;
          }
        },
        dataType: 'json',
        success: function(result) {
          if (result.code === 'fail') {
            alert(result.message);
          } else {
            alert(result.message);
            location.reload();
          }
        }
      });
    });
  }

  // 메시지 팝업
  function setSelectEmployee() {
    idMap = window.opener.AdminPopupModule.getIdMap();
    if (idMap.size() < 1) {
      alert('목록에서 메시지를 보낼 직원을 선택해주세요.');
      client.disconnect();
      self.close();
      return false;
    }

    var idArr = idMap.keys();
    for (var index in idArr) {
      // 추후 변경될 수 있음... 현재는 value가 이메일이지만 value 값 변경 시 문제 생김
      var id = idArr[index];
      var $option = $('<li>').attr('data-id', id).text(idMap.get(id)).addClass('emp');
      $('#selectEmployee').append($option);
    }
  }

  var messageFormInit = function() {
    setSelectEmployee();
    insertMessage();
    selectEmpList();
    selectEmpRemove();
    initSocket();
    popupClose();
  };


  function initSocket() {
    ws = new SockJS(contextPath +'/messageSet');
    client = Stomp.over(ws);
    client.connect({}, function(frame) {});
  }

  function insertMessage() {
    $('#sendMessageBtn').on('click', function() {
      var receiverIds = [];
      var receiverEmails = [];
      $('.emp').each(function () {
        receiverIds.push($(this).data('id'));
        receiverEmails.push($(this).text());
      });

      var $content = $('#content');
      var content = $content.val();
      $.ajax({
        url : contextPath + '/rest/admin/message/insertMessage',
        dataType : 'json',
        type : 'post',
        beforeSend : function() {
          var $content = $('#content');
          if (!$content.val()) {
            alert('내용을 입력해주세요.');
            $content.focus();
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
            alert(result.message);
            client.disconnect();
            self.close();
          }
        }
      });
    });
  }

  function selectEmpList() {
    $('.emp').on('click', function() {
      $(this).toggleClass('select-list');
    });
  }

  function selectEmpRemove() {
    $('#listRemoveBtn').on('click', function() {
      $('.select-list').remove();
      if ($('.emp').length == 0) {
        client.disconnect();
        self.close();
      }
    });
  }

  function popupClose() {
    $('#closeBtn').on('click', function() {
      client.disconnect();
      self.close();
    });
  }

  return {
    grid : initGrid,
    messageForm : messageFormInit
  }
})(window.AdminMessageModule || {}, jQuery);