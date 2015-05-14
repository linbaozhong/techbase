<style type="text/css">
	.banner .small {
		font-size: 0.7em;
		font-weight: initial;
		line-height: normal;
	}
	.slideshow {
		overflow: hidden;
		font-weight: bold;
		line-height: 1.5;
		position: relative;
	}
	.slideshow * {
		color: #fff;
	}
	.slideshow > .banner-nav {
		text-align: center;
		position: absolute;
		width: 100%;
		bottom: 10px;
	}
	.slideshow > .banner-nav span {
		display: inline-block;
		cursor: pointer;
		margin: 0 3px;
		-webkit-transition: background-color 0.2s;
		transition: background-color 0.2s;
	}
	.slideshow > .banner-nav span:before {
		font: normal normal normal 14px/1 FontAwesome;
		width: 32px;
		font-size: 14px;
		content: "\f10c";
	}
	.slideshow > .banner-nav span.current:before {
		content: "\f111";
	}
	.slides {
		list-style: none;
		padding: 0;
		margin: 0;
		position: relative;
		height: 325px;
		width: 100%;
		overflow: hidden;
		color: #333;
	}
	.slides > li {
		-webkit-perspective: 1600px;
		perspective: 1600px;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		display: none;
		height: 100%;
		background-size: cover;
		background-position-x: center;
		background-position-y: center;
	}
	.slides > li.banner-1 {
		background-image: url(/html/images/banner02.png);
	}
	.slides > li.banner-2 {
		background-image: url(/html/images/banner01.png);
	}
	.slides .description {
		width: 100%;
		height: 100%;
		font-size: 1.5em;
		position: relative;
		z-index: 1000;
		letter-spacing: .2em;
		padding-top: 120px;
		padding-left: 80px;
	}
	.slides .description h2 {
		font-size: 200%;
	}
	.slides > li.current,
	.slides > li.show {
		display: block;
	}
	.more-brand {
		text-align: right;
	}
</style>
<div class="banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1">
				<div class="description">
					<h2 style="color:#fff;"><a target="_blank" href="/herstart">Her Startup </a></h2>
					<a href="/brand">
						<p style="color:#fff;">5月 Coming soon... </p>
						<p class="small" style="color:#fdfdfd;">业界最高规格的女性科技互联网创业大赛 </p>
						<p class="small" style="color:#fdfdfd;">一场属于科技与创新的比赛，一个展示女性创意与实力的舞台</p>
					</a>
				</div>
			</li>
			<li class="banner-2">
				<div class="description">
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
<div class="container">
	<div class="brand-zone row">
		<p class="more-brand"><a class="link" href="/brandshow">更多品牌 <span class="fa fa-angle-right"></span></a>
		</p>
		<div class="col-md-4 col-sm-4 col-xs-4 brand-card-container">
			<div class="brand-card" style="background-image: url(/html/brand/1.png);">
				<div style="background:rgba(255,255,255,0.8);height:100%;">
					<div class="logo-img">
						<a href="/brand/3">
							<img src="/html/brand/logo_1.png" class="img-circle img-responsive" alt="图片呢"> </a>
					</div>
					<div class="brand-footer">
						<h4 class="brand-name"><a href="/brand/3" class="edit-text" data-edit="name" data-name="品牌名">么么搭</a></h4>
						<h5 class="brand-financ edit-text" data-edit="industry" data-name="行业">消费生活</h5> </div>
					<div class="row brand-info">
						<p>通过聚合主流国内外时尚站点的物品，通过增强的搜索系统和过滤系统为用户推荐混搭套装</p>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 brand-card-container">
			<div class="brand-card" style="background-image: url(/html/brand/2.png);">
				<div style="background:rgba(255,255,255,0.8);height:100%;">
					<div class="logo-img">
						<a href="/brand/6">
							<img src="/html/brand/logo_2.jpg" class="img-circle img-responsive" alt="图片呢"> </a>
					</div>
					<div class="brand-footer">
						<h4 class="brand-name"><a href="/brand/6" class="edit-text" data-edit="name" data-name="品牌名">LingoX</a></h4>
						<h5 class="brand-financ edit-text" data-edit="industry" data-name="行业">旅游|社交</h5> </div>
					<div class="row brand-info">
						<p>提供搜索与活动发布功能，帮助喜爱自由行、喜欢文化探索及喜欢交友的年轻人，特别是外国旅行者找到当地人并结交朋友</p>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 brand-card-container">
			<div class="brand-card" style="background-image: url(/html/brand/3.png);">
				<div style="background:rgba(255,255,255,0.8);height:100%;">
					<div class="logo-img">
						<a href="/brand/7">
							<img src="/html/brand/logo_3.png" class="img-circle img-responsive" alt="图片呢"> </a>
					</div>
					<div class="brand-footer">
						<h4 class="brand-name"><a href="/brand/7" class="edit-text" data-edit="name" data-name="品牌名">暖丘</a></h4>
						<h5 class="brand-financ edit-text" data-edit="industry" data-name="行业">医疗健康</h5> </div>
					<div class="row brand-info">
						<p>一个心理关怀服务的社区，为普通人提供和心理咨询师对接和互动的创新渠道；面向关怀师（心理咨询师）提供自助合作接入的平台，面向用户提供随时随地解决情绪问题的求助资源</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	(function($) {
		var speed = 5000,
			count = $('.slideshow li').length,
			index = 0;
		var slidetimes;

		function start(index) {
			$('.slideshow .banner-nav span').eq(index).addClass('current').siblings().removeClass('current');
			$('.slideshow li').eq(index).fadeIn('slow').siblings('li').fadeOut('slow');
		};

		function slideshow() {
			slidetimes = setInterval(function() {
				if (index == count) {
					index = 0;
				}
				start(index);
				index++;
			}, speed);
		};
		$('.slideshow li').hover(function() {
			clearInterval(slidetimes);
		}, function() {
			slideshow();
		});
		$('.slideshow .banner-nav span').click(function() {
			start($(this).index());
		});
		slideshow();
	})(jQuery)
</script>