<div class="container banner" style="margin-top:75px;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					<button id="snow-create-item" class="btn btn-primary" style="margin-top: 290px;">创建项目 精准融资</button>
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container" style="background-color: #eee;padding: 50px 30px; margin-top: 0;">

	<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
		<div id="snow-item-condition" class="row snow-row-1">
			<dl class="snow-condition">
				<dt>融资状态</dt>
				<dd>
					<a href="javascript:;" class="{{if eq .apply -1}}active{{end}}" data-name="apply" data-value="-1">全部</a>
					<a href="javascript:;" class="{{if eq .apply 3}}active{{end}}" data-name="apply" data-value="3">融资完成</a>
					<a href="javascript:;" class="{{if eq .apply 2}}active{{end}}" data-name="apply" data-value="2">正在融资中</a>
				</dd>
			</dl>
			<dl id="snow-basic-field" class="snow-condition">
				<dt>所在行业</dt>
				<dd>
					<a href="javascript:;" class="{{if eq .field -1}}active{{end}}" data-name="field" data-value="-1">全部</a>
				</dd>
			</dl>
			<dl id="snow-basic-city" class="snow-condition">
				<dt>所在地</dt>
				<dd>
					<a href="javascript:;" class="{{if eq .city -1}}active{{end}}" data-name="city" data-value="-1">全部</a>
				</dd>
			</dl>
			<dl class="snow-condition">
				<dt>项目来源</dt>
				<dd>
					<a href="javascript:;" class="{{if eq .source -1}}active{{end}}" data-name="source" data-value="-1">全部</a>
					<a href="javascript:;" class="{{if eq .source 1}}active{{end}}" data-name="source" data-value="1">Her Startup大赛</a>
				</dd>
			</dl>
			<dl id="snow-basic-loop" class="snow-condition">
				<dt>已融资轮次</dt>
				<dd>
					<a href="javascript:;" class="{{if eq .loop -1}}active{{end}}" data-name="loop" data-value="-1">不限</a>
				</dd>
			</dl>
		</div>
		<!--创建公司-->
		<div class="row snow-row-1 snow-padding-top-40 snow-padding-bottom-40" style="margin-right: -25px;margin-left: -25px;">
			{{$loops := .applyLoop}} {{range $index,$company := .companys}}
			<a href="/item/info/{{$company.Id}}" target="_blank">
				<div class="snow-media col-xs-4" style="text-align: center;padding:10px;">
					<div style="background:#fff;padding:10px;height: 100%;">
						<div style="padding:10px;">
							<img class="" src="{{$company.Logo}}" style="width: 100px;height: 100px;">
						</div>
						<div class="media-body">
							{{$company.Name}}
						</div>
					</div>
				</div>
			</a>
			{{end}}
		</div>
	</div>

</article>
<script type="text/javascript">
	$(function() {
		function setCondition(){
			var _field=[],
				_city=[],
				_loop=[],
				_class='';
				
			$.each(snow.basic,function(i,item){
				switch (item.type){
					case 2:
						_class = (item.value.toString() == '{{.city}}') ? 'active' : '';
						_city.push('<a class="'+_class+'" href="javascript:;" data-name="city" data-value="'+item.value+'">'+item.name+'</a>');
						break;
					case 3:
						_class = (item.value.toString() == '{{.field}}') ? 'active' : '';
						_field.push('<a class="'+_class+'" href="javascript:;" data-name="field" data-value="'+item.value+'">'+item.name+'</a>');
						break;
					case 6:
						_class = (item.value.toString() == '{{.loop}}') ? 'active' : '';
						_loop.push('<a class="'+_class+'" href="javascript:;" data-name="loop" data-value="'+item.value+'">'+item.name+'</a>');
						$('.brand-loop-'+item.value).text(item.name);
						break;
					case 7:
						$('.brand-money-'+item.value).text(item.name);
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
			//
			var _cond = [];
			$('#snow-item-condition a.active').each(function(i,item){
				var _item = $(item);
				_cond.push(_item.data('name')+'='+ _item.data('value'));
			});
			snow.go(window.location.pathname +'?' +_cond.join('&'));
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