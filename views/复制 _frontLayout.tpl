<!DOCTYPE html>

<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">
		<title>{{i18n .Lang "app title"}}</title>
		<meta property="qc:admins" content="6050272677640117256375" />
		<link rel="stylesheet" href="/static/css/pinghei.css">
		<link rel="shortcut icon" href="/static/img/favicon.ico" />
		<link rel="stylesheet" type="text/css" href="//libs.useso.com/js/font-awesome/4.2.0/css/font-awesome.min.css" />
		<link rel="stylesheet" href="//libs.useso.com/js/bootstrap/3.2.0/css/bootstrap.min.css">
		<link rel="stylesheet" href="/static/css/default.css">
		<script type="text/javascript" src="//libs.useso.com/js/jquery/2.1.1/jquery.min.js"></script>
		<script type="text/javascript" src="/static/js/jquery.mousewheel.js"></script>
	</head>

	<body>
		<header id="header" class="navbar-fixed-top">
			<div class="container">

				<div class="title-bar pc-hide">
					<h3><span class="title">她首页</span>
			<a class="communicate"><span class="glyphicon glyphicon-qrcode"></span></a></h3>
				</div>
				<nav style="height:65px;padding: 0 30px;">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">TECHBASE</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="/" style="padding:15px 0;">
							<img src="/static/img/logo001.png" class="img-responsive" alt="logo">
						</a>
					</div>
					<ul class="nav navbar-nav navbar-right">
						<li {{if eq .index "index"}} class="active" {{end}}><a href="/">她首页<span class="sr-only">(current)</span></a>
						</li>
						<li {{if eq .index "brandshow"}} class="active" {{end}}><a href="/brandshow">她品牌</a>
						</li>
						<li{{if eq .index "home"}} class="active" {{end}}><a href="/home">她本营</a>
							</li>
							<li class="phone-hide {{if eq .index " media "}} active {{end}}"><a href="/media">她资讯</a>
							</li>
							<li class="phone-hide {{if eq .index " community "}} active {{end}}"><a href="/community">她社区</a>
							</li>
							<li class="phone-hide lianxiwe"><a href="#">联系我们</a>
							</li>
					</ul>
				</nav>
				<div class="cxxx">
					<a href="/" id="close-cxxx"><span class="glyphicon glyphicon-remove"></span></a>
					<img class="img-responsive" src="/static/img/weixin-qr.png">
					<div class="co-card">
						<p>扫描二维码关注我们</p>
						<p>微信公众号 TechBase她本营</p>
						<p>邮件 techbase@tabenying.com</p>
					</div>
				</div>
			</div>
		</header>
		{{.LayoutContent}}
		<!--END container-->
		<div id="footer_0" style="margin-top:20px;">
		</div>

		<footer class="row" id="footer">
			<div class="col-md-2 col-sm-2 row"></div>
			<div class="col-md-8 col-sm-8">
				<div class="row phone-hide">
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
				<a id="go-top" href="javascript:;" class="hidden" style="position:fixed;z-index:999;bottom: 225px;display: inline-block;width: 32px;color:white;font-size:14px;background: #2476CE;padding: 10px 6px;opacity:0.3;">
				<i class="fa fa-angle-up"></i>
				</a>
			</div>
		</footer>
	</body>

</html>
<script type="text/javascript">
	$(function() {
		$(".lianxiwe").hover(function(e) {
			var _this = $(this);
			if ($(window).width() - _this.offset().left >= $(".cxxx").outerWidth() + 10) {
				$(".cxxx").css({
					'left': _this.offset().left,
					'right': 'inherit'
				}).show();
			} else {
				$(".cxxx").css({
					'right': 10,
					'left': 'inherit'
				}).show();
			}
		}, function() {
			$(this).css("border-bottom", "none");
			$(".cxxx").hide();
		});
		$(".communicate").click(function() {
			$(".cxxx").toggle(function() {
				$(".communicate").css("color", "#cd0000");
			}, function() {
				$(".communicate").css("color", "#cc6600");
			});
		});
		$("#close-cxxx").click(function() {
			$(".cxxx").hide();
		});
	});
	// 页脚自适应沉底，页眉自适应浮动
	$(function() {
		$(window).resize(function() {
			// 页脚
			var _footer_0 = $('#footer_0'),
				_footer = $('#footer');
			_footer.addClass('fixfooter');
			if (_footer_0.offset().top > _footer.offset().top) {
				_footer.removeClass('fixfooter');
			}
			// 幻灯
			var _slide = $('#slideshow'),
				_width = _slide.width();
			_slide.find('.slides li').css('width', _width);
		}).scroll(function() {
			if ($(document).scrollTop() > 50) {
				$('#header').addClass('header_shadow');
				$('#go-top').removeClass('hidden');
			} else {
				$('#header').removeClass('header_shadow');
				$('#go-top').addClass('hidden');
			}
		}).resize();
		//
		$('#go-top').click(function(){
			$('html,body').animate({scrollTop:0});
		});
	});
</script>