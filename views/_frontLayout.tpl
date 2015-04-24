<!DOCTYPE html>

<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">
		<title>{{i18n .Lang "app title"}}</title>
		<meta property="qc:admins" content="6050272677640117256375" />
		<link rel="stylesheet" href="/static/css/pinghei.css">
		<link rel="shortcut icon" href="/static/img/favicon.ico" />
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.3.0/css/font-awesome.min.css" />
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<!--<link rel="stylesheet" href="/static/css/default.css">-->
		<script type="text/javascript">
			var snow = {};
		</script>
		<link rel="stylesheet" href="/static/css/reset.css">
		<script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.3/jquery.min.js"></script>
		<script src="/static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
		<script src="/static/js/common.js" type="text/javascript" charset="utf-8"></script>
		<!--<script type="text/javascript" src="/static/js/jquery.mousewheel.js"></script>-->
		<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
	</head>

	<body>
		<header class="navbar-fixed-top">
			<div class="container">
				<nav style="height:65px;">
					<div class="navbar-header">
						<a class="navbar-brand" href="/" style="padding:0;">
							<img src="/static/img/logo001.png" class="img-responsive" alt="logo">
						</a>
					</div>
					<ul class="nav navbar-nav" style="margin-left:40px;">
						<li {{if eq .index "index"}} class="active" {{end}}><a href="/">她首页</a>
						</li>
						<li class="tachuangtou {{if eq .index " brandshow "}}active {{end}}"><a href="javascript:;">她创投</a>
						</li>
						<li class="{{if eq .index " media "}} active {{end}}"><a href="/media">她媒体</a>
						</li>
						<li class="{{if eq .index " community "}} active {{end}}"><a href="/community">她社区</a>
						</li>
						<li {{if eq .index "home"}} class="active" {{end}}><a href="/home">她本营</a>
						</li>

					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="login"><a href="javascript:;">登录</a>
						</li>
						<li id="avatar" class="snow-profile" style="display:none;">
							<a href="javascript:;"><img src="" style="width:19px;height:19px;" />
							<span class="nickname">
							</span></a>
						</li>
						<li id="logout" class="snow-profile" style="display:none;">
							<a href="javascript:;">注销</a>
						</li>
						<li class="guanzhuwe">
							<a href="javascript:;">关注我们</a>
						</li>
					</ul>
				</nav>
			</div>
			<div class="nav-children">
				<ul class="nav-children-li">
					<li><a href="/xiangmu">项目</a>
					</li>
					<li><a href="/touziren">投资人</a>
					</li>
				</ul>
			</div>
		</header>

		<div class="header-ermeima">
			<img src="/static/img/weixin-qr.png">
			<div class="co-card">
				<p>扫描二维码关注我们</p>
				<p>微信公众号 TechBase她本营</p>
				<p>邮件 techbase@tabenying.com</p>
			</div>
		</div>
		{{.LayoutContent}}
		<!--END container-->
		<div id="footer_0" style="margin-top:35px;">
		</div>
		<footer class="row" id="footer">
			<div class="col-md-2 col-sm-2 row"></div>
			<div class="col-md-8 col-sm-8">
				<div class="row">
					<div class="col-md-4 col-sm-12">
						<p class="qr">
							<img class="img-responsive" src="/static/img/weixin-qr.png">
						</p>
						<p class="wx">微信公众号：TechBase她本营</p>
					</div>
					<div class="col-md-5 col-sm-12">
						<h4>公司信息</h4>
						<p>公司：她本营网络科技有限公司</p>
						<p>地址：北京市朝阳区方恒国际中心D座2317室</p>
						<p>邮件：techbase@tabenying.com</p>
					</div>
					<div class="col-md-3 col-sm-12">
						<h4>友情链接</h4>
						<p><a href="http://leanin.org/">Lean In</a>
						</p>
						<p><a href="http://www.sycapital.cn/">松源资本</a>
						</p>
						<p><a href="http://www.36kr.com/">36Kr</a>
						</p>
						<p><a href="http://itjuzi.com/">IT桔子</a>
						</p>
					</div>
				</div>
				<div class="row copyright-div">
					<p class="copyright">
						Copyright © TechBase. All Rights Reserved.
						<br>她本营TechBase 版权所有
					</p>
				</div>
			</div>
			<div class="col-md-2 col-sm-2 row text-right">
				<a class="hidden" id="go-top" href="javascript:;">
					<i class="fa fa-angle-up"></i>
				</a>
			</div>
		</footer>
		<div class="x-data">
			
		</div>
	</body>

</html>
<script type="text/javascript">

	$(function() {
		var isover = false;
		// 联系我们
		$(".guanzhuwe").hover(function(e) {
			var _this = $(this);
			if ($(window).width() - _this.offset().left >= $(".header-ermeima").outerWidth() + 10) {
				$(".header-ermeima").css({
					'left': _this.offset().left,
					'right': 'inherit'
				}).show();
			} else {
				$(".header-ermeima").css({
					'right': 10,
					'left': 'inherit'
				}).show();
			}
		}, function() {
			$(this).css("border-bottom", "none");
			$(".header-ermeima").hide();
		});
		// 他创投
		function mouseleave() {
			setTimeout(function() {
				if (!isover) {
					$("div.nav-children").stop().delay(500).fadeOut();
				}
			}, 500);
		};
		$(".tachuangtou").hover(function(e) {
			var _this = $(this);
			$("ul.nav-children-li").css({
				'margin-left': _this.offset().left
			});
			$("div.nav-children").stop().fadeIn();
		}, function() {
			isover = false;
			mouseleave();
		});
		$("div.nav-children").hover(function(e) {
			isover = true;
		}, function(e) {
			isover = false;
			mouseleave();
		});
		// 页脚自适应沉底，页眉自适应浮动
		$(window).resize(function() {
			// 页脚
			var _footer_0 = $('#footer_0'),
				_footer = $('#footer');
			_footer.addClass('fixfooter');
			if (_footer_0.offset().top > _footer.offset().top) {
				_footer.removeClass('fixfooter');
			}
		}).scroll(function() {
			if ($(document).scrollTop() > 50) {
				$('header.navbar-fixed-top').addClass('header_shadow');
				$('#go-top').removeClass('hidden');
			} else {
				$('header.navbar-fixed-top').removeClass('header_shadow');
				$('#go-top').addClass('hidden');
			}
		}).resize();
		// 
		$('#go-top').click(function() {
			$('html,body').animate({
				scrollTop: 0
			});
		});
		// 登录
		function signin(){
			$('#signin').popWindow({
				width: 600,
				height: 560,
				close: '<span><i class="fa fa-times"></i></span>'
			});
		};
		
		$('.login').click(function() {
			if ($('#signin').length) {
				signin();
			}else{
				$('.x-data').load('/static/inc/weixin.html',function(){
					signin();
				});
			}
		});
		// 签出
		$('#logout').click(function(){
			$.post('/signout',function(json){
				if (json.ok) {
					//snow.checkin(false);
					window.location = window.location;
				}
			});
		});
		// 检查是否已经登录
		snow.checkin = function(state){
			if (state && $.cookie('_snow_token') && $.cookie('_snow_token').length) {
				var _avatar = $('#avatar');
				_avatar.find('img').attr('src', $.cookie('avatar'));
				_avatar.find('.nickname').text($.cookie('nickname'));
				$('.snow-profile').show();
				$('.login').hide();
//				//记录登录状态
//				$.post('/connect/signtrace', {
//					from: $.cookie('from'),
//					token: $.cookie('token'),
//					openId: $.cookie('openid'),
//					nickName: $.cookie('nickname'),
//					avatar_1: $.cookie('avatar')
//				}, function(d) {
//					if (d.ok) {
//						console.log('Successfully login');
//					}else{
//						console.log('Login failed');
//					}
//				});
			} else {
				$('.snow-profile').hide();
				$('.login').show();
			}
		};
		snow.checkin(true);
	});
</script>