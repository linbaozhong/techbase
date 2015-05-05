<div class="col-md-3 snow-padding-top-40">
	<div class="pull-right snow-upload-target" title="点我上传图片" style="width:100px;height:100px;overflow: hidden;">
		<img src="{{.company.Logo}}"/>
	</div>
	<span class="small pull-right" style="width: 100px;clear: both;"> ( 仅支持100*100像素的JPG、GIF、PNG格式图片文件 )</span>
</div>
<div class="col-md-9">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-1">
		<div class="form-group">
			<div class="col-sm-3">
				
			</div>
			<div class="col-sm-9">
				<div class="alert" role="alert"></div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>公司简称</label>
			<div class="col-sm-9">
				<input class="form-control" name="name" placeholder="公司简称" value="{{.company.Name}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司网址</label>
			<div class="col-sm-9">
				<input class="form-control" name="website" placeholder="公司网址" value="{{.company.Website}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司全称</label>
			<div class="col-sm-9">
				<input class="form-control" name="fullname" placeholder="公司全称" value="{{.company.Fullname}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>一句话简介</label>
			<div class="col-sm-9">
				<textarea class="form-control" name="intro" rows="" cols="" placeholder="用一句话介绍公司">{{.company.Intro}}</textarea>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司所在地</label>
			<div class="col-sm-3">
				<select class="form-control" name="country">
					<option value="">中国</option>
				</select>
			</div>
			<div class="col-sm-3">
				<select class="form-control" name="city">
					<option value="">北京市</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">创办时间</label>
			<div class="col-sm-4">
				<input type="date" class="form-control" name="starttime" placeholder="公司全称" value="{{.company.StartTime}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司领域</label>
			<div class="col-sm-9 snow-field">
				<label class="checkbox-inline"><input type="checkbox" name="field" value="" />二次元</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>运营状态</label>
			<div class="col-sm-9 snow-state">
				<label class="radio-inline"><input type="radio" name="state" value="" />运营中</label>
			</div>
		</div>

		<div class="form-group">
			<label for="inputIntro" class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.company.Id}}" />
				<input type="hidden" name="logo" value="{{.company.Logo}}" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		snow.companyStatus = '{{.company.Status}}';
		// 国家发生变化
		$('form.snow-form-1 select[name="country"]').change(function(){
			// 读取城市选项
			$.getJSON('/basic/city',{parentId:$(this).val()},function(json){
				if (json.ok) {
					var _html=[];
					$.each(json.data, function(index,item) {    
						_html.push('<option');
						if (item.value == '{{.company.City}}') {
							_html.push(' selected');                                                          
						}
						_html.push(' value="'+item.value+'">'+item.name+'</option>');                                                          
					});
					$('.snow-form-1 select[name="city"]').empty().html(_html.join(''));
				} else{
					
				}
			})
		});
		// 读取国家选项
		$.getJSON('/basic/country',function(json){
			if (json.ok) {
				var _html=[];
				$.each(json.data, function(index,item) {    
					_html.push('<option');
					if (item.value == '{{.company.Country}}') {
						_html.push(' selected');                                                          
					}
					_html.push(' value="'+item.value+'">'+item.name+'</option>');                                                          
				});
				$('.snow-form-1 select[name="country"]').empty().html(_html.join('')).change();
			} else{
				
			}
		});
		// 公司领域
		$.getJSON('/basic/field',function(json){
			if (json.ok) {
				var _html=[],_field='{{.company.Field}}'.split(',');
				
				$.each(json.data, function(index,item) {    
					_html.push('<label class="checkbox-inline"><input');
					
					if ($.inArray(item.value.toString(),_field) != -1) {
						_html.push(' checked');                                                          
					}
					_html.push(' type="checkbox" name="field" value="'+item.value+'">'+item.name+"</label>");                                                          
				});
				$('.snow-form-1 .snow-field').empty().html(_html.join(''));
			} else{
				
			}
		});
		
		// 运营状态
		$.getJSON('/basic/state',function(json){
			if (json.ok) {
				var _html=[];
				$.each(json.data, function(index,item) {    
					_html.push('<label class="radio-inline"><input');
					if (item.value == '{{.company.State}}') {
						_html.push(' checked');                                                          
					}
					_html.push(' type="radio" name="state" value="'+item.value+'">'+item.name+"</label>");                                                          
				});
				$('.snow-form-1 .snow-state').empty().html(_html.join(''));
			} else{
				
			}
		});

		// 领域最多可选择3项
		$('.snow-field').on('click','input[name="field"]',function(e){
			// 如果选中项=3，其它禁选
			if ($('.snow-field input[name="field"]:checked').length > 2) {
				$('.snow-field input[name="field"]:not(:checked)').attr('disabled',true);
			}else{
				$('.snow-field input:disabled').attr('disabled',false);
			}
		});

		// 提交表单
		$('form.snow-form-1').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postcompany',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					// 写入本页面全部companyid域
					$('input[name="companyId"]').val(json.data.id).change();
					_form.find('.alert').removeClass('alert-danger').addClass('alert-success').addClass('visible').text('hi,我已经为你保存好了,不用谢了…… :)');
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					_form.find('.alert').removeClass('alert-success').addClass('alert-danger').addClass('visible').text(':( ,'+_errors.join(';'));
				}
			});
		});
		
		$(".snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png',
		    action:'/up/avatar'
		}).on("filestart.upload", function(){})
		  .on("fileprogress.upload", function(){})
		  .on("filecomplete.upload", function(e,file,response){
			  	if (response.ok) {
			  		var _img = $(this).find('img'),_src = response.data[0].path;
			  		if (_img.length) {
			  			_img.attr('src',_src);
			  		} else{
			  			$(this).prepend('<img src="' + _src + '">');
			  		}
			  		// 写入表单logo域
			  		$('form.snow-form-1 input[name="logo"]').val(_src);
			  	} else{
			  		alert(response.data[0].message);
			  	}
		  })
		  .on("fileerror.upload", function(){});
		
	});
</script>