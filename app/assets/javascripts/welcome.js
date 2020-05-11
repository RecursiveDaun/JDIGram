// like_button
// likes-count-label
$(document).ready(function() {
    $("input[value='like-button']").click(function () {
        console.log("qwerty");
        $("#likes-count-label").val('Hello');
    })
});