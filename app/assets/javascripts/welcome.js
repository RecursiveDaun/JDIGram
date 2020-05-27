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
    console.log("add comment");
    $.ajax({
        url: `/posts/${post_id}/add_comment`,
        type: 'POST',
        data: {
            comment_text: $(`#comment-text-area-${post_id}`).val()
        },
        success: function (data) {
            console.log(post_id);
            $(`#comment-text-area-${post_id}`).val("");
            $(`#comments-to-post-${post_id}`).append(`
                <div class="row">
                    <div class="col-lg-12">
                        <a href="/profile/${data.author_id}" class="comment-author"> ${data.username} </a>
                        <span class="comment-body">${data.comment_text}</span>
                    </div>
                </div>
            `);
        }
    })
});