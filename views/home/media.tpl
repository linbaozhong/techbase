<style type="text/css">
	#footer_0{
		background-color: #eee;
	}
	.snow-media-list{
		background-color:#eee;
		margin-top: -150px;
	}
	.snow-media-list .row{
		height: 220px;
		/*border-bottom: 1px solid #eee;
		width: 850px;
		margin-left: auto;
		margin-right: auto;*/
		margin-bottom: 35px;
		background-color:#fff;
	}
	.snow-media-list .row header{
		padding: 20px 80px;
		height: 100%;
		opacity: .9;
		/*border-width: 1px 0 1px 1px;
		border-color: #eee;
		border-style: solid;*/
	}
	.snow-media-list .row:hover header{
		/*background-color: rgba(245, 111, 116, 0.4);*/
		opacity: 1;
	}
	.snow-media-list footer{
		height: 100%;
		padding: 0;
		overflow: hidden;
	}
	.snow-media-list footer img{
		width: 100%;
	}
	.snow-media-list .row:nth-child(2n) header{
		/*border-width: 1px 1px 1px 0;*/
		float: right;
	}
	.snow-media-list .row:nth-child(2n) footer{
		float: left;
	}
	
	.snow-media-list .snow-article-tag{
		color: #f56f74;
	}
	.snow-media-list .snow-article-title{
		max-height: 4em;
		font-size: 16px;
  		overflow: hidden;
	}
	.snow-media-list .snow-article-title{
		color: #337ab7;
	}
	.snow-media-list .snow-article-intro{
		height:3em;
		color: #666;
		overflow: hidden;
	}
	.snow-media-list .snow-article-date{
		color:#bbb;
	}
</style>
<div class="container banner">
	<div class="slideshow">
		<ol class="slides" style="height: 664px;">
			<li class="current" style="background-image: url(/html/images/media-banner.png);">
			</li>
		</ol>
		<nav class="banner-nav">
			<span class="current"></span>
			<span class=""></span>
		</nav>
	</div>
</div>
<div class="container snow-media-list">
	
</div>

<script type="text/javascript">
	$(function(){
		function showNews(d){
			$.each(d,function(i,item){
				var _html=[];
				_html.push('<div class="row">');
				_html.push('<a href="/home/show/'+item.id+'" target="_blank"><header class="col-xs-8 col-md-8">');
				_html.push('<h3 class="snow-article-tag">' + item.tag+ '</h3>');
				_html.push('<p class="snow-article-title">' + item.title.cut(60,'...')+ '</p>');
				_html.push('<p class="snow-article-intro">' + item.intro.cut(120,'...') + '</p>');
				_html.push('<p class="snow-article-date small">' + (new Date(item.updated)).format()+ '</p>');
				_html.push('</header></a>');
				_html.push('<footer class="col-xs-4 col-md-4"><a href="/home/show/'+item.id+'" target="_blank">');
				_html.push('<img src="'+ item.topic+'"/>');
				_html.push('</a></footer>');
				_html.push('</div>');
				
				$('.snow-media-list').append(_html.join(''));
			});
			snow.footerBottom();
			// 调整图片
			$('.snow-media-list img').each(function(){
				var _img = $(this);
				_img.load(function(){
					if(_img.height() < 220){
						_img.css({
							height:220,
							width:'auto'
						});
					}
				}).error(function(){
					_img.attr('src',snow.default_img)
				});
			});
		};
		
		function loadNews(index){
			var _footer = $('#footer').data('loading',true);
			
			$.getJSON('/home/news',{size:3,index:index},function(json){
				console.log(json);
				if(json.ok){
					// 已经没有数据可供载入
					if(json.data.length == 0){
						$('#footer_0 span').text('我勒个去，累死奴家了……');
						setTimeout(function(){
							$('#footer_0').children().slideUp(600);
						},4000)
						return;
					}
					// 隐藏进度条
					$('#footer_0').children().hide();
					showNews(json.data);
					_footer.data('index',index+1).data('loading',false);
					bodyScroll();
				}else{
					
				}
			});				
		};
		//
		function bodyScroll(){
			var _this = $(window),_footer = $('#footer');
			
			//if(!_footer.data('loading') && (120 + _footer.offset().top <= _this.scrollTop() + _this.height())){
			if(!_footer.data('loading') && ($(document).height() - _footer.height() <= _this.scrollTop() + _this.height())){
				// 显示进度
				$('#footer_0').children().show();
				var _index = _footer.data('index') || 0;
				loadNews(_index);
			}
		};
		
		$('body').swipe({
			swipeUp:function(event, direction, distance, duration, fingerCount, fingerData) {
				bodyScroll();
			}
		});

		$(window).scroll(function(){
			bodyScroll();
		}).scroll();

	});
</script>