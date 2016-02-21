<div class="container banner" style="margin-top:75px;">
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
<style type="text/css">
	.snow-yeqian {
		padding: 10px 20px 10px 40px;
		margin-left: -30px;
		background-color: #fe4a66;
		color: #fff;
	}
	article:nth-child(2n) {
		background: #eee;
	}
	article.container {
		margin-top: 0;
	}
	article>div {
		width: 942px;
		height: 350px;
		display: table-cell;
		text-align: center;
		vertical-align: middle;
	}
	article p {
		text-align: center;
		line-height: 2em;
	}
	article ul li {
		width: 90px;
		display: inline-block;
		margin: 0 8px;
		vertical-align: top;
	}
	article li img {
		width: 70px;
	}
	article li .title {
		margin: 10px 0;
		text-align: center;
		/*font-size: 1.2em;*/
		font-weight: 700;
	}
	article .shuo{
		position:absolute;
		left: 0;
		right: 0;
		margin:0 auto;
		display: none;
		width: 800px;
	}
</style>
<article class="container">
	<div style="vertical-align: top;padding-top: 25px;">
		<h1>

		{{i18n .Lang "yj biaoti"}}	

	</h1>
		<p style="margin-top: 20px;">
			{{i18n .Lang "yj neirong" | str2html }}
		</p>
		<ul style="margin-top: 30px;">
			<li class="shuo" style="display: block;">
				<div class="title">
					{{i18n .Lang "shuo 1"}}
				</div>
				<div>@{{i18n .Lang "who 1"}}</div>
			</li>
			<li class="shuo">
				<div class="title">
					{{i18n .Lang "shuo 2"}}
				</div>
				<div>@{{i18n .Lang "who 2"}}</div>
			</li>
			<li class="shuo">
				<div class="title">
					{{i18n .Lang "shuo 3"}}
				</div>
				<div>@{{i18n .Lang "who 3"}}</div>
			</li>
		</ul>
	</div>
</article>
<article class="container">
	<div>
		<h1>

		{{i18n .Lang "fw biaoti"}}	

	</h1>
		<ul style="margin-top: 30px;">
			<li>
				<div>
					<img src="/html/images/zhuce.png" />
				</div>
				<div class="title">{{i18n .Lang "fw 0"}}</div>
				<div>{{i18n .Lang "fw a"}}</div>
			</li>
			<li>
				<div><img src="/html/images/falv.png" /></div>
				<div class="title">
					{{i18n .Lang "fw 1"}}
				</div>
				<div>{{i18n .Lang "fw b"}}</div>
			</li>
			<li>
				<div><img src="/html/images/zixun.png" /></div>
				<div class="title">
					{{i18n .Lang "fw 2"}}
				</div>
				<div>{{i18n .Lang "fw c"}}</div>
			</li>
			<li>
				<div><img src="/html/images/renli.png" /></div>
				<div class="title">
					{{i18n .Lang "fw 3"}}
				</div>
				<div>{{i18n .Lang "fw d"}}</div>
			</li>
			<li>
				<div><img src="/html/images/chuangye.png" /></div>
				<div class="title">
					{{i18n .Lang "fw 4"}}
				</div>
				<div>{{i18n .Lang "fw e"}}</div>
			</li>
			<li>
				<div><img src="/html/images/zhongzi.png" /></div>
				<div class="title">
					{{i18n .Lang "fw 5"}}
				</div>
				<div>{{i18n .Lang "fw f"}}</div>
			</li>
			<li>
				<div><img src="/html/images/ruzhu.png" /></div>
				<div class="title">
					{{i18n .Lang "fw 6"}}
				</div>
				<div>{{i18n .Lang "fw g"}}</div>
			</li>
		</ul>

	</div>
</article>
<script type="text/javascript">
	$(function() {
		var shuo = $('li.shuo');
		
		function slideshow(){
			
			var index = $('li.shuo:visible').index();
			var next = index+1;
			
			if (next == shuo.length) next = 0;
			
			shuo.eq(next).fadeIn();
			shuo.eq(index).fadeOut();
		};
		
		setInterval(slideshow,5000);
	});
</script>