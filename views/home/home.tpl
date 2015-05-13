<style type="text/css">
	@media screen and (min-width: 768px) {
		.sec article{
			height: 270px;
			overflow: auto;
			margin: auto;
			position: absolute;
			top: 0;
			left: 0;
			bottom: 0;
			right: 0;
		}
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
			color: #666;
			cursor: pointer;
			display: none;
		}
		.sec-down {
			position: absolute;
			left: 0;
			bottom: 0;
			right: 0;
			height: 60px;
			/*line-height: 50px;*/
			text-align: center;
			font-size: 1.5em;
			color: #666;
			cursor: pointer;
		}
		body {
			overflow: hidden;
		}
		section{
			position: relative;
		}
		/*@-webkit-keyframes name{
			0%{margin-top: 0px;}
			100%{margin-top: 25px;}
		}
		.sec-down i{
			-webkit-animation: name .5s infinite alternate;
		}*/
	}
</style>
<div id="container" style="margin-top:0;">
	<section class=" sec" id="sec01">
		<article class="container">
		<div class="col-md-6 col-xs-6 text-side">
			<h3>她本营</h3>
			<h5>打造属于女性科技创业群体自己的大本营</h5>
			<p>以零星之火，造燎原之势；以女性之姿，搏时代之巅。正是受到女性创业者们不甘沉默、满腔热情、坚韧不屈的创业故事的感染， 秉承“大胆想，勇敢做”的理念，我们萌生了创建女性科技互联网社区和孵化平台的想法——这便是TechBase她本营诞生的原因。
			</p>
		</div>
		<div class="col-md-6 col-xs-6 img-side">
			<img src="/html/brand/1.png" class="img-responsive">
		</div></article>
		<span class="sec-down"><i class="fa fa-angle-double-down"></i></span>
	</section>
	<section class="sec" id="sec02">
		<span class="sec-up"><i class="fa fa-angle-double-up"></i></span>
		<article class="container">
		<div class="col-md-6 col-xs-6 img-side">
			<img src="/html/brand/2.png" class="img-responsive">
		</div>
		<div class="col-md-6 col-xs-6 text-side" style="text-align:center;">
			<h3>为什么我们这么做</h3>
			<h5>来自女性在时代与科技领域进步的发声</h5>
			<dl>
				<dt>趋势</dt>
				<dd>越来越多的女性参与到科技行业</dd>
				<dt>价值</dt>
				<dd>解决女性创业中的真实问题</dd>
				<dt>情怀</dt>
				<dd>通过专业平台打破性别壁垒</dd>
			</dl>
		</div></article>
		<span class="sec-down"><i class="fa fa-angle-double-down"></i></span>
	</section>
	<section class="sec" id="sec03">
		<span class="sec-up"><i class="fa fa-angle-double-up"></i></span>
		<article class="container">
		<div class="col-md-6 col-xs-6 text-side">
			<h3>我们可以做什么</h3>
			<h5>只专注于一件事情，帮助女性创业者</h5>
			<ul>
				<li>创业项目展示</li>
				<li>品牌服务推广</li>
				<li>产品原型测试与客户意见收集</li>
				<li>合作伙伴招募与人员招聘</li>
				<li>投融资对接服务</li>
				<li>财务法律咨询</li>
				<li>线下培训与社交活动</li>
			</ul>
		</div>
		<div class="col-md-6 col-xs-6 img-side">
			<img src="/html/brand/3.png" class="img-responsive">
		</div></article>
		<span class="sec-down"><i class="fa fa-angle-double-down"></i></span>
	</section>
	<section id="sec04" style="position: relative;">
		<span class="sec-up"><i class="fa fa-angle-double-up"></i></span>
		<article class="container">
		<div class="col-md-12 col-xs-12 img-side">
			<img src="/html/brand/4.png" class="img-responsive" style="width:100%;">
		</div>
		<div class="col-md-12 col-xs-12">
			<h3>5月，一场女性创意的角逐 <a class="link" target="_blank" href="/herstart">了解更多 <span class="fa fa-angle-right"></span></a></h3>
			<p>TechBase她本营将携手Lean In Beijing及科技互联网行业内多家知名投资孵化机构和媒体， 共同打造首个世界级的女性科技互联网创业大赛Her Startup，为女性创业者提供展示创意与实力的舞台。</p>
		</div></article>
	</section>
</div>
<script src="http://cdn.bootcss.com/jquery-mousewheel/3.1.12/jquery.mousewheel.min.js"></script>
<script type="text/javascript">
	$(window).resize(function() {
		$('section.sec').css({
			height: $(window).height()
			});
	});
	var _sections = $('#container').children('section');
	var _sec_down = $('span.sec-down').click(function() {
		var _this = $(this).hide(),
			_index = _this.parent().index(),
			_top = $('#container').children('section').eq(_index + 1).position().top;
		// 显示下一个向下按钮
		_this.parent().next().find('span.sec-down').show();
		console.log(_this.parent());
		$('html,body').stop().animate({
			scrollTop: _top
		}, 600);
	});
	var _sec_up = $('span.sec-up').click(function() {
		var _this = $(this),
			_index = _this.parent().index(),
			_top = $('#container').children('section').eq(_index - 1).position().top;

		$('html,body').stop().animate({
			scrollTop: _top
		}, 600,function(){
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

	// 循环动画向下箭头
	(function(){
		function runIt(){
			$('span.sec-down i').animate({marginTop:20},600);
			$('span.sec-down i').animate({marginTop:0},600,runIt);
		}
		runIt();
	})();
</script>
﻿