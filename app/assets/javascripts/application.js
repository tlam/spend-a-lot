$(document).ready(function() {
    $(function() {
        $(".date-field").datepicker({
            dateFormat: 'yy-mm-dd'
        });
    });

    $("#expense_description").autocomplete({
        source: "/expenses/descriptions",
    });

    $("#expense_description").focusout(function() {
        var description = $(this).val();
        $.getJSON("/categories/ajax-by-keyword.json", {"description": description}, function(data) {
            var category_id = data.category;
            if (category_id) {
                $("#expense_category_id").val(category_id);
            }
        });
    });
});
