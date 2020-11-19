$(document).on('turbolinks:load', function() {
    console.log("load select2");
    $("#invoice_campaigns").select2({
        theme: "bootstrap"
    });
});
