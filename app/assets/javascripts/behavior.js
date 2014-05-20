cleanErrors = function () {
	$("div[class*='has-error'] > ul").remove();
	$("div[class*='has-error']").removeClass("has-error");		
}

cleanValues = function() {
	$("div[class*='form-group']").children().val("")
}