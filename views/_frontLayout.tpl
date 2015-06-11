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
		<header class="container abs-top abs-center" style="background: rgba(0, 0, 0, .4);">
			<nav style="height:65px;margin-top: 10px;  padding: 0 20px;">
				<div class="navbar-header">
					<a class="navbar-brand" href="/">
						<img src="/static/img/logo001.png" class="img-responsive" alt="logo" style="margin-top: -15px;height: 60px;">
					</a>
				</div>
				<ul class="nav navbar-nav" style="margin-left:60px;">
					{{if eq .index "index"}}
						<li class="active" ><a href="javascript:;">她首页</a></li>
					{{else}}
						<li><a href="/">她首页</a></li>
					{{end}}
					{{if eq .index "media"}}
						<li class="active"><a href="javascript:;">她媒体</a></li>
					{{else}}
						<li><a href="/media">她媒体</a></li>
					{{end}}
					{{if eq .index "items"}}
						<li class="active "><a href="javascript:;">她项目</a></li>
					{{else}}
						<li><a href="/item/index">她项目</a></li>
					{{end}}
					{{if eq .index "vc"}}
						<li  class="active" ><a href="javascript:;">她ＶＣ</a></li>
					{{else}}
						<li><a href="/vc">她ＶＣ</a></li>
					{{end}}
					{{if eq .index "community"}}
						<li class="active"><a href="javascript:;">她社区</a></li>
					{{else}}
						<li><a href="/community">她社区</a></li>
					{{end}}
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
		</header>
		<div class="submenu submenu-0">
			<span class="caret-up"></span>
			<ul class="">
				<li><a href="/my/profile">我的帐号</a>
				</li>
				<li><a href="/my/company">我的项目</a>
				</li>
				<!--<li><a href="/my/touzi">我的投资</a>
				</li>-->
				<li><hr style="margin: 5px 0;" /></li>
				<li id="logout"><a href="javascript:;">退出</a>
				</li>
			</ul>
		</div>
		<!--<div class="submenu submenu-1">
			<i class="fa fa-caret-up"></i>
			<ul class="">
				<li><a href="/xiangmu">项目</a>
				</li>
				<li><a href="/touziren">投资人</a>
				</li>
			</ul>
		</div>-->
		<div class="text-center weixin-public" style="position: fixed;top: 350px;right: 0;background: #fff;font-size: 12px;z-index: 1000;">
			<div class="co-card" style="border: 1px solid #f56f74;">
				<img src="/static/img/weixin-qr.png" style="width: 140px;">
				<p>扫描关注微信号</p>
			</div>
			<div class="" style="color: #fff;background: #f56f74;margin-top: 2px;padding: 5px;">
				<a href="mailto://techbase@tabenying.com" style="color: inherit;">给我们发邮件 </a>
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
		
		// 全部图片加载完成后，重置页脚
		$('img').load(function(){
			snow.footerBottom();
		});
		setTimeout(snow.footerBottom,500);
		
		$(window).resize(function() {
			snow.footerBottom();
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
			// 移动端
			if(snow.isMobile){
				window.open('/connect/Wx_Login','weixin_login')
			}else{
				if ($('#signin').length) {
					signin();
				}else{
					$('.x-data').load('/connect/weixin',function(){
						signin();
					});
				}
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
				return true;
			} else {
				$('.snow-profile').hide();
				$('.login').show();
				return false;
			}
		};
		snow.checkin(true);
	});
</script>
<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
