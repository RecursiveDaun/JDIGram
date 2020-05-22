$(document).on('turbolinks:load', function() {

    // Follow/Unfollow button tapped
    $('#follow-unfollow-button').on('click', function (e) {
        e.preventDefault();
        let profile_id = $(this).attr('profile_id');
        $.ajax({
            url: `/user_profile/${profile_id}/follow_unfollow`,
            type: 'POST'
        })
    });

});


function show_profile_avatar_preview(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#image_preview').attr('src', e.target.result);
            $('#image_preview').css("width", "100%", "height", "100%");
            $('#profile_avatar_label').text(input.files[0].name);
        };

        reader.readAsDataURL(input.files[0]);
    }
}