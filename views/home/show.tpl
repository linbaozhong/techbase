<div class="banner" style="height: 90px;overflow: hidden;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container snow-media-article">
	<div class="col-md-8">
		<h1>
			<span class="snow-media-tag"></span>&nbsp;|&nbsp;
			<span class="snow-media-title"></span>
		</h1>
		<div class="snow-media-intro">
			
		</div>
		<div class="snow-media-topic">
			<img src=""/>
		</div>
		<div class="snow-media-body">
			
		</div>
		<div class="snow-media-original">
			
		</div>	
	</div>
	<div class="col-md-4">
		
	</div>
</article>

<script type="text/javascript">
	$(function(){
		$.getJSON('/home/shownews',{id:'{{.articleId}}',review:'{{.review}}'},function(json){
			if(json.ok){
				var item = json.data;
				$('.snow-media-article .snow-media-tag').text(getBasicName(8,item.tags));
				$('.snow-media-article .snow-media-title').text(item.title);
				$('.snow-media-article .snow-media-intro').text(item.intro);
				$('.snow-media-article .snow-media-body').html(item.content);
				$('.snow-media-article .snow-media-topic img').attr('src',item.topic);
				if(item.original){
					$('.snow-media-article .snow-media-original').text('声明：本文系作者 xxx授权她本营发表，并经她本营编辑，转载请注明出处和本文链接。');
				}else{
					$('.snow-media-article .snow-media-original').text('声明：本文内容来源于其他网站，转载请注明内容来源和本文链接。');
				}
			}else{
				
			}
		})
	});
</script>