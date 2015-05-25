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
	{{if gt (len .startup) 0}}
	<div class="brand-zone row">
		<div>
			<p class="pull-right"><a class="link" href="/item/index">更多 <span class="fa fa-angle-right"></span></a>
			</p>
			<h5>Her Startup女性创业大赛</h5>
		</div>
		{{$loops := .startupLoop}}
		{{range $index,$company := .startup}}
		<div class="col-md-4 col-sm-4 col-xs-4 brand-card-container">
			<div class="brand-card">
				<div class="small abs-top" style="padding: 5px;right: 0;">
					<span>
						{{if eq $company.Apply 0}}
							尚未申请融资
						{{else if eq $company.Apply 1}}
							正在融资中
						{{else if eq $company.Apply 2}}
							正在融资中
						{{else if eq $company.Apply 3}}
							融资完成
						{{else if eq $company.Apply 4}}
							融资未成功
						{{end}}
					</span>&nbsp;&nbsp;
					<i class="fa fa-eye"></i>&nbsp;{{$company.Readed}}
				</div>
				<div class="brand-body">
					<div class="logo-img">
						<a href="/item/info/{{$company.Id}}">
							<img src="{{$company.Logo}}" class="img-circle" alt=""> </a>
					</div>
					<div class="brand-footer">
						<h4 class="brand-name"><a href="/item/info/{{$company.Id}}">{{$company.Name}}</a></h4>
						<p>{{$company.Intro}}</p> 
					</div>
				</div>
				{{range $i,$loop := $loops}}
					{{if eq $loop.CompanyId $company.Id}}
					<div class="brand-info">
						<div class="col-md-5 brand-loop" data-value="{{$loop.Loop}}">&nbsp;</div>
						<div class="col-md-5 col-md-offset-2">{{$loop.Investor}}</div>
					</div>
					<div class="brand-info">
						<div class="col-md-5">
							<span class="brand-money" data-value="{{$loop.AmountMoney}}"></span>
							{{$loop.Amount}}万
						</div>
					</div>
					{{end}}
				{{end}}
			</div>
		</div>
		{{end}}
	</div>
	{{end}}

	{{if gt (len .apply) 0}}
	<div class="brand-zone row snow-padding-top-40">
		<div>
			<p class="pull-right"><a class="link" href="/item/index">更多 <span class="fa fa-angle-right"></span></a>
			</p>
			<h5>正在融资</h5>
		</div>
		{{$loops := .applyLoop}}
		{{range $index,$company := .apply}}
		<div class="col-md-4 col-sm-4 col-xs-4 brand-card-container">
			<div class="brand-card">
				<div class="abs-top small" style="padding: 5px;right: 0;">
					<span>
						{{if eq $company.Apply 0}}
							尚未申请融资
						{{else if eq $company.Apply 1}}
							正在融资中
						{{else if eq $company.Apply 2}}
							正在融资中
						{{else if eq $company.Apply 3}}
							融资完成
						{{else if eq $company.Apply 4}}
							融资未成功
						{{end}}
					</span>&nbsp;&nbsp;
					<i class="fa fa-eye"></i>&nbsp;{{$company.Readed}}
				</div>
				<div class="brand-body">
					<div class="logo-img">
						<a href="/item/info/{{$company.Id}}">
							<img src="{{$company.Logo}}" class="img-circle" alt=""> </a>
					</div>
					<div class="brand-footer">
						<h4 class="brand-name"><a href="/item/info/{{$company.Id}}">{{$company.Name}}</a></h4>
						<p>{{$company.Intro}}</p> 
					</div>
				</div>
				{{range $i,$loop := $loops}}
					{{if eq $loop.CompanyId $company.Id}}
					<div class="brand-info">
						<div class="col-md-5 brand-loop" data-value="{{$loop.Loop}}">&nbsp;</div>
						<div class="col-md-5 col-md-offset-2">{{$loop.Investor}}</div>
					</div>
					<div class="brand-info">
						<div class="col-md-5">
							<span class="brand-money" data-value="{{$loop.AmountMoney}}"></span>
							{{$loop.Amount}}万
						</div>
					</div>
					{{end}}
				{{end}}
			</div>
		</div>
		{{end}}
	</div>
	{{end}}

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
	})(jQuery);
	
	$(function(){
		function getBasicName(type,value){
			var _name='';
			$.each(snow.basic,function(i,item){
				if(item.type==type && item.value==value){
					_name = item.name;
					return false;
				}
			});
			return _name;
		}
		function setBasic(){
			// 融资
			$('.brand-loop').each(function(i,item){
				var _this = $(item),_loop = _this.data('value');
				_this.text(getBasicName(6,_loop));
			});
			// 币种
			$('.brand-money').each(function(i,item){
				var _this = $(item),_money = _this.data('value');
				_this.text(getBasicName(7,_money));
			});
		}
		
		// 基础数据
		if(snow.basic){
			setBasic();
		}else{
			$.getJSON('/item/basic',function(json){
				if(json.ok){
					snow.basic = json.data;
					setBasic();
				}else{
					
				}
			});
		}
	});
</script>