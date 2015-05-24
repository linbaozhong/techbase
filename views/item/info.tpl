<style type="text/css">
	#snow-img-list{
		position: absolute;
		margin-top: 10px;
		width: 1350px;
		height: 500px;
	}
	#snow-img-list li{
		display: inline-block;
		margin-right: 15px;
		width: 300px;
		height: 500px;
		overflow: hidden;
	}
</style>
<div class="banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					<div class="img-circle" style="width: 100px;height: 100px;border: 1px solid #eee;overflow: hidden;margin: 0 auto;">
						<img src="{{.company.Logo}}" style="width:100px;"/>
						{{if eq .company.Creator .account.Id}}
						<p class="small abs-top" style="margin-left: 220px;top: 40px;">
							{{if eq .company.Status 0}}
								<span title="您的项目仍未提交审核，请尽快完善公司注册内容并提交审核，审核通过后，她本营的工作人员会与您取得进一步联系">未提交审核</span>
							{{else if eq .company.Status 1}}
								<span title="您的项目正在审核中，审核会在3个工作日内完成，审核通过后，即可展示在“她项目”">审核中</span>
							{{else if eq .company.Status 2}}
								<span>审核通过</span>
							{{else}}
								<span title="{{.company.Reason}}">审核未通过</span>
							{{end}}
						</p>
						{{end}}
					</div>
					<h3>{{.company.Name}}</h3>
					<h5>{{.company.Intro}}</h5>
					<p class="small"><span class="company-field"></span>&nbsp;<span class="company-loop"></span></p>
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="row">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<h4>项目简介</h4>
			<div class="pull-right">
				{{if eq .company.Creator .account.Id}}
					{{if eq .company.Status 0}}
						<a href="/company/edit/{{.company.Id}}"><i class="fa fa-pencil"></i>&nbsp;编辑</a>&nbsp;&nbsp;&nbsp;
					{{end}}
				<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的公司</a>
				{{end}}
			</div>
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<div class="row">
				<div class="col-md-8 col-xs-8">
					<div style="height: 110px;overflow: hidden;">{{.introduce.Content}}</div>
					<ul>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-map-marker"></i> <span id="company-city">
							北京
						</span></li>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-tags"></i> <span class="company-field">
							
						</span></li>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-money"></i> <span class="company-loop">
							
						</span></li>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-tree"></i> <span id="company-state">
							
						</span></li>
						{{if eq .company.Status 2 }}
							{{if eq .company.Creator .account.Id}}
								<li style="display: inline-block;margin-right:15px;"><i class="fa fa-money"></i> <span>
									{{if eq .company.Apply 0}}
										尚未申请融资
									{{else if eq .company.Apply 1}}
										正在融资中
									{{else if eq .company.Apply 2}}
										正在融资中
									{{else if eq .company.Apply 3}}
										融资完成
									{{else if eq .company.Apply 4}}
										融资未成功
									{{end}}
								</span></li>
							{{else if or (eq .company.Apply 2) (eq .company.Apply 3)}}
								<li style="display: inline-block;margin-right:15px;"><i class="fa fa-money"></i> <span>
									{{if eq .company.Apply 2}}
										正在融资中
									{{else}}
										融资完成
									{{end}}
								</span></li>
							{{end}}
						{{end}}
					</ul>
					<div class="">
						<i class="fa fa-home"></i> {{.company.Website}}
					</div>
				</div>
				<div class="col-md-3 col-xs-3 col-md-offset-1 col-xs-offset-1">
					<a href="#">
						<img class="" src="{{.links.Qrcode}}" style="width: 150px;">
					</a>
				</div>
			</div>			
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1" style="overflow: hidden;height: 510px;">
			<div style="position:relative;width: 100%;height: 100%;overflow: hidden;">
				{{$imgs := (split .introduce.Images ";")}}
				<ul id="snow-img-list">
					{{range $i,$img := $imgs}}
					<li>
						<img src="{{$img}}" >
					</li>
					{{end}}
				</ul>
				<div style="position:absolute;top: 220px;width: 100%;padding: 10px;">
					<a href="#" id="snow-to-left"><i class="fa fa-5x fa-angle-left"></i></a>
					<a href="#" id="snow-to-right" class="pull-right"><i class="fa fa-5x fa-angle-right"></i></a>
				</div>
			</div>
		</div>
	</div>
			<!--创始团队-->
	<div class="row snow-padding-top-40">
		<div class="col-md-10 col-md-offset-1">
			<h4>创始团队</h4>
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="form-horizontal col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			{{range .members}}
			<div class="snow-member col-md-3 col-xs-3 snow-members-{{.Id}}">
				<div class="snow-avatar img-circle">
					<img src="{{.Avatar}}" />
				</div>
				<div>
					<label class="control-label">{{.Name}}</label>
				</div>
				<div>
					<span class="snow-member-{{.Place}}"></span> <span>{{.Title}}</span>
				</div>
			</div>
			{{end}}
		</div>
		<div class="col-sm-1"></div>
	</div>

	<!--融资经历-->
	<div class="row snow-padding-top-40">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<h4>融资经历</h4>
			<div class="pull-right">
				{{if eq .company.Creator .account.Id}}
					<i class="fa fa-money"></i> 
						{{if eq .company.Status 2 }}
							{{if eq .company.Apply 0}}
								<a href="/apply/index/{{.company.Id}}">申请融资</a>
							{{else if eq .company.Apply 1}}
								<span>正在融资中</span>
							{{else if eq .company.Apply 2}}
								<span>正在融资中</span>
							{{else if eq .company.Apply 3}}
								<a href="/apply/index/{{.company.Id}}">融资完成,再次申请</a>
							{{else if eq .company.Apply 4}}
								<a href="/apply/index/{{.company.Id}}">融资未成功,再次申请</a>
							{{end}}
						{{else if eq .company.Status 1}}
							<span title="审核通过后即可快速申请融资">申请融资</span>
						{{else}}
							<span>申请融资</span>
						{{end}}
				{{else if or (eq .company.Apply 1) (eq .company.Apply 2)}}
					<i class="fa fa-money"></i>
						{{if eq .account.Role 2}}
							<a href="#">查看融资进度</a>
						{{else}}
							<a href="#">申请成为投资人,查看融资进度</a>
						{{end}}
				{{end}}
			</div>
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="form-horizontal col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">

			<!--融资经历个体-->
			{{range .loops}}
			<div class="col-md-5 col-xs-5 snow-loop snow-loops-{{.Id}}">
				<div>
					<label class="control-label lead snow-loop-{{.Loop}}"></label><span>{{.Year}}.{{.Month}}</span>
				</div>
				<div class="clearfix">
					<div class="pull-left">
						<label class="control-label">融资金额:</label><span><i class="fa snow-money-{{.AmountMoney}}"></i> {{.Amount}}</span><span>万</span>
					</div>
					<div class="pull-right">
						<label class="control-label">融资估值:</label><span><i class="fa snow-money-{{.ValueMoney}}"></i> {{.Value}}</span><span>万</span>
					</div>
				</div>
				<hr />
				<div>
					<label class="control-label">{{.Investor}}</label>
				</div>
			</div>
			{{end}}
		</div>
			
	</div>
</article>
<script type="text/javascript">

	$(function(){
		$('#snow-img-list').css({
			width:($('#snow-img-list li:eq(0)').outerWidth() 
				+ parseInt($('#snow-img-list li:eq(0)').css('marginLeft')) 
				+ parseInt($('#snow-img-list li:eq(0)').css('marginRight')) 
				+ 5) * $('#snow-img-list li').length
		});
		
		$('#snow-img-list img').load(function(){
			var _this=$(this),_img=_this.attr('src');
			console.log(_img,_this.width(),_this.height());
			if(_this.width() > _this.height()){
				_this.css({height:500,width:'initial'});
			}else{
				_this.css({width:_this.parent().width(),height:'initial'});
			}
		});
		// 图片左右滚动
		$('#snow-to-left').click(function(e){
			e.preventDefault();
			var _obj = $('#snow-img-list');
			// 宽度小，无需移动
			if(_obj.width()<=_obj.parent().width()){
				return;
			}
			// 计算移动的距离
			var _left = _obj.position().left + 400;
			_left = _left > 0 ? 0:_left;
			
			_obj.animate({
				left:_left
			});
		});
		$('#snow-to-right').click(function(e){
			e.preventDefault();
			var _obj = $('#snow-img-list');
			// 宽度小，无需移动
			if(_obj.width()<=_obj.parent().width()){
				return;
			}
			// 计算移动的距离
			var _left = _obj.position().left - 400;
			
			_left = _left <= _obj.parent().width()-_obj.width() ? _obj.parent().width()-_obj.width() : _left;
			
			_obj.animate({
				left:_left
			});
		});
		
		function setBasic(){
			var _loop='',
				_field_opts=[],
				_field='{{.company.Field}}'.split(',');
				
			$.each(snow.basic,function(i,item){
				switch (item.type){
					case 2://城市
						if (item.value == '{{.company.City}}') {
							$('#company-city').text(item.name);
						}
						break;
					case 3://行业
						if ($.inArray(item.value.toString(),_field) != -1) {
							_field_opts.push(item.name);                                                          
						}
						break;
					case 4://运营状态
						if (item.value == '{{.company.State}}') {
							$('#company-state').text(item.name);
						}
						break;
					case 5:// 修复创始成员
						$('.snow-member-' + item.value).text(item.name);
						break;
					case 6://融资轮次
						$('.snow-loop-'+item.value).text(item.name);
						_loop = item.name;
						break;
					case 7://币种
						$('.snow-money-'+item.value).addClass('fa-'+item.alias);
						break;
					default:
						break;
				}
				$('.company-field').text(_field_opts.join(' '));
				$('.company-loop').text(_loop);
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
		
//		$.getJSON('/item/place', function(json) {
//			//console.log(json);
//			if (json.ok) {
//				$.each(json.data, function(index, item) {
//					//snow.place = json.data;
//					// 修复创始成员
//					$('.snow-member-' + item.value).text(item.name);
//				});
//			} else {}
//		});
//		// 读取城市选项
//		$.getJSON('/item/city',{parentId:'{{.company.Country}}'},function(json){
//			//console.log(json);
//			if (json.ok) {
//				$.each(json.data, function(index,item) {    
//					if (item.value == '{{.company.City}}') {
//						$('#company-city').text(item.name);
//						return false;
//					}
//				});
//			} else{
//				
//			}
//		})
//		// 公司领域
//		$.getJSON('/item/field',function(json){
//			//console.log('{{.company.Field}}',json);
//			if (json.ok) {
//				var _html=[],_field='{{.company.Field}}'.split(',');
//				
//				$.each(json.data, function(index,item) {    
//					if ($.inArray(item.value.toString(),_field) != -1) {
//						_html.push(item.name);                                                          
//					}
//				});
//				$('.company-field').text(_html.join(' '));
//			} else{
//				
//			}
//		});
//		// 运营状态
//		$.getJSON('/item/state',function(json){
//			//console.log(json);
//			if (json.ok) {
//				$.each(json.data, function(index,item) {    
//					if (item.value == '{{.company.State}}') {
//						$('#company-state').text(item.name);
//						return false;
//					}
//				});
//			} else{
//				
//			}
//		});
//		// 读取融资轮次
//		$.getJSON('/item/loop',function(json){
//			var _loop='';
//			if (json.ok) {
//				$.each(json.data, function(index,item) {    
//					// 修复融资经历时间线
//					$('.snow-loop-'+item.value).text(item.name);
//					_loop = item.name;
//				});
//			} else{
//				
//			}
//			$('.company-loop').text(_loop);
//		});
		
//		// 读取币种
//		$.getJSON('/item/money',function(json){
//			if (json.ok) {
//				$.each(json.data, function(index,item) {    
//					// 修复融资经历时间线
//					$('.snow-money-'+item.value).addClass('fa-'+item.alias);
//				});
//			} else{
//				
//			}
//		});
		
		
	});

</script>