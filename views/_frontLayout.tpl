<!DOCTYPE html>

<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">-->
		<title>{{i18n .Lang "app title"}}</title>
		{{.Head}}
	</head>

	<body>
		<header class="abs-top">
			<div class="container">
				<nav style="height:65px;margin-top: 20px;">
					<div class="navbar-header">
						<!--<button class="navbar-toggle" data-target="xs-nav"><i class="fa fa-bars"></i></button>-->
						<a class="navbar-brand" href="/">
							<!--<span class="visible-xs-block">TECHBASE</span>-->
							<img src="/static/img/logo001.png" class="img-responsive" alt="logo" style="margin-top: -12px;height: 60px;">
						</a>
					</div>
					<ul class="nav navbar-nav" style="margin-left:80px;">
						<li {{if eq .index "index"}} class="active" {{end}}><a href="/">她首页</a>
						</li>
						<li class="menu {{if eq .index " brandshow "}}active {{end}}" data-rel = "submenu-1"><a href="javascript:;">她创投</a>
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
						<li id="avatar" class="menu snow-profile" style="display:none;" data-rel = "submenu-0">
							<a href="javascript:;"><img class="img-circle" src="" />
							<span class="nickname">
							</span></a>
						</li>
						<!--<li class="menu" data-rel = "submenu-2">
							<a href="javascript:;">关注我们</a>
						</li>-->
					</ul>
				</nav>
			</div>
		</header>
		<div class="submenu submenu-0">
			<i class="fa fa-caret-up"></i>
			<ul class="">
				<li><a href="/my/profile">我的帐号</a>
				</li>
				<li><a href="/my/company">我的项目</a>
				</li>
				<li><a href="/my/touzi">我的投资</a>
				</li>
				<li id="logout"><a href="javascript:;">退出</a>
				</li>
			</ul>
		</div>
		<div class="submenu submenu-1">
			<i class="fa fa-caret-up"></i>
			<ul class="">
				<li><a href="/xiangmu">项目</a>
				</li>
				<li><a href="/touziren">投资人</a>
				</li>
			</ul>
		</div>
		<div class="text-center" style="position: fixed;top: 200px;right: 0;background: #fff;padding: 10px;font-size: 12px;border: 1px solid #eee;z-index: 1000;">
			<img src="/static/img/weixin-qr.png" style="width: 140px;">
			<div class="co-card">
				<p>用微信扫描</p>
				<p>关注 TechBase她本营</p>
				<a href="mailto://techbase@tabenying.com">给我们发邮件 </a>
			</div>
		</div>
		<!--<div class="submenu submenu-2">
			<i class="fa fa-caret-up"></i>
			<img src="/static/img/weixin-qr.png">
			<div class="co-card">
				<p>扫描二维码关注我们</p>
				<p>微信公众号 TechBase她本营</p>
				<p>邮件 techbase@tabenying.com</p>
			</div>
		</div>
		<div id="xs-nav" class="hidden-md hidden-lg" style="margin-top: 65px;margin-bottom: -60px;display: none;">
			<ul class="" style="margin-left:40px;">
				<li {{if eq .index "index"}} class="active" {{end}}><a href="/">她首页</a>
				</li>
				<li class="menu {{if eq .index " brandshow "}}active {{end}}" data-rel = "submenu-1"><a href="javascript:;">她创投</a>
				</li>
				<li class="{{if eq .index " media "}} active {{end}}"><a href="/media">她媒体</a>
				</li>
				<li class="{{if eq .index " community "}} active {{end}}"><a href="/community">她社区</a>
				</li>
				<li {{if eq .index "home"}} class="active" {{end}}><a href="/home">她本营</a>
				</li>
			</ul>
		</div>-->
		{{.LayoutContent}}
		<!--END container-->
		{{.Footer}}
	</body>

</html>
<script type="text/javascript">

	$(function() {
		// 他创投
		function mouseleave(obj) {
			setTimeout(function() {
				if (obj.data('hide')) {
					obj.stop().slideUp('fast');
				}
			}, 100);
		};
		
//		$('button.navbar-toggle').click(function(){
//			var _self=$(this);
//			if (_self.data('expanded')) {
//				$('#xs-nav').hide();
//				_self.data('expanded',false)
//			} else{
//				$('#xs-nav').show();
//				_self.data('expanded',true)
//			}
//		});
		
		$(".menu").hover(
			function(e) {
				var _this = $(this),_target = $('.'+_this.data('rel')).data('hide',false);
				
				if ($(window).width() - _this.offset().left >= _target.outerWidth() + 10) {
					_target.css({
						'left': _this.offset().left-((_target.outerWidth()-_this.outerWidth())/2),
						'right': 'inherit'
					}).slideDown('fast');
				} else {
					_target.css({
						'right': 10,
						'left': 'inherit'
					}).slideDown('fast');
				}
			}, 
			function() {
				var _this = $(this),_target = $('.'+_this.data('rel')).data('hide',true);
				mouseleave(_target);
			}
		);

		$(".submenu").hover(function(e) {
			$(this).data('hide',false)
		}, function(e) {
			mouseleave($(this).data('hide',true));
		});
		
//		// 页脚自适应沉底，页眉自适应浮动
//		function footerBottom(){
//			// 页脚
//			var _footer_0 = $('#footer_0'),
//				_footer = $('#footer');
//			_footer.addClass('navbar-fixed-bottom');
//			if (_footer_0.offset().top > _footer.offset().top) {
//				_footer.removeClass('navbar-fixed-bottom');
//			}
//		};
//		setTimeout(footerBottom,400);
		
		$(window).resize(function() {
			//footerBottom();
		}).scroll(function() {
			if ($(document).scrollTop() > 50) {
				//$('header.navbar-fixed-top').addClass('header_shadow');
				$('#go-top').removeClass('hidden');
			} else {
				//$('header.navbar-fixed-top').removeClass('header_shadow');
				$('#go-top').addClass('hidden');
			}
		});
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
				$('.x-data').load('/connect/weixin',function(){
					signin();
				});
			}
		});
		// 签出
		$('#logout').click(function(){
			$.post('/signout',function(json){
				if (json.ok) {
					//snow.checkin(false);
					window.location = "/";
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
<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
