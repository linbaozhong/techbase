<div class="banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					<button id="snow-create-item" class="btn btn-primary" style="margin-top: 160px;">创建项目 精准融资</button>
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="row">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<div id="snow-item-condition" class="row snow-row-1">
				<dl class="snow-condition">
					<dt>融资状态</dt>
					<dd>
						<a href="javascript:;" class="active" data-name="apply" data-value="-1">全部</a>
						<a href="javascript:;" data-name="apply">融资完成</a>
						<a href="javascript:;" data-name="apply">正在融资中</a>
					</dd>
				</dl>
				<dl id="snow-basic-field" class="snow-condition">
					<dt>所在行业</dt>
					<dd>
						<a href="javascript:;" class="active" data-name="field" data-value="-1">全部</a>
					</dd>
				</dl>
				<dl id="snow-basic-city" class="snow-condition">
					<dt>所在地</dt>
					<dd>
						<a href="javascript:;" class="active" data-name="city" data-value="-1">全部</a>
					</dd>
				</dl>
				<dl class="snow-condition">
					<dt>项目来源</dt>
					<dd>
						<a href="javascript:;" class="active" data-name="source" data-value="-1">全部</a>
						<a href="javascript:;" data-name="source">Her Startup大赛</a>
					</dd>
				</dl>
				<dl id="snow-basic-loop" class="snow-condition">
					<dt>已融资轮次</dt>
					<dd>
						<a href="javascript:;" class="active" data-name="loop" data-value="-1">不限</a>
					</dd>
				</dl>
			</div>
			<!--创建公司-->
			<div class="row snow-row-1 snow-padding-top-40 snow-padding-bottom-40">
				{{range $index,$company := .companys}}
				<div class="snow-media col-xs-4">
					<div class="media-left">
						<a href="/item/info/{{$company.Id}}" target="_blank">
							<img class="media-object" src="{{$company.Logo}}" style="width: 100px;">
						</a>
					</div>
					<div class="media-body">
						<p><span class="media-heading lead">{{$company.Name}}</span> 
							{{if eq $company.Status 0}}
							<span class="pull-right small">未提交审核</span>
							{{else if eq $company.Status 1}}
							<span class="pull-right small">等待审核中</span>
							{{else if eq $company.Status 2}}
							<span class="pull-right small">审核通过</span>
							{{else}}
							<span class="pull-right small">审核未通过</span>
							{{end}}
						</p>
						<p>{{$company.Intro}}</p>
					</div>
				</div>
				{{end}}
			</div>
		</div>
	</div>
</article>
<script type="text/javascript">
	$(function() {
		function setCondition(){
			var _field=[],
				_city=[],
				_loop=[];
			$.each(snow.basic,function(i,item){
				switch (item.type){
					case 2:
						_city.push('<a href="javascript:;" data-name="city" data-value="'+item.value+'">'+item.name+'</a>');
						break;
					case 3:
						_field.push('<a href="javascript:;" data-name="field" data-value="'+item.value+'">'+item.name+'</a>');
						break;
					case 6:
						_loop.push('<a href="javascript:;" data-name="loop" data-value="'+item.value+'">'+item.name+'</a>');
						break;
					default:
						break;
				}
			});
			// 城市选项
			$('#snow-basic-city dd').append(_city.join(''));
			// 行业选项
			$('#snow-basic-field dd').append(_field.join(''));
			// 融资轮选项
			$('#snow-basic-loop dd').append(_loop.join(''));
		};
		// 基础数据
		if(snow.basic){
			setCondition();
		}else{
			$.getJSON('/item/basic',function(json){
				if(json.ok){
					snow.basic = json.data;
					setCondition();
				}else{
					
				}
			});
		}
		// 选择查询条件
		$('#snow-item-condition').on('click','a',function(e){
			e.stopPropagation();
			var _this = $(this).addClass('active').siblings('.active').removeClass('active');
			
		});
		// 创建项目按钮
		$('#snow-create-item').click(function(){
			if(snow.checkin(true)){
				snow.go('/company/edit');
			}else{
				$('.login').click();
			}
		});
	});
</script>