function show_post_image_preview(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#image_preview').attr('src', e.target.result);
            $('#image_preview').css("width", "100%", "height", "100%");
            $('#post_image_label').text(input.files[0].name);
            window.scrollTo(0, document.body.scrollHeight);
        };
        reader.readAsDataURL(input.files[0]);
    }
}