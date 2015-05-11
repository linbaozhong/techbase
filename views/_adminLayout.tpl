<!DOCTYPE html>

<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">-->
		<title>{{i18n .Lang "app title"}} {{.subTitle}}</title>
		<meta property="qc:admins" content="6050272677640117256375" />
		<!--<link rel="stylesheet" href="/static/css/pinghei.css">-->
		<link rel="shortcut icon" href="/static/img/favicon.ico" />
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.3.0/css/font-awesome.min.css" />
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="/static/css/non-responsive.min.css"/>
		<!--<link rel="stylesheet" href="/static/css/default.css">-->
		<script type="text/javascript">
			var snow = {};
		</script>
		<link rel="stylesheet" href="/static/css/reset.css">
		<script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.3/jquery.min.js"></script>
		<script src="/static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>
		<script src="/static/js/common.js" type="text/javascript" charset="utf-8"></script>
		<!--<script type="text/javascript" src="/static/js/jquery.mousewheel.js"></script>-->
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
						{{if lt .account.Role 3 }}
						<li class="{{if eq .index "index"}} active {{end}}"><a href="/admin/company">公司审核</a>
						</li>
						<li class="{{if eq .index "index"}} active {{end}}"><a href="/admin/account">账户管理</a>
						</li>
						{{end}}
						{{if lt .account.Role 2 }}
						<li class="menu {{if eq .index "index"}} active {{end}}" data-rel = "submenu-1"><a href="javascript:;">基础数据</a>
						</li>
						{{end}}
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li id="avatar" class="menu snow-profile" data-rel = "submenu-0">
							<a href="javascript:;"><img src="" style="width:19px;height:19px;" />
							<span class="nickname">
							</span></a>
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
				<li><a href="/basic/index/0">国家</a>
				</li>
				<li><a href="/basic/index/2">城市</a>
				</li>
				<li><a href="/basic/index/3">领域</a>
				</li>
				<li><a href="/basic/index/4">运营状态</a>
				</li>
				<li><a href="/basic/index/5">职位</a>
				</li>
				<li><a href="/basic/index/6">融资轮次</a>
				</li>
				<li><a href="/basic/index/7">币种</a>
				</li>
			</ul>
		</div>
		{{.LayoutContent}}
		{{.Footer}}

	</body>

</html>
<script type="text/javascript">
	snow.confirm = function(msg){
		return confirm(msg);
	};

	$(function() {
		//
		function mouseleave(obj) {
			setTimeout(function() {
				if (obj.data('hide')) {
					obj.stop().slideUp('fast');
				}
			}, 100);
		};

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

		// 页脚自适应沉底，页眉自适应浮动
		function footerBottom(){
			// 页脚
			var _footer_0 = $('#footer_0'),
				_footer = $('#footer');
			_footer.addClass('fixfooter');
			if (_footer_0.offset().top > _footer.offset().top) {
				_footer.removeClass('fixfooter');
			}
		};
		setTimeout(footerBottom,100);
		
		$(window).resize(function() {
			footerBottom();
		}).scroll(function() {
			if ($(document).scrollTop() > 50) {
				$('header.navbar-fixed-top').addClass('header_shadow');
				$('#go-top').removeClass('hidden');
			} else {
				$('header.navbar-fixed-top').removeClass('header_shadow');
				$('#go-top').addClass('hidden');
			}
		});
//
		$('#go-top').click(function() {
			$('html,body').animate({
				scrollTop: 0
			});
		});

		// 签出
		$('#logout').click(function(){
			$.post('/signout',function(json){
				if (json.ok) {
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

			} else {
				window.location = "/";
			}
		};
		snow.checkin(true);
	});
</script>

