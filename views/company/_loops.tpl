<div class="row">
	<div class="col-md-10 col-md-offset-1">
		<h4>{{.subTitle}}</h4>
		<div class="pull-right">
			<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的项目</a>
		</div>
		<hr />
	</div>
</div>

<div class="row">
	<div class="col-md-8 col-md-offset-2">
		<!--这里是融资经历编辑器-->
		<form class="form-horizontal snow-form-6">
			<div class="form-group">
				<div class="col-sm-3">
				</div>
				<div class="col-sm-9">
					<div class="alert snow-alert-6" role="alert"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span class="snow-required">*</span>轮次</label>
				<div class="col-sm-3">
					<select class="form-control" required name="loop">
						<option value=""></option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">融资金额</label>
				<div class="col-sm-3">
					<select class="form-control" name="amountMoney">
						<option value="">美元</option>
					</select>
				</div>
				<div class="col-sm-3">
					<input class="form-control" name="amount" placeholder="" value="">
				</div>
				<div class="col-sm-3">
					<label class="control-label">万</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">估值</label>
				<div class="col-sm-3">
					<select class="form-control" name="valueMoney">
						<option value="">美元</option>
					</select>
				</div>
				<div class="col-sm-3">
					<input class="form-control" name="value" placeholder="" value="">
				</div>
				<div class="col-sm-3">
					<label class="control-label">万</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span class="snow-required">*</span>融资时间</label>
				<div class="col-sm-3">
					<select class="form-control" required name="year">
						<option value="2014">2014 年</option>
						<option value="2015">2015 年</option>
						<option value="2016">2016 年</option>
					</select>
				</div>	
				<div class="col-sm-3">
					<select class="form-control" required name="month">
						<option value="1">1 月</option>
						<option value="2">2 月</option>
						<option value="3">3 月</option>
						<option value="4">4 月</option>
						<option value="5">5 月</option>
						<option value="6">6 月</option>
						<option value="7">7 月</option>
						<option value="8">8 月</option>
						<option value="9">9 月</option>
						<option value="10">10 月</option>
						<option value="11">11 月</option>
						<option value="12">12 月</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">投资主体</label>
				<div class="col-sm-9">
					<input class="form-control" name="investor" placeholder="如：经纬中国" value="">
				</div>
			</div>
	
			<div class="form-group">
				<label for="inputIntro" class="col-sm-3 control-label">
					<input type="hidden" name="id" value="" />
					<input type="hidden" name="companyId" value="{{.companyId}}" />
				</label>
				<div class="col-sm-9">
					<button type="submit" class="btn btn-primary col-sm-5 pull-left">保存</button>
					<button type="reset" class="btn btn-primary col-sm-5 pull-right">重置</button>
				</div>
			</div>
		</form>
		<!--这里是融资经历时间线-->	
		<div class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label"></label>
				<div class="col-sm-9 snow-list-6">
					<!--融资经历个体-->
					{{range .loops}}
					<div class="snow-loop snow-loops-{{.Id}}">
						<div class="snow-tools">
							<a class="snow-edit" href="#" data-id="{{.Id}}"><i class="fa fa-pencil"></i></a> 
							<a class="snow-del" href="#" data-id="{{.Id}}"><i class="fa fa-times"></i></a>
						</div>
						<div>
							<label class="control-label lead snow-loop-{{.Loop}}">天使轮</label><span>{{.Year}}.{{.Month}}</span>
						</div>
						<div class="clearfix">
							<div class="pull-left"><label class="control-label">融资金额:</label><span><i class="fa snow-money-{{.AmountMoney}}"></i> {{.Amount}}</span><span>万</span></div>
							<div class="pull-right"><label class="control-label">融资估值:</label><span><i class="fa snow-money-{{.ValueMoney}}"></i> {{.Value}}</span><span>万</span></div>
						</div>
						<hr />
						<div>
							<label class="control-label">{{.Investor}}</label>
						</div>
					</div>
					{{end}}
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	snow.getLoop = function(v){
		_loop = 'A轮';
		$.each(snow.loop, function(index,item) {    
			if (v == item.value) {
				_loop = item.name;
				return false;
			}
		});
		return _loop;
	};
	snow.getMoney = function(v){
		_money='人民币';
		$.each(snow.money, function(index,item) {    
			if (v == item.value) {
				_money = item.alias;
				return false;
			}
		});
		return _money;
	};
	
	$(function(){
		var _template = 
			'<div class="snow-loop snow-loops-<%.id%>">'
				+'<div class="snow-tools">'
					+'<a class="snow-edit" href="#" data-id="<%.id%>"><i class="fa fa-pencil"></i></a>&nbsp;'
					+'<a class="snow-del" href="#" data-id="<%.id%>"><i class="fa fa-times"></i></a>'
				+'</div>'
				+'<div>'
					+'<label class="control-label lead"><%.loop%></label><span><%.year%>.<%.month%></span>'
				+'</div>'
				+'<div class="clearfix">'
					+'<div class="pull-left"><label class="control-label">融资金额:</label><span><i class="fa fa-<%.aalias%>"></i> <%.amount%></span><span>万</span></div>'
					+'<div class="pull-right"><label class="control-label">融资估值:</label><span><i class="fa fa-<%.valias%>"></i> <%.value%></span><span>万</span></div>'
				+'</div>'
				+'<hr />'
				+'<div>'
					+'<label class="control-label"><%.investor%></label>'
				+'</div>'
			+'</div>';
		// 读取融资轮次
		$.getJSON('/basic/loop',function(json){
			if (json.ok) {
				var _html=[];
				// 前端使用
				snow.loop = json.data;
				
				$.each(json.data, function(index,item) {    
					_html.push('<option');
					_html.push(' value="'+item.value+'">'+item.name+'</option>');    
					// 修复融资经历时间线
					$('.snow-list-6 .snow-loop-'+item.value).text(item.name);
				});
				$('.snow-form-6 select[name="loop"]').empty().html(_html.join(''));
			} else{
				
			}
		});
		// 读取币种
		$.getJSON('/basic/money',function(json){
			if (json.ok) {
				var _html=[];
				// 前端使用
				snow.money = json.data;
				
				$.each(json.data, function(index,item) {    
					_html.push('<option');
					_html.push(' value="'+item.value+'">'+item.name+'</option>');
					// 修复融资经历时间线
					$('.snow-list-6 .snow-money-'+item.value).addClass('fa-'+item.alias);
				});
				$('.snow-form-6 select[name="amountMoney"]').empty().html(_html.join(''));
				$('.snow-form-6 select[name="valueMoney"]').empty().html(_html.join(''));
			} else{
				
			}
		});
		// 编辑 删除
		$('.snow-list-6').on('click','.snow-edit',function(e){
			e.preventDefault();
			// 读取实体
			var _this=$(this);
			$.getJSON('/company/getloop',{id:_this.data('id')},function(json){
				console.log(json);
				if (json.ok) {
					var _form = $('form.snow-form-6').show();
					_form.find('input[name="id"]').val(json.data.id);
					_form.find('input[name="companyId"]').val(json.data.companyId);
					_form.find('input[name="amount"]').val(json.data.amount);
					_form.find('input[name="value"]').val(json.data.value);
					_form.find('input[name="investor"]').val(json.data.investor);
					_form.find('select[name="loop"]').val(json.data.loop);
					_form.find('select[name="amountMoney"]').val(json.data.amountMoney);
					_form.find('select[name="valueMoney"]').val(json.data.valueMoney);
					_form.find('select[name="year"]').val(json.data.year);
					_form.find('select[name="month"]').val(json.data.month);
				} else{
					showMessage($('.snow-alert-6'),json.message,false);
				}
			});
		}).on('click','.snow-del',function(e){
			e.preventDefault();
			
			if (snow.confirm('你确定要删除吗?')) {
				var _this=$(this);
				$.getJSON('/company/deleteloops',{id:_this.data('id')},function(json){
					if (json.ok) {
						_this.closest('.snow-loop').remove();
					} else{
						showMessage($('.snow-alert-6'),json.message,false);
					}
				})
			}
		});
//		// 增加按钮事件
//		$('button.snow-add-6').click(function(){
//			$('form.snow-form-6').show();
//		});
		// 提交表单
		$('form.snow-form-6').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 检查项目主体是否已经存在
			if (_form.find('input[name="companyId"]').val() <= 0) {
				showMessage($('.snow-alert-6'),'项目不存在，请创建项目后重试',false);
				return false;
			}
			
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postloops',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					showMessage($('.snow-alert-6'),'hi,我已经为你保存好了,不用谢了……',true);
					// 写入融资经历时间线
					var _html = _template
							.replace(/<%.id%>/ig,json.data.id)
							.replace(/<%.loop%>/ig,snow.getLoop(json.data.loop))
							.replace(/<%.year%>/ig,json.data.year)
							.replace(/<%.month%>/ig,json.data.month)
							.replace(/<%.aalias%>/ig,snow.getMoney(json.data.amountMoney))
							.replace(/<%.valias%>/ig,snow.getMoney(json.data.valueMoney))
							.replace(/<%.amount%>/ig,json.data.amount)
							.replace(/<%.value%>/ig,json.data.value)
							.replace(/<%.investor%>/ig,json.data.investor);
					// 实体是否存在
					var _obj = $('.snow-list-6 .snow-loops-'+json.data.id);
					if(_obj.length){
						// 替换
						_obj.replaceWith(_html);
					}else{
						// 追加
						$('.snow-list-6').append(_html);
					}
					// 初始化表单
					_form.find('input[name="id"]').val('');
					_form[0].reset();
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('.snow-alert-6'),_errors.join(';'),false);
				}
			});
		}).find('button[type="reset"]').click(function(){
			$(this).closest('form').find('input[name="id"]').val('0');
		});
	});
</script>