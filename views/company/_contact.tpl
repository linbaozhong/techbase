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
		<form class="form-horizontal snow-form-2">
		<div class="form-group">
			<div class="col-sm-3">
				
			</div>
			<div class="col-sm-9">
				<div class="alert snow-alert-2" role="alert"></div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>联系人姓名</label>
			<div class="col-sm-9">
				<input class="form-control" required name="name" placeholder="联系人姓名" value="{{.contact.Name}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>职位</label>
			<div class="col-sm-3">
				<select class="form-control" name="place">
					<option value="">创始人</option>
				</select>
			</div>
			<div class="col-sm-3">
				<input class="form-control" name="title" placeholder="如: CEO/COO" value="{{.contact.Title}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>任职时间</label>
			<div class="col-sm-3">
				<select class="form-control" required name="year">
					<option value="2014">2012 年</option>
					<option value="2014">2013 年</option>
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
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>联系方式</label>
			<div class="col-sm-9">
				<input class="form-control" required name="weixin" placeholder="手机号/微信号" value="{{.contact.Weixin}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">E_Mail</label>
			<div class="col-sm-9">
				<input type="email" class="form-control" name="email" placeholder="E_Mail" value="{{.contact.Email}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">Linkedin</label>
			<div class="col-sm-9">
				<input class="form-control" name="linkedin" placeholder="Linkedin" value="{{.contact.Linkedin}}">
			</div>
		</div>

		<div class="form-group">
			<label for="inputIntro" class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.contact.Id}}" />
				<input type="hidden" name="companyId" value="{{.contact.CompanyId}}" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script type="text/javascript">
	// 职位下拉选项
	function contactPlaceOptions(){
		var _html=[];
		$.each(snow.place, function(index,item) {    
			_html.push('<option');
			_html.push(' value="'+item.value+'">'+item.name+'</option>');                                                          
		});
		$('form.snow-form-2 select[name="place"]').empty().html(_html.join(''));
	}
	
	$(function(){
		$('form.snow-form-2 select[name="year"]').val('{{.contact.Year}}');
		$('form.snow-form-2 select[name="month"]').val('{{.contact.Month}}');

		// 读取职位选项
		if(snow.place){
			contactPlaceOptions();
		}else{
			$.getJSON('/basic/place',function(json){
				if (json.ok) {
					snow.place = json.data;
					contactPlaceOptions();
				} else{
					
				}
			});
		}
		// 提交表单
		$('.snow-form-2').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 检查项目主体是否已经存在
			if (_form.find('input[name="companyId"]').val() <= 0) {
				showMessage($('.snow-alert-2'),'项目不存在，请创建项目后重试',false);
				return false;
			}
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postcontact',_form.serialize(),function(json){
				console.log(json);
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					
					showMessage($('.snow-alert-2'),'hi,我已经为你保存好了,不用谢了……',true);
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('.snow-alert-2'),_errors.join(';'),false);
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