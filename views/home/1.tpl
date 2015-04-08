<link rel="stylesheet" type="text/css" href="/static/css/brand.css" />
<div id="container" style="margin-top:100px;">
	<div class="container sec">
		<div class="row">
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
			<div class="col-md-4 col-xs-12 text-side">
				<article>&nbsp;</article>
			</div>
			<div class="col-md-7 col-xs-12 img-side">
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
						<div class="col-md-3 member-article">
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
<script type="text/javascript">
	$(window).resize(function() {
		$('div.sec div.text-side,div.sec div.img-side').css('height', $(window).height());
	});
	var _sections = $('#container').children('section');
	var _sec_down = $('span.sec-down').click(function() {
		var _this = $(this).hide(),
			_index = _this.parent().index(),
			_top = $('#container').children('section').eq(_index + 1).position().top;
		// 显示下一个向下按钮
		_this.parent().next().find('span.sec-down').show();
		$('html,body').stop().animate({
			scrollTop: _top
		}, 300);
	});
	var _sec_up = $('span.sec-up').click(function() {
		var _this = $(this),
			_index = _this.parent().index(),
			_top = $('#container').children('section').eq(_index - 1).position().top;
		$('html,body').stop().animate({
			scrollTop: _top
		}, 300, function() {
			// 显示上一个向下按钮
			_this.parent().prev().find('span.sec-down').show();
		});
	});
	_sections.mousewheel(function(e, delta) {
		var _this = $(this);
		if (delta < 0) {
			_this.find('span.sec-down').click();
		} else {
			_this.find('span.sec-up').click();
		};
	});
</script>