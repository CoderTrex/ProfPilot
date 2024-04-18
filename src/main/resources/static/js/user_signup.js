$(document).ready(function() {
    $("#send_email").click(function() {
        var email = $("#email").val();
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            url: "/user/send_code_email/" + email,
            type: "POST",
            data: {
                email: email
            },
            beforeSend: function(xhr) {
                if (token.length > 0 && header.length > 0)
                    xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                alert("이메일 전송 완료");
            },
            error: function() {
                alert("이메일 전송 실패");
            }
        });
    });

    $("#check_email").click(function() {
        var email = $("#email").val();
        var verifyCode = $("#VerificationStatus").val();
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            url: "/user/check_verify_code",
            type: "POST",
            data: {
                email: email,
                verifyCode: verifyCode
            },
            beforeSend: function(xhr) {
                if (token.length > 0 && header.length > 0)
                    xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                verifyCode = "verified"
                alert("인증 완료");
            },
            error: function() {
                verifyCode = "fail"
                alert("인증 실패");
            }
        });
    });
});
