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
<style type="text/css">
	.snow-yeqian{
		padding: 10px 20px 10px 40px;margin-left: -30px;background-color: #fe4a66;color: #fff;border-radius: 0 10px 0 0;
	}
</style>
<article class="container">
	{{if gt (len .startup) 0}}
	<div class="brand-zone">
		<div>
			<p class="pull-right"><a class="link" href="/item/index">更多 <span class="fa fa-angle-right"></span></a>
			</p>
			<h5 style="margin-bottom: 30px;">
				<span class="snow-yeqian">Her Startup女性创业大赛</span>
			</h5>
		</div>
		{{$loops := .startupLoop}}
		{{range $index,$company := .startup}}
		<div class="col-md-4 col-sm-4 col-xs-4 brand-card-container">
			<div class="brand-card">
				<div class="small abs-top" style="padding: 5px;left: 0;right: 0;">
					<span class="pull-left">
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
					</span>
					<span class="pull-right">
					<i class="fa fa-eye"></i>&nbsp;{{$company.Readed}}</span>
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
						<span class="brand-loop" data-value="{{$loop.Loop}}"></span>
						{{if gt $loop.Loop 0}}
							<span class="brand-money snow-color-red" data-value="{{$loop.AmountMoney}}"></span>
							<span class="snow-color-red">{{$loop.Amount}}万</span>
						{{end}}
					</div>
					<div class="brand-info small">
						{{$loop.Investor}}
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
			<h5 style="margin-bottom: 30px;">
				<span class="snow-yeqian"></span>正在融资
			</h5>
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

</article>
<script type="text/javascript">

	$(function(){
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