<style type="text/css">
	#snow-hotnews-list{
		list-style-type: disc;
  		margin-left: 20px;
  		text-align: justify;
	}
	#snow-hotnews-list li{
		border-bottom: 1px #ccc dotted;
		padding: 5px 0;
	}
	.snow-yeqian{
		padding: 10px 20px;
  		margin-right: -46px;
  		background-color: #fe4a66;
  		color: #fff;
	}
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
	.snow-media-article{
		padding-left:30px;padding-right:30px;min-height: 600px;
	}
	.snow-media-article .snow-media-subtitle{
		text-indent: 7em;
	}
	.snow-media-article .snow-media-published{
		color: #bbb;margin-top: 20px;text-align: right;
	}
	.snow-media-article .snow-media-author{
		margin-top: -32px;background: #fff;margin-left: auto;margin-right: auto;width: 288px;text-align: center;
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
	<div class="col-md-8 col-xs-8 snow-media-article">
		<h2><span class="snow-color-red snow-media-tag">{{.article.Resource}}</span>
		&nbsp;<span class="small snow-media-title">{{.article.Title}}</span></h2>
		{{if gt (len .article.SubTitle) 0}}
		<h5 class="snow-media-subtitle">———— {{.article.SubTitle}}</h5>
		{{end}}
		<div class="small snow-media-published">小编：{{.article.UpdatorName}} &nbsp;&nbsp;&nbsp;&nbsp;{{dateformat (m2t .article.Updated) "2006-01-02"}}</div>
		{{if gt (len .article.Intro) 0}}
		<div class="snow-media-intro">{{.article.Intro}}</div>
		{{end}}
		{{if gt (len .article.Topic) 0}}
		<div class="snow-media-topic"><img src="{{.article.Topic}}"/></div>
		{{end}}
		<div class="snow-media-body">{{str2html .article.Content}}</div>
		
		<!--文章来源-->
		{{if eq .article.Original 1}}
			<div class="snow-media-original small">
				声明：本文系作者 {{.article.Author}} 授权她本营编辑后发表。转载须经过她本营同意并授权。联系邮箱：techbase@tabenying.com。
			</div>
		{{else}}
		<div class="snow-media-original small">
			声明：本文内容来源于其他网站，转载请注明内容来源和本文链接。
		</div>
		{{end}}
		<div class="snow-padding-top-40 snow-padding-bottom-40 snow-sns">
			<a class="snow-sns-love" href="javascript:;"><i class="fa fa-heart"></i></a>&nbsp;&nbsp;
			<a class="snow-sns-weixin" href="javascript:;"><i class="fa fa-weixin"></i></a>
		</div>
		
		{{if eq .article.Original 1}}
			<!--作者-->
			{{if ne .article.Author ""}}
				<hr />
				<div class="snow-media-author small">原创文章 &nbsp;&nbsp;作者：{{.article.Author}}</div>
			{{end}}
		
		{{else}}
			<hr />
			<div class="snow-media-author small">内容来源： &nbsp;&nbsp;<a href={{.article.ResourceUrl}} target=_blank>{{.article.Resource}}</div>
		{{end}}
		
	</div>
	<div class="col-md-4 col-xs-4">
		<h5 class="snow-yeqian">
			{{if eq .article.Type 0}}
			热门文章
			{{else}}
			其他报道
			{{end}}
		</h5>
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
	$(function(){
		//窗口标题
		$('title').text('{{i18n .Lang "app title"}} - {{.article.Title}}');
		//描述
		$('#description').attr('content','{{.article.Intro}}');
		// 文章标签
		{{if eq .article.Type 0}}
			$('span.snow-media-tag').text(getBasicName(8,{{.article.Tags}}));
		{{end}}
		
		// 微信公众号左移
		$('.weixin-public').css('right','auto');
		$('#go-top').css({
			right:'auto',
			left:95
		})
		// 生成网址二维码
		$('.sonw-weixin-qrcode').qrcode({
		    width: 200, //宽度 
		    height:200, //高度 
			text:window.location.protocol + '//' + window.location.host + '/m/show/{{.articleId}}'
		});
		// 点赞
		$('.snow-media-article').on('click','.snow-sns-love',function(){
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
		}).on('click','.snow-sns-weixin',function(){
			// 分享
			$('#snow-wrap-qrcode').popWindow({
				width: 390,
				height: 360,
				close: ''
			});
		});
		// 读取热门文章列表
		$.getJSON('/home/hotnews',{size:10,type:'{{.article.Type}}'},function(json){
			if(json.ok){
				var _li = [];
				$.each(json.data,function(i,item){
					_li.push('<li>');
					_li.push('<a href="/home/show/'+item.id+'">' + item.title + '</a>');
					_li.push('</li>');
				});
				
				$('#snow-hotnews-list').empty().html(_li.join(''));
			}
		})

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