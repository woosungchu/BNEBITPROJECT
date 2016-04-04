'use strict';
window.AdminClientModule = (function(AdminClientModule, $, undifined) {

  var customOption = {
    url : contextPath + '/rest/admin/client/selectClientList',
    jsonReader : {
      id : 'clientId'
    },
    colNames : [
        'clientId',
        '고객코드',
        '고객명',
        '2차 거래선',
        '대표자',
        '주소',
        '등록일'
    ],
    colModel : [
      { name : 'clientId', hidden:true},
      { name : 'clientCode', width:400,  align:'center', sortable: false, index:'client_code' , classes: 'pointer' },
      { name : 'clientName', width:200,  align:'center', index:'client_name'},
      { name : 'secondName', width:150,  align:'center', sortable: false, search:false},
      { name : 'ceo', width:150,  align:'center', sortable: false, index:'ceo'},
      { name : 'address', width:400,  align:'center', sortable: false, index:'address'},
      { name : 'regDate', width:200,  align:'center', sortable: false, search:false}
    ],
    postData : {
      searchField : '',
      searchString : ''
    },
    caption: '거래처 목록',
    onSelectRow: function(id, isSelected) {
      var row = $grid.jqGrid('getRowData', id);
      JqGridCommons.setSelectedValue(row.clientId, isSelected);
    },
    onSelectAll: function(clientIdArr, isSelected){
      var i, count, id;
      for (i = 0, count = clientIdArr.length; i < count; i++) {
        id = clientIdArr[i];
        var row = $grid.jqGrid('getRowData', id);
        JqGridCommons.setSelectedValue(row.clientId, isSelected);
      }
    },
    onCellSelect: function(rowid, index) {
      var columns = $grid.jqGrid('getGridParam','colModel');
      var row = $grid.getRowData(rowid);
      var currentPage = $grid.jqGrid('getGridParam', 'page');

      if ('clientCode' == columns[index].name) {
        location.href = contextPath + '/admin/client/clientView?clientId=' + row.clientId + '&currentPage=' + currentPage +JqGridCommons.getParamString();
      }
    }
  };


  function setPageOption(jsonPage) {
    if (jsonPage) {
      var pageSet = JSON.parse(jsonPage);
      customOption.sortname = pageSet.sortName;
      customOption.sortorder = pageSet.sortBy;
      customOption.rowNum = pageSet.selectPostList;
      customOption.page = pageSet.currentPage;
      customOption.postData.searchField = pageSet.searchKey;
      customOption.postData.searchString = pageSet.searchValue;

    }
  }

  function removeClientList() {
    $('#removeSelectedList').on('click', function() {
      var cookies = $.cookie();
      var clientIdArr = [];
      for (var cookie in cookies) {
        if (cookie != 'JSESSIONID') {
          clientIdArr.push(cookie);
          $.removeCookie(cookie);
        }
      }

      $.ajax({
        url: contextPath + '/rest/admin/client/deleteClientList',
        type: 'post',
        data: {
          clientIdList : clientIdArr
        },
        beforeSend : function() {
          if (!clientIdArr.length) {
            alert('삭제할 거래처를 선택해주세요')
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

  var removeClient = function() {
    $('#removeBtn').on('click', function() {
      var clientId = $(this).data('id');
      $.ajax({
        url: contextPath + '/rest/admin/client/deleteClient',
        type: 'post',
        data: {
          clientId : clientId
        },
        dataType: 'json',
        success: function(result) {
          if (result.code === 'fail') {
            alert(result.message);
          } else {
            alert(result.message);
            location.href = contextPath + result.url;
          }
        }
      });
    });
  }

  var initGrid = function(jsonPage) {
    setPageOption(jsonPage);

    $grid = $grid || $('#grid');
    $grid.jqGrid(JqGridCommons.init(customOption)).navGrid('#pager', { view: false, del: false, add: false, edit: false },
        {}, // default settings for edit
        {}, // default settings for add
        {}, // delete
        {
          closeOnEscape: true,
          closeAfterSearch: true,
          sopt: ['in']
        }, // search options
        {}
    );

    JqGridCommons.resetSelect();
    removeClientList();
  };

  var initInsert = function() {
    $('#insertBtn').on('click', function() {
      $('#clientForm').ajaxSubmit({
        dataType : 'json',
        beforeSerialize : function() {
        },
        success : function(result) {
          if (result.code === 'success') {
            alert(result.message);
            location.href = contextPath + result.url;
          } else {
            alert(result.message);
            $('#' + result.field).focus();
          }
        }
      });
    });
  };

  var initUpdate = function() {
    $('#updateBtn').on('click', function() {
      $('#clientForm').ajaxSubmit({
        dataType : 'json',
        beforeSerialize : function() {
        },
        success : function(result) {
          if (result.code === 'success') {
            alert(result.message);
            location.href = contextPath + result.url;
          } else {
            alert(result.message);
            $('#' + result.field).focus();
          }
        }
      });
    });
  };


  return {
    grid : initGrid,
    insert : initInsert,
    update : initUpdate,
    removeClient : removeClient
  }
})(window.AdminClientModule || {}, jQuery);