<style type="text/css">
	@media screen and (min-width: 768px) {
		.sec .text-side ul {
			padding-left: 18px;
		}
		.sec .img-side {
			text-align: center;
		}
		.sec .img-side img {
			display: initial;
		}
		.sec-up {
			position: absolute;
			left: 0;
			top: 150px;
			right: 0;
			height: 50px;
			line-height: 50px;
			text-align: center;
			font-size: 1.5em;
			color: #ddd;
			cursor: pointer;
			display: none;
		}
		.sec-down {
			position: absolute;
			left: 0;
			bottom: 0;
			right: 0;
			height: 50px;
			line-height: 50px;
			text-align: center;
			font-size: 1.5em;
			color: #ddd;
			cursor: pointer;
		}
		.sec-down:hover {
			color: #666;
		}
	}
</style>
<div id="container" style="margin-top:120px;">
	<section class="container sec" id="sec01">
		<div class="col-md-12 col-xs-12 img-side">
			<img src="/html/images/herstart01.jpg" class="img-responsive">
		</div>
		<div class="">
			<a href="http://www.mikecrm.com/f.php?t=sL7LMg" style="position:fixed;z-index:999;bottom: 260px;display: inline-block;width: 26px;color:white;font-size:14px;line-height:17px;background: #2476CE;word-wrap: break-word;padding: 10px 8px;">查看表单</a>
		</div>
	</section>
</div>
<script type="text/javascript">
	$(window).resize(function() {
		$('section.sec div').css('height', $(window).height());
	});
//	var _sections = $('#container').children('section');
//	var _sec_down = $('span.sec-down').click(function() {
//		var _this = $(this).hide(),
//			_index = _this.parent().index(),
//			_top = $('#container').children('section').eq(_index + 1).position().top;
//		// 显示下一个向下按钮
//		_this.parent().next().find('span.sec-down').show();
//		$('html,body').stop().animate({
//			scrollTop: _top
//		}, 300);
//	});
//	var _sec_up = $('span.sec-up').click(function() {
//		var _this = $(this),
//			_index = _this.parent().index(),
//			_top = $('#container').children('section').eq(_index - 1).position().top;
//		$('html,body').stop().animate({
//			scrollTop: _top
//		}, 300, function() {
//			// 显示上一个向下按钮
//			_this.parent().prev().find('span.sec-down').show();
//		});
//	});
//	_sections.mousewheel(function(e, delta) {
//		var _this = $(this);
//		if (delta < 0) {
//			_this.find('span.sec-down').click();
//		} else {
//			_this.find('span.sec-up').click();
//		};
//	});
</script>