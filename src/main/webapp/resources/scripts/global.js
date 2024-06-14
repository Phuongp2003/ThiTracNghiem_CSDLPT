/**
 * @usage: if (condtion) { e.preventDefault(); showMessage(message, type); }
 * @param {String} message message need to send
 * @param {String} type message type: info(default), success, warn, error
 */
function showMessage(message, type, element) {
    var typeClass;
    switch (type) {
        case "success":
            typeClass = "alert-success";
            break;

        case "info":
            typeClass = "alert-info";
            break;

        case "warning":
            typeClass = "alert-warning";
            break;

        case "error":
            typeClass = "alert-danger";
            break;

        default:
            typeClass = "alert-info";
            break;
    }
    var messageDiv = $(
        '<div class="col-sm-8 alert ' + typeClass + ' w-100 message-box" role="alert">' +
        message +
        '<button type="button" class="rem message-box--button" data-dismiss="alert" aria-label="Close">&times;</button>' +
        '</div>'
    );
    if (!element) element = ".message-place";
    $(element).html(messageDiv);

    messageDiv.find('button').on('click', function () {
        messageDiv.remove();
    });

    setTimeout(function () {
        messageDiv.remove();
    }, 10000);
}

/**
 * @usage: sendmessage and prevent event
 * @param {boolean} condtion message reason
 * @param {String} message message need to send
 * @param {String} type message type: info(default), success, warn, error
 * @returns alway false
 */
function sendMessage(condtion, message, type, element) {
    if (condtion) {
        showMessage(message, type, element);
    }
}
