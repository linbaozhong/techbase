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
					<p class="small">{{.company.Intro}}</p>

				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="row">
		<div class="col-md-10 col-md-offset-1">
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
		<div class="col-md-10 col-md-offset-1">
			<div class="row">
				<div class="col-md-8">
					<div style="height: 100px;">{{.introduce.Content}}</div>
					<ul>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-map-marker"></i> <span id="company-city">
							北京
						</span></li>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-tags"></i> <span id="company-field">
							
						</span></li>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-money"></i> <span id="company-loop">
							
						</span></li>
						<li style="display: inline-block;margin-right:15px;"><i class="fa fa-tree"></i> <span id="company-state">
							
						</span></li>
						{{if eq .company.Status 2 }}
							{{if eq .company.Creator .account.Id}}
								<li class="pull-left"><i class="fa fa-tree"></i> <span>
									{{if eq .company.Apply 0}}
										尚未申请融资
									{{else if eq .company.Apply 1}}
										正在融资中
									{{else if eq .company.Apply 2}}
										融资完成
									{{else if eq .company.Apply 3}}
										融资未成功
									{{end}}
								</span></li>
							{{else if or (eq .company.Apply 1) (eq .company.Apply 2)}}
								<li class="pull-left"><i class="fa fa-tree"></i> <span>
									{{if eq .company.Apply 1}}
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
				<div class="col-md-3 col-md-offset-1">
					<a href="#">
						<img class="" src="{{.links.Qrcode}}" style="width: 150px;">
					</a>
				</div>
			</div>			
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="col-md-10 col-md-offset-1" style="overflow: hidden;height: 510px;padding: 0;">
			{{$imgs := (split .introduce.Images ";")}}
			<ul id="snow-img-list" class="" style="position:absolute;margin-top: 10px;width: 1325px;height: 500px;">
				{{range $i,$img := $imgs}}
				<li style="display: inline-block;margin-right:15px;">
					<img src="{{$img}}" style="width: 250px;">
				</li>
				{{end}}
			</ul>
			<div style="position:absolute;top: 225px;width: 100%;padding: 10px;">
				<a href="#" id="snow-to-left"><i class="fa fa-5x fa-angle-left"></i></a>
				<a href="#" id="snow-to-right" class="pull-right"><i class="fa fa-5x fa-angle-right"></i></a>
			</div>
		</div>
	</div>
			<!--创始团队-->
	<div class="row">
		<div class="col-md-10 col-md-offset-1">
			<h4>创始团队</h4>
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="form-horizontal col-md-10 col-md-offset-1">
			{{range .members}}
			<div class="snow-member col-md-3 snow-members-{{.Id}}">
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
	<div class="row">
		<div class="col-md-10 col-md-offset-1">
			<h4>融资经历</h4>
			<hr />
		</div>
	</div>
	<div class="row">
		<div class="form-horizontal col-md-10 col-md-offset-1">

			<!--融资经历个体-->
			{{range .loops}}
			<div class="col-md-5 snow-loop snow-loops-{{.Id}}">
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
//	snow.getPlace = function(v){
//		_place = '创始人';
//		$.each(snow.place, function(index,item) {  
//			console.log(v,item.value);
//			if (v == item.value) {
//				_place = item.name;
//				return false;
//			}
//		});
//		return _place;
//	};
//	
	$(function(){
		// 图片左右滚动
		$('#snow-to-left').click(function(e){
			e.preventDefault();
			var _obj = $('#snow-img-list');
			var _left = _obj.position().left+300;
			_left = _left > 0 ? 0:_left;
			
			_obj.animate({
				left:_left
			});
		});
		$('#snow-to-right').click(function(e){
			e.preventDefault();
			var _obj = $('#snow-img-list');
			var _left = _obj.position().left-300;
			
			_left = _left <= _obj.parent().width()-_obj.width() ? _obj.position().left : _left;
			
			_obj.animate({
				left:_left
			});
		});
		
		
		$.getJSON('/basic/place', function(json) {
			console.log(json);
			if (json.ok) {
				$.each(json.data, function(index, item) {
					//snow.place = json.data;
					// 修复创始成员
					$('.snow-member-' + item.value).text(item.name);
				});
			} else {}
		});
		// 读取城市选项
		$.getJSON('/basic/city',{parentId:'{{.company.Country}}'},function(json){
			console.log(json);
			if (json.ok) {
				$.each(json.data, function(index,item) {    
					if (item.value == '{{.company.City}}') {
						$('#company-city').text(item.name);
						return false;
					}
				});
			} else{
				
			}
		})
		// 公司领域
		$.getJSON('/basic/field',function(json){
			console.log('{{.company.Field}}',json);
			if (json.ok) {
				var _html=[],_field='{{.company.Field}}'.split(',');
				
				$.each(json.data, function(index,item) {    
					if ($.inArray(item.value.toString(),_field) != -1) {
						_html.push(item.name);                                                          
					}
				});
				$('#company-field').text(_html.join(','));
			} else{
				
			}
		});
		// 运营状态
		$.getJSON('/basic/state',function(json){
			console.log(json);
			if (json.ok) {
				$.each(json.data, function(index,item) {    
					if (item.value == '{{.company.State}}') {
						$('#company-state').text(item.name);
						return false;
					}
				});
			} else{
				
			}
		});
		// 读取融资轮次
		$.getJSON('/basic/loop',function(json){
			if (json.ok) {
				$.each(json.data, function(index,item) {    
					// 修复融资经历时间线
					$('.snow-loop-'+item.value).text(item.name);
					$('#company-loop').text(item.name);
				});
			} else{
				
			}
		});
		
		// 读取币种
		$.getJSON('/basic/money',function(json){
			if (json.ok) {
				$.each(json.data, function(index,item) {    
					// 修复融资经历时间线
					$('.snow-money-'+item.value).addClass('fa-'+item.alias);
				});
			} else{
				
			}
		});
		
		
	});

</script>