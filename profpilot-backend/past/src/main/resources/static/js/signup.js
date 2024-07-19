$("#overlappedID").click(function(){
$("#signup").attr("type", "button");
const id = $("#user_name").val();
$.ajax({
type: "get",
async: false,
url: "http://localhost:8080/user/checkId",
data: {id: id},
success: function (data) {
if(data == 1) {
    $("#message").text("이미 사용중인 ID 입니다.");
    $("#message").addClass("messageboxes");
    $("#message").removeClass("messageboxes");
    }else {
    $("#message").text("사용 가능한 ID 입니다.");
    $("#message").addClass("messageboxes");
    $("#message").removeClass("messageboxes");
    }
    }
})
});