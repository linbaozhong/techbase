<!DOCTYPE html>

<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<title>{{i18n .Lang "app title"}}</title>
		<meta id="description" name="description" content=""/>
		<meta property="qc:admins" content="6050272677640117256375" />

		<link rel="shortcut icon" href="/static/img/favicon.ico" />
		<link rel="stylesheet" type="text/css" href="/static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="/static/css/bootstrap.min.css">
		<!--<link rel="stylesheet" type="text/css" href="/static/css/non-responsive.min.css">-->
		<link rel="stylesheet" href="/static/css/reset.css">

		<script type="text/javascript">
			var snow = snow || {};
			function basicJsonp(json){
				snow.basic = json;
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
		</script>
		<script src="/item/basic/?callback=basicJsonp" type="text/javascript" charset="UTF-8"></script>
		<script src="/static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
		<script src="/static/js/common.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body style="background: none;">
		<header class="container abs-top abs-center" style="background: rgba(0, 0, 0, .6);">
			<nav style="height:65px;">
				<div class="navbar-header text-center">
					<a href="/">
						<img src="/static/img/logo001.png" alt="logo" style="margin-top: 2px;height: 60px;">
					</a>
				</div>
			</nav>
		</header>
		{{.LayoutContent}}

		<div id="footer_0" class="container " style="margin: 40px auto;">
			<div class="text-center" style="display:none;">
				<i class="fa fa-spinner fa-spin fa-2x"></i><span style="vertical-align: super;margin-left: 1em;">正在拼命地读取……</span>
			</div>
		</div>
		<footer class="container" id="footer">
				<div class="row copyright-div" style="border: none;">
					<p class="copyright">
						Copyright © TechBase. All Rights Reserved.
						<br>她本营TechBase 版权所有
					</p>
				</div>
		</footer>

	</body>

</html>
<script type="text/javascript">

	$(function() {

	});
</script>
