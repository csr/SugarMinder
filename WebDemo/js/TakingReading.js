$(document).ready(function() {
	$(".form-input").submit(function(e) {
		return false;
	});
	$("#submit-button").on("click", function(e) {

		var value = parseInt($("#input").val(), 10);
		console.log(value);
		$.ajax({
			method: "POST",
			headers: {
		        'Content-Type': 'application/json',
		       	'X-Parse-REST-API-Key': 'GUuHPCS51E2o2L6UwV4WObQqiMU9G7OWvmLoHoE5',
		    	'X-Parse-Application-Id': 'Yde7k8UELzQgvldmV7aAVqWKtU3k8vpgh0QEdyXZ'
		    },
		    data: JSON.stringify({
		        "bloodSugar": value
		    }),
		    dataType: 'json',
		    url: "https://api.parse.com/1/classes/AppData",
		    success: function(response_data, status, request) {
		        console.log(response_data);
		    },
		    error: function(request, status, error) {
		        console.log(error);
		    }
		});
	});

});