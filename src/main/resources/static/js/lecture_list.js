$(function() {
    $("#listBtn").click(function() {
        $.ajax({
            url: "/lecture/list/search/" + $("#search-lecture-input").val(),
            type: "GET",
            success: function(data) {
                console.log(data);

                // 검색 결과가 있을 경우에만 팝업을 생성하여 정보 표시
                if (data.length > 0) {
                    // 데이터 표시 부분 수정
                    // 팝업을 담을 변수 초기화
                    var popupContent = '';

                    // 각 검색 결과에 대해 팝업 정보 구성
                    for (var i = 0; i < data.length; i++) {
                        // 현재 강의 정보 구성
                        console.log(data[i]);
                        var lectureId = data[i].id;
                        var lectureName = data[i].name;
                        var professorName = "Professor: " + data[i].professor.name;
                        var room = "Room: " + data[i].room;
                        var day = "Day: " + data[i].lectureDay;
                        var startTime = "Start Time: " + data[i].startTime;
                        var endTime = "End Time: " + data[i].endTime;

                        // 팝업 내용에 현재 강의 정보 추가
                        popupContent += '<div class="lecture-popup">';
                        popupContent += '<div class="lecture-info">';
                        popupContent += '<p id="search-lecture-name">' + lectureName + '</p>';
                        popupContent += '<p id="search-lecture-professor">' + professorName + '</p>';
                        popupContent += '<p id="search-lecture-room">' + room + '</p>';
                        popupContent += '<p id="search-lecture-day">' + day + '</p>';
                        popupContent += '<p id="search-lecture-startTime">' + startTime + '</p>';
                        popupContent += '<p id="search-lecture-endTime">' + endTime + '</p>';
                        popupContent += '<button class="search-lecture-add btn btn-primary" data-lecture-id="' + lectureId + '">Add</button>';
                        popupContent += '</div><br></div>';
                    }

                    // 팝업 내용을 모달에 삽입하고 모달 열기
                    document.getElementById('lecture-info').innerHTML = popupContent;
                    openModal(); // 모달 열기 함수 호출
                    // window.open("lecture_searched.html", "popup", "width=400, height=400, scrollbars=no");

                    // Add 버튼 클릭 이벤트 처리
                    $(".search-lecture-add").click(function() {

                        var lectureId = $(this).data("lecture-id");
                        addLecture(lectureId);
                    });
                } else {
                    // 검색 결과가 없을 경우에 대한 처리
                    alert("No lectures found.");
                }
            }
        });
    });


     // Add 버튼 클릭 시 강의 추가 요청 보내기
function addLecture(lectureId) {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajax({
        url: "/lecture/add/" + lectureId,
        type: "POST",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(data) {
            console.log(data);
            closeModal();
            location.reload();
        }
    });
}
});
