$(document).ready(function() {
    $(function() {
        $(".date-field").datepicker({
            dateFormat: 'yy-mm-dd'
        });
    });
    $("#expense_description").autocomplete({
        source: "/expenses/descriptions",
    });
});
