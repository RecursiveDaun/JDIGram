$(document).ready(function() {
    $('.like-link').on('click', function(e) {
        e.preventDefault();
        let post_id = $(this).attr('post_id')
        $.ajax({
            url: `/posts/${post_id}/on_like_clicked`,
            type: 'GET',
            success: function (data) {
                $(`#likes-count-label-${post_id}`).text(data.likes_count)
            }
        })
    });

    $('.add-comment-link').on('click', function (e) {
        e.preventDefault();
        let post_id = $(this).attr('post_id');
        $.ajax({
            url: `/posts/${post_id}/add_comment`,
            type: 'POST',
            data: {
                comment_text: $(`#comment-text-area-${post_id}`).val()
            },
            success: function (data) {
                $(`#comments-to-post-${post_id}`).append(`
                    <div class="row comment-row">
                        <div class="col-lg-12">
                            <a href="/profile/${data.user_profile_id}">${data.username}</a>
                            <br>
                            <label>${data.comment_text}</label>
                        </div>
                    </div>
                `)
            }
        })
    })

});