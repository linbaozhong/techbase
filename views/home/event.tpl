<style type="text/css">
	#snow-hotnews-list {
		list-style-type: disc;
		margin-left: 20px;
		text-align: justify;
	}
	
	#snow-hotnews-list li {
		border-bottom: 1px #ccc dotted;
		padding: 5px 0;
	}
	
	.snow-yeqian {
		padding: 10px 20px;
		margin-right: -46px;
		background-color: #fe4a66;
		color: #fff;
	}
	
	.snow-sns {
		text-align: right;
	}
	
	.snow-sns a {
		width: 50px;
		height: 50px;
		line-height: 50px;
		display: inline-block;
		text-align: center;
		color: #fff;
		font-size: 1.6em;
		background-color: #999;
		border-radius: 50%;
	}
	
	.snow-sns .fa-heart:hover {
		color: #f00;
	}
	
	.snow-sns .fa-weixin:hover {
		color: greenyellow;
	}
	
	.snow-media-article {
		padding-left: 30px;
		padding-right: 30px;
		min-height: 600px;
	}
	
	.snow-media-article .snow-media-subtitle {
		text-indent: 7em;
	}
	
	.snow-media-article .snow-media-published {
		color: #bbb;
		margin-top: 20px;
		text-align: right;
	}
	
	.snow-media-article .snow-media-author {
		margin-top: -32px;
		background: #fff;
		margin-left: auto;
		margin-right: auto;
		width: 288px;
		text-align: center;
	}
</style>
<div class="container banner" style="margin-top:-75px;height: 75px;overflow: hidden;z-index: -1;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="col-md-8 col-xs-8 snow-media-article">
		<h2><span class="snow-color-red snow-media-tag">活动事件</span>&nbsp;
			<span class="small snow-media-title">{{.event.Title}}</span>
		</h2>
		<div class="small snow-media-published">开始日期：{{dateformat (m2t .event.StartTime) "2006-01-02"}}</div>
		<div class="snow-media-body">
			{{str2html .event.Intro}}
		</div>
		<!--<div class="snow-media-original small">声明：本文系作者 授权她本营编辑后发表。转载须经过她本营同意并授权。联系邮箱：techbase@tabenying.com。</div>-->
		<div class="snow-padding-top-40 snow-padding-bottom-40 snow-sns">
			<!--<a class="snow-sns-love" href="javascript:;"><i class="fa fa-heart"></i></a>&nbsp;&nbsp;-->
			<a class="snow-sns-weixin" href="javascript:;"><i class="fa fa-weixin"></i></a></div>
	</div>
	<div class="col-md-4 col-xs-4">
		<h5 class="snow-yeqian">其他活动</h5>
		<ul id="snow-hotnews-list">

		</ul>
	</div>
	<div id="snow-wrap-qrcode" class="text-center" style="display: none;">
		<h6 class="snow-padding-top-40">打开微信“扫一扫”，打开网页后点击屏幕右上角分享按钮</h6>
		<div class="sonw-weixin-qrcode" style="margin: 40px auto;width: 200px;">

		</div>
	</div>
</article>
<script src="/static/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 微信公众号左移
		$('.weixin-public').css('right', 'auto');
		$('#go-top').css({
				right: 'auto',
				left: 95
			})
			// 生成网址二维码
		$('.sonw-weixin-qrcode').qrcode({
			width: 200, //宽度 
			height: 200, //高度 
			text: window.location.protocol + '//' + window.location.host + '/m/event/{{.event.Id}}'
		});
		// 点赞
		$('.snow-media-article').on('click', '.snow-sns-weixin', function() {
			// 分享
			$('#snow-wrap-qrcode').popWindow({
				width: 390,
				height: 360,
				close: ''
			});
		});
		// 读取热门文章列表
		$.getJSON('/home/GetEvents', {
			size: 20
		}, function(json) {
			if (json.ok) {
				var _li = [];
				$.each(json.data, function(i, item) {
					_li.push('<li>');
					_li.push('<a href="/home/event/' + item.id + '">' + item.title + '</a>');
					_li.push('</li>');
				});
				$('#snow-hotnews-list').empty().html(_li.join(''));
			}
		});
		snow.footerBottom();
	});
</script>