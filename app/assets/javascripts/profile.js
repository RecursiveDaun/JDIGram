$(document).on('turbolinks:load', function() {

    // Follow/Unfollow button tapped
    $('#follow-unfollow-button').on('click', function (e) {
        e.preventDefault();
        let profile_id = $(this).attr('profile_id');
        $.ajax({
            url: `/profile/${profile_id}/follow_unfollow`,
            type: 'POST',
            success: function (data) {
                console.log(data);
                $('#follow-unfollow-button').empty();
                // If the user follow to the other user
                if (data.is_follow) {
                    $('#follow-unfollow-button').html("<i class=\"fa fa-user-minus\"> </i>");
                    $('#follow-unfollow-button').css("background-color", "#6c757d", "border-color", "#545b62");
                } else {
                    $('#follow-unfollow-button').html("<i class=\"fa fa-user-plus\"> </i>");
                    $('#follow-unfollow-button').css("background-color", "#0069d9", "border-color", "#0062cc");
                }
            }
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