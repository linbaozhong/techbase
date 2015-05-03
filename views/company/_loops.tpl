<div class="col-md-3">
	
</div>
<div class="col-md-9 snow-padding-top-40">
	<div class="form-group">
		<div class="col-sm-3">
			<h4 class="snow-underline">融资经历</h4>
		</div>
		<div class="col-sm-9">
			<a class="pull-right snow-add-6" href="javascript:;" title="增加"><i class="fa fa-plus-circle fa-lg" style="padding-top: 20px;"></i></a>
			<div class="alert" role="alert"></div>
		</div>
	</div>
	<form class="form-horizontal snow-form-6" style="display: none;">
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>轮次</label>
			<div class="col-sm-3">
				<select class="form-control" name="loop">
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
				<input class="form-control" name="title" placeholder="" value="">
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
				<input class="form-control" name="title" placeholder="" value="">
			</div>
			<div class="col-sm-3">
				<label class="control-label">万</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>融资时间</label>
			<div class="col-sm-3">
				<select class="form-control" name="year">
					<option value="2014">2014 年</option>
					<option value="2015">2015 年</option>
					<option value="2016">2016 年</option>
				</select>
			</div>	
			<div class="col-sm-3">
				<select class="form-control" name="month">
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
				<input class="form-control" name="name" placeholder="如：经纬中国" value="">
			</div>
		</div>

		<div class="form-group">
			<label for="inputIntro" class="col-sm-3 control-label">
				<input type="hidden" name="id" value="" />
				<input type="hidden" name="companyId" value="" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12" {{if not .company.Id}}disabled{{end}}>保存</button>
			</div>
		</div>
	</form>
		
	<div class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-3 control-label"></label>
			<div class="col-sm-9 snow-list">
				<div class="snow-loop">
					<div class="snow-tools">
						<a href="#"><i class="fa fa-pencil"></i></a> 
						<a href="#"><i class="fa fa-times"></i></a>
					</div>
					<div>
						<label class="control-label lead">天使轮</label><span>2014.12</span>
					</div>
					<div class="clearfix">
						<div class="pull-left"><label class="control-label">融资金额:</label><span><i class="fa fa-cny"></i> 300</span><span>万</span></div>
						<div class="pull-right"><label class="control-label">融资估值:</label><span><i class="fa fa-cny"></i> 1500</span><span>万</span></div>
					</div>
					<hr />
					<div>
						<label class="control-label">经纬中国</label>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	snow.getLoop = function(v){
		_money='A轮';
		$.each(snow.loop, function(index,item) {    
			if (v == item.value) {
				_money = item.name;
				return false;
			}                                                          
		});
	};
	snow.getMoney = function(v){
		_money='人民币';
		$.each(snow.loop, function(index,item) {    
			if (v == item.value) {
				_money = item.name;
				return false;
			}                                                          
		});
	};
	
	$(function(){
		snow.loops = JSON.parse('{{.loops}}');
		$.each(snow.loops, function(index,item) {    
			                                                          
		});
		// 读取融资轮次
		$.getJSON('/basic/loop',function(json){
			if (json.ok) {
				var _html=[];
				// 前端使用
				snow.loop = json.data;
				
				$.each(json.data, function(index,item) {    
					_html.push('<option');
					_html.push(' value="'+item.value+'">'+item.name+'</option>');                                                          
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
				});
				$('.snow-form-6 select[name="amountMoney"]').empty().html(_html.join(''));
				$('.snow-form-6 select[name="valueMoney"]').empty().html(_html.join(''));
			} else{
				
			}
		});
		
		// 增加按钮事件
		$('a.snow-add-6').click(function(){
			$('form.snow-form-6').show();
		});
		// 提交表单
		$('.snow-form-6').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postloops',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					_form.find('.alert').removeClass('alert-danger').addClass('alert-success').addClass('visible').text('hi,我已经为你保存好了,不用谢了…… :)');
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					_form.find('.alert').removeClass('alert-success').addClass('alert-danger').addClass('visible').text(':( ,'+_errors.join(';'));
				}
			});
		}).find('input[name="companyId"]').change(function(){
			var _form=$(this).closest('form');
			if($(this).val()>0){
				$('button:submit',_form).attr('disabled',false);
			}else{
				$('button:submit',_form).attr('disabled',true);
			}
		});
	});
</script>