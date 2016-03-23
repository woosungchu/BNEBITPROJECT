'use strict';
window.SortModule = (function(SortModule, $, undifined) {
  var initSort = function() {
    sortInit();
    sortClick();
  };

  function sortInit() {
    var $sortName = $('#sortName');
    var $sortBy = $('#sortBy');

    var sortName = $sortName.val();
    var sortBy = $sortBy.val();

    var sortNameArr = sortName.length > 0 ? sortName.split(',') : [];
    var sortByArr = sortBy.length > 0 ? sortBy.split(',') : [];


    for (var i = 0; i < sortByArr.length; i++) {
      if (sortByArr[i] == 'asc') {
        $('#' + sortNameArr[i]).text('▲');
      } else if (sortByArr[i] == 'desc'){
        $('#' + sortNameArr[i]).text('▼');
      }
    }
  }

  function sortClick () {
    $('.sortHeader').on('click', function() {
      var dataSortName = $(this).data('sortname');
      var $sortLabel = $('#' + dataSortName);
      var $sortName = $('#sortName');
      var $sortBy = $('#sortBy');

      var sortLabel = $sortLabel.text();
      var sortName = $sortName.val();
      var sortBy = $sortBy.val();
      var newSortBy;

      if (sortLabel == '▲') {
        $sortLabel.text('▼');
        newSortBy = 'desc';
      } else if (sortLabel == '▼') {
        $sortLabel.text('');
        newSortBy = '';
      } else {
        $sortLabel.text('▲');
        newSortBy = 'asc';
      }

      var sortNameArr = sortName.length > 0 ? sortName.split(',') : [];
      var index = sortNameArr.indexOf(dataSortName);
      var sortByArr = sortBy.length > 0 ? sortBy.split(',') : [];

      if (newSortBy) {
        if (index > -1) {
          sortByArr.splice(index, 1, newSortBy);
        } else {
          sortNameArr.push(dataSortName);
          sortByArr.push(newSortBy);
        }
      } else {
        sortByArr.splice(index, 1);
        sortNameArr.splice(index, 1);
      }
      $sortName.val(sortNameArr.toString());
      $sortBy.val(sortByArr.toString());
      $('#searchForm').submit();
    });
  }

  return {
    init : initSort
  }
})(window.SortModule || {}, jQuery);

window.SearchAddrModule = (function(SearchAddrModule, $, undifined) {
  var searchLayer = document.getElementById('searchAddrDiv');

  var initSearchAddr = function() {
    closeSearchLayer();
    searchAddr();
  };

  function closeSearchLayer() {
    $('#btnCloseLayer').on('click', function() {
      searchLayer.style.display = 'none';
    });
  }

  function initLayerPosition(){
    var width = 300; //우편번호서비스가 들어갈 element의 width
    var height = 460; //우편번호서비스가 들어갈 element의 height
    var borderWidth = 5; //샘플에서 사용하는 border의 두께
    // 위에서 선언한 값들을 실제 element에 넣는다.
    searchLayer.style.width = width + 'px';
    searchLayer.style.height = height + 'px';
    searchLayer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    searchLayer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
    searchLayer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
  }

  function searchAddr() {
    $('#searchAddrBtn').on('click', function() {
      new daum.Postcode({
           oncomplete: function(data) {
             searchLayer.style.display = 'none';
               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullAddr = data.address; // 최종 주소 변수
               var extraAddr = ''; // 조합형 주소 변수
               // 기본 주소가 도로명 타입일때 조합한다.
               if(data.addressType === 'R'){
                   //법정동명이 있을 경우 추가한다.
                   if(data.bname !== ''){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있을 경우 추가한다.
                   if(data.buildingName !== ''){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                   fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
               }
               // 주소 정보를 해당 필드에 넣는다.
               //TODO-이만섭: data에 postcode가 있는데, 화면에 input 여부에 따라 값을 넣는 로직이 필요할 지?
               document.getElementById('address').value = fullAddr;
               // 주소로 좌표를 검색
               var geocoder = new daum.maps.services.Geocoder();
               addressToMap(fullAddr);
           },
           width : '100%',
           height : '100%'
      }).embed(searchLayer);
      // iframe을 넣은 element를 보이게 한다.
      searchLayer.style.display = 'block';
      // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
      initLayerPosition();
    });
  }

  var addressToMap = function (param) {
    var address = $.type(param) === 'object' ? param.val() : param;
    var geocoder = new daum.maps.services.Geocoder();
    geocoder.addr2coord(address, function(status, result) {
      // 정상적으로 검색이 완료됐으면
      if (status === daum.maps.services.Status.OK) {
        $('#mapDiv').empty();
        $('#mapDiv').append('<div id="map" style="width:100%;height:350px;"></div>');

          var staticMapContainer  = document.getElementById('map'); // 이미지 지도를 표시할 div
          staticMapContainer.style.display = 'block';
          var staticMapOption = {
                  center: new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng), // 이미지 지도의 중심좌표
                  level: 3, // 이미지 지도의 확대 레벨
                  marker: {
                    position: new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng)
                  }
          };
          // 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
          var staticMap = new daum.maps.StaticMap(staticMapContainer, staticMapOption);
      }
    });
  };

  return {
    init : initSearchAddr,
    addressToMap : addressToMap
  }
})(window.SearchAddrModule || {}, jQuery);