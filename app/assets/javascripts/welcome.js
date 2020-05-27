$(document).on('turbolinks:load', function() {

    if ($('.pagination').length && $('#news_feed').length) {
        $(window).scroll(function() {
            let url = $('.pagination .next_page').attr('href');
            if (url) {
                $('.pagination').text();
            } else {
                $('.pagination').text("No more posts");
            }
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                $('.pagination').text("Looking for a new posts");
                return $.getScript(url);
            }
        });
        $(window).scroll();
    } else {
        $('.pagination').text("No more posts");
    }

});

// Like clicked
$(document).on('click', '.like-link', function(e) {
    e.preventDefault();
    let post_id = $(this).attr('post_id');
    $.ajax({
        url: `/posts/${post_id}/on_like_clicked`,
        type: 'GET'
    })
});


// Add comment clicked
$(document).on('click', '#add-comment-button', function(e) {
    e.preventDefault();
    let post_id = $(this).data('post-id');
    $.ajax({
        url: `/posts/${post_id}/add_comment`,
        type: 'POST',
        data: {
            comment_text: $(`#comment-text-area-${post_id}`).val()
        }
    })
});