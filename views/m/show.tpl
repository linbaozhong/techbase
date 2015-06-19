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
	.snow-media-article{
		position: relative;min-height: 300px;  padding-top: 2em;
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
<article class="container">
	<div class="snow-media-article">

		<div class="text-center snow-color-red" style="position: absolute; right: 0; bottom: 0; top: 0; left: 0; height: 20px;margin: auto;">
			<i class="fa fa-spinner fa-spin fa-2x"></i><span style="vertical-align: super;margin-left: 1em;">正在拼命地读取……</span>
		</div>

			
	</div>
</article>
<script src="/static/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
	$(function(){
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
		// 读取新闻并渲染至页面
		$.getJSON('/home/shownews',{id:'{{.articleId}}',review:'{{.review}}'},function(json){
			if(json.ok){
				var item = json.data[0],_html = [],_original='',_author='';
				//窗口标题
				$('title').text('{{i18n .Lang "app title"}} - ' + item.title);
				//描述
				$('#description').attr('content',item.intro);
				// 正文
				_html.push('<h2><span class="snow-color-red snow-media-tag">' + getBasicName(8,item.tags) + '</span>');
				_html.push('&nbsp;<span class="small snow-media-title">' + item.title + '</span></h2>');
				
				if(item.subTitle.length){
					_html.push('<h5 class="snow-media-subtitle">———— ' + item.subTitle + '</h5>');
				}
				
				_html.push('<div class="small snow-media-published">小编：' + item.updatorName + '&nbsp;&nbsp;&nbsp;&nbsp;' + (new Date(item.updated).format()) + '</div>');
				
				if(item.intro.length){
					_html.push('<div class="snow-media-intro">' + item.intro + '</div>');
				}
				
				if(item.topic.length){
					_html.push('<div class="snow-media-topic"><img src="' + item.topic + '"/></div>');
				}
				
				_html.push('<div class="snow-media-body">' + item.content + '</div>');
				
				
				if(item.original){
					_original = '声明：本文系作者 ' + item.author + ' 授权她本营编辑后发表。转载须经过她本营同意并授权。联系邮箱：techbase@tabenying.com。';
					_author =  (item.author=='' ? '' : ('原创文章 &nbsp;&nbsp;作者：'+ item.author));
				}else{
					_original = '声明：本文内容来源于其他网站，转载请注明内容来源和本文链接。';

					var _url = item.resourceUrl;
					
					if(item.resourceUrl.slice(0,5) != 'http:' && item.resourceUrl.slice(0,6) != 'https:'){
						_url = 'http://' + item.resourceUrl;
					}
					_author = '内容来源： &nbsp;&nbsp;<a href="' + _url + '" target="_blank">'+(item.resourceUrl || '')  + '</a>';
				}

				_html.push('<div class="snow-media-original small">' + _original + '</div>');
				_html.push('<div class="snow-padding-top-40 snow-padding-bottom-40 snow-sns">');
				_html.push('<a class="snow-sns-love" href="javascript:;"><i class="fa fa-heart"></i></a>');
//				_html.push('&nbsp;&nbsp;<a class="snow-sns-weixin" href="javascript:;"><i class="fa fa-weixin"></i></a>');
				_html.push('</div>');

				if(_author.length){
					_html.push('<hr />');
					_html.push('<div class="snow-media-author small">' + _author + '</div>');
				}


				$('.snow-media-article').empty().html(_html.join(''));
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

	});
</script>