$(function () {
    $(document).on("submit", ".form-callback", function (event) {
        event.preventDefault();
        var $formData = new FormData();
        $formData.append('ajax', 1);
        $formData.append('name', $('.form-callback [name=name]').val());
        $formData.append('email', $('.form-callback [name=email]').val());
        $formData.append('phone', $('.form-callback [name=phone]').val());
        $formData.append('enquiry', $('.form-callback [name=enquiry]').val());
        $formData.append('agree', $('.form-callback [name=agree]').prop('checked') * 1);
        jQuery.ajax({
            url: '/index.php?route=information/contact',
            type: 'POST',
            contentType: false,
            processData: false,
            data: $formData,
            dataType: "text", //"json",
            success: function (data) {
                $("#popup__formWrapper").html(data)
            },
        });
    });
});