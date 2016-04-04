'use strict';
window.ClientModule = (function(ClientModule, $, undifined) {

  var initInsertForm = function() {
    insertClient();
    SearchAddrModule.initPopup();
  };

  var initUpdateForm = function() {
    goClientView();
    updateClient();
    SearchAddrModule.initPopup();
    SearchAddrModule.addressToMap($('#address'));
  };

  var initClientView = function() {
    goAddForm();
    goUpdateForm();
    SearchAddrModule.addressToMap($('#address'));
  };

  function goAddForm() {
    $('#addFormBtn').on('click', function() {
      location.href = contextPath + '/client/clientAddForm';
    });
  }

  function goUpdateForm() {
    $('#updateFormBtn').on('click', function() {
      var clientId = $(this).data('id');
      location.href = contextPath + '/client/clientUpdate?clientId=' + clientId;
    });
  }

  function goClientView() {
    $('#cancelBtn').on('click', function() {
      var clientId = $(this).data('id');
      location.href = contextPath + '/client/clientView?clientId=' + clientId;
    });
  }

  var insertClient = function() {
    $('#clientForm').ajaxForm({
      dataType : 'json',
      beforeSerialize : function() {

      },
      success : function(result) {
        if (result.code == 'success') {
          alert(result.message);
          location.href = contextPath + result.url;
        } else {
          alert(result.message);
          $('#' + result.field).focus();
        }
      }
    });
  };

  var updateClient = function() {
    $('#clientForm').ajaxForm({
      dataType : 'json',
      beforeSerialize : function() {

      },
      success : function(result) {
        if (result.code == 'success') {
          alert(result.message);
          location.href = contextPath + result.url;
        } else {
          alert(result.message);
          $('#' + result.field).focus();
        }
      }
    });
  };

  return {
    initUpdate : initUpdateForm,
    initInsert : initInsertForm,
    initView : initClientView
  }
})(window.ClientModule || {}, jQuery);