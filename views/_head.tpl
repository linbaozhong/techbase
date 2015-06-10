		<meta property="qc:admins" content="6050272677640117256375" />
		<!--<link rel="stylesheet" href="/static/css/pinghei.css">-->
		<link rel="shortcut icon" href="/static/img/favicon.ico" />
		<link rel="stylesheet" type="text/css" href="/static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="/static/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="/static/css/non-responsive.min.css">
		<link rel="stylesheet" href="/static/css/reset.css">
		<!--<link rel="stylesheet" href="/static/css/default.css">-->
		<script type="text/javascript">
			var snow = snow || {};
			function basicJsonp(json){
				snow.basic = json;
				//console.log(snow.basic);
			}
			snow.writeJs = function(jsurl){
				var _script = document.createElement('script');
				_script.setAttribute('src',jsurl);
				document.getElementsByTagName('head')[0].appendChild(_script);
			};
		</script>
		<script src="/static/js/device.min.js"></script>
		<script type="text/javascript" src="/static/js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
			snow.isMobile = device.mobile();
//			if (device.mobile() || device.tablet()) {
//				document.writeln('');
//				snow.writeJs('');
//			}
		</script>
		<script src="/item/basic/?callback=basicJsonp" type="text/javascript" charset="UTF-8"></script>
		<script src="/static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
		<script src="/static/js/common.js" type="text/javascript" charset="utf-8"></script>
