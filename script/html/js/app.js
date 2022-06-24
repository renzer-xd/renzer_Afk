document.addEventListener('DOMContentLoaded', function() {
    $('.menu').hide()
    $('.countdown').hide()

});
$(function() {

    window.addEventListener('message', function(event) {
        let data = event.data;
        if (data.type == 'show-menu') {
            if (data.enable) {
                $('.menu').fadeIn(300);
            } else {
                $('.menu').fadeOut(300);
            }
        } else if (data.type == 'show-countdown') {
            if (data.enable) {
                $('.countdown').fadeIn(300);
            } else {
                $('.countdown').fadeOut(300);
            }
        } else if (data.type == 'update') {
            if (Number(data.Minute) < '10') {
                $('#playMinute').html(`0${data.Minute}`);
            } else {
                $('#playMinute').html(data.Minute);
            }
            if (Number(data.Sec) < 10) {
                $('#playSec').html(`0${data.Sec}`);
            } else {
                $('#playSec').html(data.Sec);
            }

        }
    });
    $('.grid').on('click', '#afk1', function() {
        $('.menu').fadeOut(300);
        $.post(`https://renzer_Afk/getstatus`, JSON.stringify({
            key: 1
        }));
    });
    $('.grid').on('click', '#afk2', function() {
        $('.menu').fadeOut(300);
        $.post(`https://renzer_Afk/getstatus`, JSON.stringify({
            key: 2
        }));
    });
    $('.grid').on('click', '#afk3', function() {
        $('.menu').fadeOut(300);
        $.post(`https://renzer_Afk/getstatus`, JSON.stringify({
            key: 3
        }));
    });
});

function close() {
    $('.menu').fadeOut(300);
    $('.countdown').fadeOut(300);
    $.post(`https://renzer_Afk/close`, JSON.stringify({}));
}
document.onkeyup = function(data) {
    if (data.which == 27) {
        close()
    }
};