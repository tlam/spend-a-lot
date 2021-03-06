Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

function drawCategory() {
    var category_id = $("#category-id").val();
    var category_name = $("#category-name").val();
    var category_slug = $("#category-slug").val();

    if (category_id == undefined || category_name == undefined || category_slug == undefined) {
        return 0;
    }

    // Create and populate the data table.
    var data = new google.visualization.DataTable();
        
    data.addColumn("string", category_name);
    data.addColumn("number", category_name); 
       
    $.getJSON("/trends/" + category_slug + ".json", function(monthly_data) {
        data.addRows(Object.size(monthly_data));

        var j = 0;
        $.each(monthly_data, function(month, dict) {
            data.setValue(j, 0, month.toString());
            data.setValue(j, 1, parseFloat(dict.sum));
            ++j;
        });

        // Create and draw the visualization.
        new google.visualization.ColumnChart(document.getElementById('category')).
            draw(data,
                 {title: category_name + " spending by month", 
                  width:800, height:400,
                  hAxis: {title: "Month"},
                  vAxis: {title: "Amount"}}
            );
    });
}
google.setOnLoadCallback(drawCategory);
