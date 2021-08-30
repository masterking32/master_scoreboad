$(function() {
	$('.wrap').hide();
	window.addEventListener('message', function(event) {
		switch (event.data.action) {
			case 'enable':
				$('.steamname').html(event.data.serverdata.steamname);
				$('.userID').html(event.data.serverdata.userID);
				$('.job').html(event.data.serverdata.job);
				$('.money').html(event.data.serverdata.money);
				$('.bankmoney').html(event.data.serverdata.bankmoney);
				
				$('.uptime').html(event.data.serverdata.uptime.days + " Days " + event.data.serverdata.uptime.hours + " Hours " + event.data.serverdata.uptime.minutes + " Minutes " + event.data.serverdata.uptime.secs + " Secs");
				$('.onlines').html(event.data.serverdata.onlines);
				$('.queue').html(event.data.serverdata.queue);
				$('#police').html(event.data.serverdata.police);
				$('#sheriff').html(event.data.serverdata.sheriff);
				$('#ambulance').html(event.data.serverdata.ambulance);
				$('#mechanic').html(event.data.serverdata.mechanic);
				$('#taxi').html(event.data.serverdata.taxi);
				$('#admins').html(event.data.serverdata.admins);
				
				$('.wrap').show();
				break;
			case 'disable':
				$('.wrap').hide();
				break;
			default:
				break;
		}
	});
});