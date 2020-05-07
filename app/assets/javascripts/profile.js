function show_image_preview(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#image_preview').attr('src', e.target.result);
            $('#image_preview').css("width", "100%", "height", "100%");
            // $('#image_preview').css("border-radius", "50%");
        };

        reader.readAsDataURL(input.files[0]);
    }
}