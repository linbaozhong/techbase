<link rel="stylesheet" type="text/css" href="/static/css/brand.css" />
<div id="container" style="margin-top:100px;">
	<div class="container sec">
		<div class="row">
			<aside>
				<div id="brand-banner">
					<div class="brand-card">
						<div class="logo-img">
							<a href="/brand/4">
								<img src="/html/brand/4/logo.png" class="img-circle img-responsive" alt="图片呢"> </a>
						</div>
						<div class="brand-footer">
							<h4 class="brand-name"><a href="#" class="edit-text">K拍啦</a></h4>
							<h5 class="brand-financ">媒体娱乐</h5>
							<p>未融资&nbsp;北京</p>
						</div>
						<div class="brand-info">
							<p>K拍啦是北京锐影人信息技术有限公司旗下的一个产品，参考好莱坞模式的在线选角平台</p>
						</div>
					</div>
				</div>
			</aside>
			<div class="col-md-4 col-xs-12 text-side">
				<article>&nbsp;</article>
			</div>
			<div class="col-md-7 col-xs-12 img-side">
				<section>
					<article style="padding:40px 0;">
						<h3 style="text-align: left;margin:30px 0;">产品介绍</h3>
					</article>
					<article>
						<img src="/html/brand/4/article01.png" class="img-responsive">
					</article>
					<article style="padding:100px 0;">
						<h3 style="text-align: left;margin:30px 0;">团队介绍</h3>
						<div class="col-md-3 member-article">
							<div class="photo">
								<img class="img-responsive img-circle" src="/html/brand/4/CEO.png">
							</div>
							<p>柳絮</p>
							<p>CEO</p>
						</div>
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