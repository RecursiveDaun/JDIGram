App.conversation = App.cable.subscriptions.create("ConversationChannel", {
    connected: function () {
    },

    disconnected: function () {
    },

    received: function (data) {
        data['message'] = data['message'].replace("http://example.org", "http://jdigram.herokuapp.com");
        let messages_div = $('#messages');
        messages_div.append(data['message']);
    },

});


$(document).on('turbolinks:load', function() {

    $('#send-message').on('click', function (e) {
        e.preventDefault();

        let message_text = $(`#new-message-text-area`).val();
        if ( message_text.empty ) {
            return
        }

        let conversation_id = $(this).data('conversation-id');
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