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
		color: #f56f74;
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