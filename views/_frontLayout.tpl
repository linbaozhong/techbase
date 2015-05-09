<!DOCTYPE html>

<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">
		<title>{{i18n .Lang "app title"}}</title>
		{{.Head}}
		<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
		<style type="text/css">
			html.mobile{
				
			}
			html.mobile .navbar-fixed-top,html.mobile .fixfooter{
				position: relative !important;
			}
		</style>
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
							<a href="javascript:;"><img src="" style="width:19px;height:19px;" />
							<span class="nickname">
							</span></a>
						</li>
						<li class="menu" data-rel = "submenu-2">
							<a href="javascript:;">关注我们</a>
						</li>
					</ul>
				</nav>
			</div>

		</header>
		<div class="submenu submenu-0">
			<i class="fa fa-caret-up"></i>
			<ul class="">
				<li><a href="/my/profile">我的帐号</a>
				</li>
				<li><a href="/my/company">我的公司</a>
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
		<div class="submenu submenu-2">
			<i class="fa fa-caret-up"></i>
			<img src="/static/img/weixin-qr.png">
			<div class="co-card">
				<p>扫描二维码关注我们</p>
				<p>微信公众号 TechBase她本营</p>
				<p>邮件 techbase@tabenying.com</p>
			</div>
		</div>
		{{.LayoutContent}}
		{{.Footer}}
		<!--END container-->
		<div class="x-data">
			
		</div>
	</body>

</html>
<script type="text/javascript">

	$(function() {
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

