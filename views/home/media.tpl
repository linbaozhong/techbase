<style type="text/css">
	.snow-media-list .row{
		height: 300px;
		margin: 50px 0;
		border: 1px solid #eee;
	}
	.snow-media-list .row header{
		padding: 30px;
		height: 100%;
		/*border-width: 1px 0 1px 1px;
		border-color: #eee;
		border-style: solid;*/
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
		color: #f00;
	}
	.snow-media-list .snow-article-title{
		max-height: 4em;
		font-size: 18px;
  		overflow: hidden;
	}
</style>
<div class="container banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1">
				<div class="container description">
					<h2 style="color:#fff;"><a target="_blank" href="/herstart">Her Startup </a></h2>
					<a href="/brand">
						<p style="color:#fff;">5月 Coming soon... </p>
						<p class="small" style="color:#fdfdfd;">业界最高规格的女性科技互联网创业大赛 </p>
						<p class="small" style="color:#fdfdfd;">一场属于科技与创新的比赛，一个展示女性创意与实力的舞台</p>
					</a>
				</div>
			</li>
			<li class="banner-2">
				<div class="container description">
					<h2><a href="/home">她本营 <span>TechBase</span></a></h2>
					<a href="/home">
						<p calss="" style="color:#fff;">女性科技互联网创业生态圈</p>
						<p class="small" style="color:#fdfdfd;">加速器&nbsp;<strong class="dot">·</strong>&nbsp;媒体<strong>&nbsp;·&nbsp;</strong>社区</p>
					</a>
				</div>
			</li>
		</ol>
		<nav class="banner-nav">
			<span class="current"></span>
			<span class=""></span>
		</nav>
	</div>
</div>
<div class="container snow-padding-top-40 snow-padding-bottom-40 snow-media-list">
	
</div>

<script type="text/javascript">
	$(function(){
		$.getJSON('/home/news',{size:20,index:0},function(json){
			console.log(json);
			if(json.ok){
				$.each(json.data,function(i,item){
					var _html=[];
					_html.push('<div class="row">');
					_html.push('<header class="col-md-4">');
					_html.push('<h1 class="snow-article-tag">' + item.tag+ '</h1>');
					_html.push('<p class="snow-article-title"><a href="/home/show/'+item.id+'" target="_blank">' + item.title+ '</a></p>');
					_html.push('<p class="snow-article-date">' + (new Date(item.updated)).format()+ '</p>');
					_html.push('</header>');
					_html.push('<footer class="col-md-8">');
					_html.push('<img src="'+ item.topic+'"/>');
					_html.push('</footer>');
					_html.push('</div>');
					
					$('.snow-media-list').append(_html.join(''));
				});
			}else{
				
			}
		});
	});
</script>