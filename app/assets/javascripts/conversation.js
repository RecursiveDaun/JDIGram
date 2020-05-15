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
            success: function (data) {
                $(`#new-message-text-area`).val("");
                $(`.messages-div`).append(`
                    <div class="row">
                        <div class="col-lg-2"> 
                            <label>${data.username}</label>
                        </div>    
                        <div class="col-lg-10">
                            <label>${message_text}</label>
                        </div>
                    </div>
                `);
            }
        })
    })

});