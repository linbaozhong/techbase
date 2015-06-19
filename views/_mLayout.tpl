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
		<script src="/static/js/jquery.touchSwipe.min.js"></script>
		<script type="text/javascript">
			snow.isMobile = device.mobile();
		</script>
		<script src="/item/basic/?callback=basicJsonp" type="text/javascript" charset="UTF-8"></script>
		<script src="/static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
		<script src="/static/js/common.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			.snow-submenu a{
				color: #fff;
			}
		</style>
	</head>

	<body style="background: none;">
		<header class="container abs-top abs-center" style="background: rgba(0, 0, 0, .6);">
			<nav style="height:65px;">
				<div class="navbar-header">
					<a href="/">
						<img src="/static/img/logo001.png" alt="logo" style="margin-top: 2px;height: 60px;">
					</a>
					<a class="pull-right snow-menu" href="#" style="color:#fff;margin-top: 18px;">
						<i class="fa fa-bars fa-2x"></i>
					</a>
				</div>
			</nav>
			<div class="snow-menu-wrap" style="position:fixed;top:0;right:0;bottom:0;left:0;background-color:rgba(0, 0, 0, .4);display: none;">
				<div class="snow-submenu" style="width: 100px;height: 100%;padding:40px 20px;margin-left: auto;margin-right: -100px;font-size:1.2em;line-height: 2.5em;background-color: #333;">
					<ul>
						<li><a href="/">她首页</a></li>
						<li><a href="/media">她媒体</a></li>
						<li><a href="/item/index">她项目</a></li>
						<li><a href="/vc">她ＶＣ</a></li>
						<li><a href="/community">她社区</a></li>
						<!--<li style="height:1em;"></li>
						<li><a href="">登录</a></li>-->
					</ul>
				</div>
			</div>
		</header>
		{{.LayoutContent}}

		<div id="footer_0" class="container row" style="margin:0 auto;padding:10px 0;">
			<div class="text-center snow-color-red" style="display:none;">
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
		$('a.snow-menu').click(function(){
			$('.snow-menu-wrap').fadeIn(function(){
				$('.snow-submenu').animate({
					marginRight:0
				});
			});
		});
		
		//
		function showMenu(){
			$('.snow-menu-wrap').fadeIn();
			$('.snow-submenu').animate({
				marginRight:0
			});
		}
		function hideMenu(){
			$('.snow-submenu').animate({
				marginRight:-100
			});	
			$('.snow-menu-wrap').fadeOut();
		}
		$('body').swipe({
			swipeLeft:function(event, direction, distance, duration, fingerCount, fingerData) {
				showMenu();
			},
	       	swipeRight:function(event, direction, distance, duration, fingerCount, fingerData) {
	       		hideMenu();
	       	},
	       	tap:function(event,target){
	       		hideMenu();
	       	}
		});
	});
</script>
