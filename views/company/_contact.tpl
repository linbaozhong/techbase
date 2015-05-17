<div class="col-md-3">
	
</div>
<div class="col-md-9 snow-padding-top-40">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-2">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">联系方式</h4>
			</div>
			<div class="col-sm-9">
				<div class="alert" role="alert"></div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>联系人姓名</label>
			<div class="col-sm-9">
				<input class="form-control" name="name" placeholder="联系人姓名" value="{{.contact.Name}}">
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
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>联系方式</label>
			<div class="col-sm-9">
				<input class="form-control" name="weixin" placeholder="手机号/微信号" value="{{.contact.Weixin}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">E_Mail</label>
			<div class="col-sm-9">
				<input type="email" class="form-control" name="email" placeholder="E_Mail" value="{{.contact.Email}}">
			</div>
		</div>
		<!--<div class="form-group">
			<label class="col-sm-3 control-label">微信</label>
			<div class="col-sm-9">
				<input class="form-control" name="weixin" placeholder="微信" value="{{.contact.Weixin}}">
			</div>
		</div>-->
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
				<button type="submit" class="btn btn-primary col-sm-12" {{if eq .contact.CompanyId 0}}disabled{{end}}>保存</button>
			</div>
		</div>
	</form>

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
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postcontact',_form.serialize(),function(json){
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