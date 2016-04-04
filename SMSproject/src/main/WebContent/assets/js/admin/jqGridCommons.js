'use strict';

var $grid = '';

window.JqGridCommons = (function(JqGridCommons, $, undefined) {
  var selectedValueArray = [];
  var dataId;
  var paramString;

  /** 페이징 이동 시 검색값 & 체크박스 key 저장 */
  /*function pagingHoldData(pgButton) {
      var currentPage = $grid.jqGrid('getGridParam', 'page');
      var selarrrow = $grid.jqGrid('getGridParam', 'selarrrow');
      $.cookie(currentPage, selarrrow.join(','));
      selRowMap.put(currentPage, selarrrow);
  }*/

  /** 체크박스 유지 및 검색값 셋팅 */
  function loadFn(pageInfo) {
    console.log($grid.jqGrid('getGridParam'));
    var currentPage = $grid.jqGrid('getGridParam', 'page');
    paramString = pageInfo.pageSet.paramString;
    var selarrrows = $.cookie(currentPage.toString());

    var rowArr = $grid.jqGrid('getRowData');

    for (var i = 0; i < rowArr.length; i++) {
      $grid.jqGrid('setSelection', $.cookie(rowArr[i][dataId]), false);
    }
  }

  function errorFn(jqXHR, textStatus, errorThrown) {
    if (jqXHR.status == '406') {
      alert(jqXHR.responseText);
      location.href = contextPath + '/';
    }
  }

  /** 체크박스 선택 시 배열에 기본키 or row 추가 */
  /** object를 넘길 경우 rowNum 함께 넘겨 사 용 */
  var setSelectedValue = function(selectValue, isSelected) {
    if (isSelected) {
      $.cookie(selectValue, selectValue);
    } else {
      $.removeCookie(selectValue);
    }

    var index = -1;
    index = $.inArray(selectValue, selectedValueArray);
    if (!isSelected && index >= 0) {
      selectedValueArray.splice(index, 1);
    } else if (isSelected && index < 0) {
      selectedValueArray.push(selectValue);
    }
  };

  var resetSelect = function() {
    $('#resetSelect').on('click', function(){
      var cookies = $.cookie();
      for(var cookie in cookies) {
        $.removeCookie(cookie);
      }
      selectedValueArray = [];
      $grid.trigger('reloadGrid');
    });
  };

  var commonOption = {
    datatype : 'json',
    mtype : 'POST',
    jsonReader : {
      root : 'dataList',
      total : 'pageSet.totalPage',
      page : 'pageSet.currentPage',
      records : 'pageSet.totalPost'
    },
    rowList: [2, 3, 5, 10, 15, 20, 25, 30],
    rowNum : '10',
    pager : '#pager',
    width : '1600',
    height : 'auto',
    emptyrecords : '데이터가 존재하지 않습니다.',
    showpage : true,
    viewrecords: true,
    multiselect : true,
    multiboxonly : true, // 체크 박스를 클릭해야 다중 선택 가능
    loadonce : false,
    multiSort : true,
    loadComplete : loadFn,
    loadError : errorFn,
    beforeSelectRow: function (rowid, e) {
      return $(e.target).is('input[type=checkbox]');
    }
  };

  /**
   * JqGridOption 설정 초기화
   * 필수 옵션 { url, colNames, colModel }
   * 이외 필요 옵션은 오버라이딩 및 추가 하여 사용
   * @param optionParam : {}
   * @returns {{}}}
   */
  var initOption = function(optionParam) {
    dataId = optionParam.jsonReader.id;
    optionParam = optionParam || {};
    return $.extend(true, commonOption, optionParam);
  };

  var getParamString = function() {
    return paramString;
  };

  return {
    init : initOption,
    setSelectedValue : setSelectedValue,
    resetSelect : resetSelect,
    getParamString : getParamString
  }
})(window.JqGridCommons || {}, jQuery);

/*var sendMessageOptions = {
colNames : [ 'messageKey', '번호', '받는사람', '보낸사람', '쪽지내용', '보낸시각', 'receiveUserKey', 'userKindCode', 'senderCode' ],
colModel : [
  { name : 'messageKey'       , hidden  : true , sortable : false  },
  { name : 'rowNum'           , width: 70 , align: 'center' , sortable: false, formatter: JqGridFormatter.rowNumberFormat},
  { name : 'receiverNameAndId', width: 100, align: 'center' , sortable: false, formatter: JqGridFormatter.receiveUserDetailFormat},
  { name : 'sender'           , width: 150, align: 'center'},
  { name : 'contents'         , width: 320, align: 'center' , formatter: JqGridFormatter.messageDetailFormat },
  { name : 'strSendDate'      , width: 140, align: 'center'},
  { name : 'receiveUserKey'   , width: 70 , align: 'center' , hidden  : true , sortable : false  },
  { name : 'userKindCode'     , width: 70 , align: 'center' , hidden  : true , sortable : false  },
  { name : 'senderCode'       , width: 70 , align: 'center' , hidden  : true , sortable : false  }
]
};*/


/** 회원명 이름(아이디) */
/*var nameFormat = function(cellValue, options, rowObject) {
var id = '';
var cellName = options.colModel.name;
for(var key in rowObject) {
  if(key === cellName) {
    id = rowObject[cellName.replace('Name', 'Id')];
    if(!id) {
      id = rowObject[cellName.replace('Name', 'Key')];
    }
  }
}

var formatter = '-';
if (cellValue) {
  formatter = cellValue + '(' + id + ')';
}
return formatter;
};*/

/*var pointerNameFormat = function(cellvalue, options, rowObject) {
return '<span class="pointer">' + nameFormat(cellvalue, options, rowObject) + '</span>';
};*/

/*var dateFormat = function(cellValue, options) {
var dateFormat = options.colModel.formatoptions.dateFormat;
var printDate = '-';
if (cellValue) {
  printDate = $.format.date(cellValue, dateFormat);
}
return printDate
};*/