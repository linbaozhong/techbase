<style type="text/css">
	.snow-sns{
		text-align: right;
	}
	.snow-sns a{
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
	.snow-sns .fa-heart:hover{
		color: #f00;
	}
	.snow-sns .fa-weixin:hover{
		color: greenyellow;
	}

</style>
<div class="container banner" style="height: 75px;overflow: hidden;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="col-md-8 col-xs-8 snow-media-article" style="padding-left:30px;padding-right:30px;">
		<h2>
			<span class="snow-color-red snow-media-tag"></span>
			<span class="small snow-media-title"></span>
		</h2>
		<h5 class="snow-media-subtitle" style="text-indent: 7em;"></h5>
		<div class="small snow-media-published" style="color: #bbb;margin-top: 20px;text-align: right;">
			
		</div>
		<div class="snow-media-intro">
			
		</div>
		<div class="snow-media-topic">
			<img src=""/>
		</div>
		<div class="snow-media-body">
			
		</div>
		<div class="snow-media-original small">
			
		</div>
		<div class="snow-padding-top-40 snow-padding-bottom-40 snow-sns">
			<a class="snow-sns-love" href="javascript:;"><i class="fa fa-heart"></i></a>&nbsp;&nbsp;<a class="snow-sns-weixin" href="javascript:;"><i class="fa fa-weixin"></i></a>
		</div>
		<hr />
		<div class="snow-media-author small" style="margin-top: -32px;background: #fff;margin-left: auto;margin-right: auto;width: 288px;text-align: center;">
			作者
		</div>
			
	</div>
	<div class="col-md-4 col-xs-4">
		<h2 class="snow-color-red">热门文章</h2>
	</div>
	<div id="snow-wrap-qrcode" class="text-center" style="display: none;">
		<h6 class="snow-padding-top-40">打开微信“扫一扫”，打开网页后点击屏幕右上角分享按钮</h6>
		<div class="sonw-weixin-qrcode" style="margin: 40px auto;width: 200px;">
			
		</div>
	</div>
</article>
<script src="/static/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 微信公众号左移
		$('.weixin-public').css('right','auto');
		$('#go-top').css({
			right:'auto',
			left:95
		})
		// 生成网址二维码
		$('.sonw-weixin-qrcode').qrcode({
//			render: "table", //table方式 
		    width: 200, //宽度 
		    height:200, //高度 
			text:window.location.href
		});
		// 点赞
		$('.snow-sns .snow-sns-love').click(function(){
			var _this = $('i',this);
			$.post('/home/loved',{id:'{{.articleId}}'},function(json){
				if(json.ok){
					if(_this.hasClass('snow-color-love')){
						_this.removeClass('snow-color-love');
					}else{
						_this.addClass('snow-color-love');
					}
				}
			});
		});
		// 分享
		$('.snow-sns .snow-sns-weixin').click(function(){
			$('#snow-wrap-qrcode').popWindow({
				width: 390,
				height: 360,
				close: ''
			});
		});
		
		// 读取新闻并渲染至页面
		$.getJSON('/home/shownews',{id:'{{.articleId}}',review:'{{.review}}'},function(json){
			if(json.ok){
				var item = json.data[0];
				//窗口标题
				$('title').text('{{i18n .Lang "app title"}} - ' + item.title);
				
				$('.snow-media-article .snow-media-tag').text(getBasicName(8,item.tags));
				$('.snow-media-article .snow-media-title').text(item.title);
				
				if(item.subTitle.length){
					$('.snow-media-article .snow-media-subtitle').text('———— ' + item.subTitle);
				}
				
				$('.snow-media-article .snow-media-published').html('小编：'+ item.updatorName + '&nbsp;&nbsp;&nbsp;&nbsp;' + (new Date(item.updated).format()));
				$('.snow-media-article .snow-media-intro').text(item.intro);
				$('.snow-media-article .snow-media-body').html(item.content);
				$('.snow-media-article .snow-media-topic img').attr('src',item.topic);
				if(item.original){
					$('.snow-media-article .snow-media-original').text('声明：本文系作者 '+(item.author || '')+' 授权她本营发表，并经她本营编辑，转载请注明出处和本文链接。');
					$('.snow-media-article .snow-media-author').html('原创文章 &nbsp;&nbsp;作者：'+(item.author || ''));
				}else{
					$('.snow-media-article .snow-media-original').text('声明：本文内容来源于其他网站，转载请注明内容来源和本文链接。');
					
					var _url = item.resourceUrl;
					
					if(item.resourceUrl.slice(0,5) != 'http:' && item.resourceUrl.slice(0,6) != 'https:'){
						_url = 'http://' + item.resourceUrl;
					}
					$('.snow-media-article .snow-media-author').html('内容来源： &nbsp;&nbsp;<a href="'+_url+'" target="_blank">'+(item.resourceUrl || '') +'</a>');
				}
			}else{
				
			}
			// 调整图片样式
			$('.snow-media-article .snow-media-body img').each(function(){
				var _img = $(this);
				if(_img.width() >= _img.closest('.snow-media-body').width()){
					_img.css({
						width:'100%',
						height: 'inherit'
					});
				}else{
					_img.parent().css({
						
					});
				}
			});
			//
			snow.footerBottom();
		});
		// 读取当前用户的分享状态
		$.getJSON('/home/getsns',{id:'{{.articleId}}'},function(json){
			if(json.ok){
				if(json.data.loved){
					$('.snow-sns .snow-sns-love i').addClass('snow-color-love');
				}else{
					$('.snow-sns .snow-sns-love i').removeClass('snow-color-love');
				}
			}else{
				
			}
		});
	});
</script>