$(document).ready(function () {

    $('#resetPasswordBtn').click(function () {
        $('#resetPasswordModal').modal('show');
    });


    $('#resetPasswordForm').submit(function (event) {
        event.preventDefault();

        var currentPassword = $('#current_password').val();
        var newPassword = $('#new_password').val();
        var newPasswordConfirm = $('#new_password_confirm').val();

        if (newPassword !== newPasswordConfirm) {
            alert('새 비밀번호가 일치하지 않습니다.');
            return;
        }

        var data = {
            currentPassword: currentPassword,
            newPassword: newPassword
        };

        $.ajax({
            type: 'PUT',
            url: '/api/user/password',
            contentType: 'application/json',
            data: JSON.stringify(data)
        }).done(function () {
            alert('비밀번호가 변경되었습니다.');
            $('#resetPasswordModal').modal('hide');
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    });
});