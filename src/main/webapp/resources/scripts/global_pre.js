/**
 * @requires function: không nẳm trong addEventListener nào
 * @requires backend: trả về một message box, nên là popup 
 * @param {String} formId mã id của form (bắt buộc)
 */
function submitFormAndGetMessage(formId) {
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById(formId);

        if (!form) {
            return;
        }

        form.addEventListener('submit', function (event) {
            event.preventDefault();

            customSubmitForm(form);
        });
    });
}

function submitClosestForm(buttonElement, action) {
    // Find the closest form ancestor to the button and submit it
    const form = buttonElement.closest('form');
    if (form) {
        customSubmitForm(form, action);
    } else {
        console.error('No form found to submit.');
    }
}

function customSubmitForm(form, action) {
    // Convert FormData to URL-encoded string
    const formData = new FormData(form);
    const formDataSerialized = new URLSearchParams(formData).toString();

    // Send the form data using fetch API with the correct headers
    fetch(form.action, {
        method: form.method,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded', // Set the content type
        },
        body: formDataSerialized,
    })
        .then(response => {
            if (response.ok)
                form.reset()
            return response.text()
        }) // Assuming the server responds with text
        .then(text => {
            // Display the response text in a message box on the page
            const messageBox = document.createElement('div');
            messageBox.innerHTML = text; // Display the server response
            document.body.appendChild(messageBox);
            if (action && typeof action === 'function') {
                action();
            }
            return true;

        })
        .catch(error => { console.error('Error:', error); return false });
}
