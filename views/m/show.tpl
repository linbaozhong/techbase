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
<article class="container">
	<div class="snow-media-article">
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

		<hr />
		<div class="snow-media-author small" style="margin-top: -32px;background: #fff;margin-left: auto;margin-right: auto;width: 288px;text-align: center;">
			作者
		</div>
			
	</div>
</article>
<script src="/static/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		// 读取新闻并渲染至页面
		$.getJSON('/home/shownews',{id:'{{.articleId}}',review:'{{.review}}'},function(json){
			if(json.ok){
				var item = json.data[0];
				//窗口标题
				$('title').text('{{i18n .Lang "app title"}} - ' + item.title);
				//描述
				$('#description').attr('content',item.intro);
				
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
					$('.snow-media-article .snow-media-original').text('声明：本文系作者 '+(item.author || item.updatorName)+' 授权她本营编辑后发表。转载须经过她本营同意并授权。联系邮箱：techbase@tabenying.com。');
					$('.snow-media-article .snow-media-author').html('原创文章 &nbsp;&nbsp;作者：'+(item.author || item.updatorName));
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

		});

	});
</script>