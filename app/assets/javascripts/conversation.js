App.conversation = App.cable.subscriptions.create("ConversationChannel", {
    connected: function () {
    },

    disconnected: function () {
    },

    received: function (data) {
        let messages_div = $('#messages');
        messages_div.append(data['message']);
    },

});


$(document).on('turbolinks:load', function() {

    // Display sent message
    $('#send-message').on('click', function (e) {
        e.preventDefault();

        let message_text = $(`#new-message-text-area`).val();
        if ( message_text.empty ) {
            return
        }

        let conversation_id = $(this).attr('conversation_id');
        $.ajax({
            url: `/conversation/${conversation_id}/message`,
            type: 'POST',
            data: {
                message_text: message_text
            },
            success: function () {
                $(`#new-message-text-area`).val("");
            }
        })
    })

});