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
		<h2><span class="snow-color-red snow-media-tag">事件</span>&nbsp;
			<span class="small snow-media-title">{{.event.Title}}</span>
		</h2>
		<div class="small snow-media-published">开始日期：{{dateformat (m2t .event.StartTime) "2006-01-02"}}</div>
		<div class="snow-media-body">
			{{str2html .event.Intro}}
		</div>
		<div class="snow-media-original small">声明：本文系作者 授权她本营编辑后发表。转载须经过她本营同意并授权。联系邮箱：techbase@tabenying.com。</div>
		<div class="snow-padding-top-40 snow-padding-bottom-40 snow-sns">
			<a class="snow-sns-love" href="javascript:;"><i class="fa fa-heart"></i></a>
			<!--&nbsp;&nbsp;<a class="snow-sns-weixin" href="javascript:;"><i class="fa fa-weixin"></i></a>-->
		</div>
	</div>
</article>
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
		snow.footerBottom();
	});
</script>