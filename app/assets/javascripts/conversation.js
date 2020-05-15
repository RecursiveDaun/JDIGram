$(document).on('turbolinks:load', function() {
    // $('.conversation-index-row').on('click', function (e)  {
    //     open_conversation($(this).attr('conversation_id'));
    // })
});

function open_conversation(conversation_id) {
    console.log('into open_conversation');
    $.ajax({
        url: `/conversations/${conversation_id}/show`,
        type: 'GET'
    })
}