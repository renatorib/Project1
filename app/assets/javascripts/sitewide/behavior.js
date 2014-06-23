cleanErrors = function () {
	$("div[class*='has-error'] > ul").remove();
	$("div[class*='has-error']").removeClass("has-error");		
}

cleanValues = function() {
	$("div[class*='form-group']").children().val("")
}

$(function () {
    $('.input-group.date').datetimepicker({
        language: 'pt-BR',
        pickTime: false,
        showToday: true,
        icons: {
	        time: 'glyphicon glyphicon-time',
	        date: 'glyphicon glyphicon-calendar',
	        up:   'glyphicon glyphicon-chevron-up',
	        down: 'glyphicon glyphicon-chevron-down'
	    	}
    });
});