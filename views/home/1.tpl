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
		height: 425px;
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
		padding: 180px 80px 60px;
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
				<div class="text-center">
						<div class="logo-img">
							<a href="/brand/1">
								<img src="/html/brand/1/logo.png" class="img-circle" alt="图片呢" style="width: 100px;"> </a>
						</div>
						<div class="brand-footer">
							<h2 class="brand-name"><a href="#" class="edit-text">衣+</a></h2>
							<h5>最时尚的图像识别搜索引擎—以图搜衣应用</h5>
							<p>A轮 北京电子商务 移动互联网</p>
						</div>
				</div>
			</li>
		</ol>
	</div>
</div>
<link rel="stylesheet" type="text/css" href="/static/css/brand.css" />
<div id="container" style="margin-top:100px;">
	<div class="container sec">
		<div class="row">
			<div class="col-md-4 col-xs-4 text-side">
			<aside>
				<div id="brand-banner">
					<div class="brand-card">
						<div class="logo-img">
							<a href="/brand/1">
								<img src="/html/brand/1/logo.png" class="img-circle img-responsive" alt="图片呢"> </a>
						</div>
						<div class="brand-footer">
							<h4 class="brand-name"><a href="#" class="edit-text">衣+</a></h4>
							<h5 class="brand-financ">电子商务|移动互联网</h5>
							<p>A轮&nbsp;北京</p>
						</div>
						<div class="brand-info">
							<p>最时尚的图像识别搜索引擎—以图搜衣应用</p>
						</div>
					</div>
				</div>
			</aside>
			</div>
			<div class="col-md-8 col-xs-8 img-side">
				<section>
					<article id="product" style="padding:40px 0;">
						<h3 style="text-align: left;margin:30px 0;">产品介绍</h3>
					</article>
					<article>
						<img src="/html/brand/1/article01.jpg" class="img-responsive">
					</article>
					<article>
						<img src="/html/brand/1/article02.jpg" class="img-responsive">
					</article>
					<article>
						<img src="/html/brand/1/article03.jpg" class="img-responsive">
					</article>
					<article id="team" style="padding:100px 0;">
						<h3 style="text-align: left;margin:30px 0;">团队介绍</h3>
						<div class="col-md-3 col-xs-3 article-member">
							<div class="photo">
								<img class="img-responsive img-circle" src="/html/brand/1/CEO.png">
							</div>
							<p>张默</p>
							<p>CEO 创始人</p>
						</div>
					</article>
					<article id="experiece" style="padding:100px 0;text-align: left;">
						<h3 style="margin:30px 0;">发展历程</h3>
						<dl>
							<dt>2013-12-20</dt>
							<dd>硅谷天使投资</dd>
							<dt>2014-01-15</dt>
							<dd>Dress+网站上线</dd>
							<dt>2014-09-25</dt>
							<dd>Android App在各大应用商店上线</dd>
							<dt>2014-10-21</dt>
							<dd>iOS在App Store上线</dd>
							<dt>2014-10-29</dt>
							<dd>app上线30天，用户下载过100万，新增激活突破50万，日活近40%，次日留存47%</dd>
							<dt>2015-01-06</dt>
							<dd>获小米高管、戴志康等天使投资</dd>
						</dl>
					</article>
				</section>
			</div>
		</div>
	</div>

</div>