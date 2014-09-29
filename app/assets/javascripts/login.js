$('document').ready(function(){
	$("#sign-up").click(function(e){
		$('#login-dialog').addClass('login-overlay');
		$("#register-dialog").show();
	});	
	
	$("#register-close").click(function(e){
		$('#login-dialog').removeClass('login-overlay');
		$("#register-dialog").hide();
	});
});

function sign_in(url){
	var d = $('#login_form').serialize(); // get the form data

	$.ajax(url, {
		data: d,
		type: 'POST',
		success: function(json) {
			// console.log('ok! > \'' + JSON.stringify(json) + '\'');
			if(json.success){
				window.location = json.url;
			} else{
				$("#login_form").addClass("has-error");
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			var json = xhr.responseJSON;
			// console.log('FAIL! > \'' + JSON.stringify(json) + '\'');
			$("#login_form").addClass("has-error");
		}
	});
}

function sign_up(url){
	var d = $('#register_form').serialize();

	$.ajax(url, {
		data: d,
		type: 'POST',
		success: function(json) {
			// console.log('ok! > \'' + JSON.stringify(json) + '\'');
			if(json.success){
				window.location = json.url;
			} else{
				$("#login_form").addClass("has-error");
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			var json = xhr.responseJSON;
			// console.log('FAIL! > \'' + JSON.stringify(json) + '\'');
			$("#login_form").addClass("has-error");
		}
	});
}
