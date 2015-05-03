<div class="col-md-3">
	
</div>
<div class="col-md-9 snow-padding-top-40">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-4">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">相关链接</h4>
			</div>
			<div class="col-sm-9">
				<div class="alert" role="alert"></div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">Web端链接</label>
			<div class="col-sm-9">
				<input class="form-control" name="web" placeholder="Web端链接" value="{{.links.Web}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">iPhone下载链接</label>
			<div class="col-sm-9">
				<input class="form-control" name="iphone" placeholder="iPhone下载链接" value="{{.links.Iphone}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">PC下载端链接</label>
			<div class="col-sm-9">
				<input class="form-control" name="windows" placeholder="PC下载端链接" value="{{.links.Windows}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">Android下载链接</label>
			<div class="col-sm-9">
				<input class="form-control" name="android" placeholder="Android下载链接" value="{{.links.Android}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">iPad下载链接</label>
			<div class="col-sm-9">
				<input class="form-control" name="ipad" placeholder="iPad下载链接" value="{{.links.Ipad}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.links.Id}}" />
				<input type="hidden" name="companyId" value="{{.links.CompanyId}}" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12" {{if not .company.Id}}disabled{{end}}>保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		// 提交表单
		$('.snow-form-4').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postlinks',_form.serialize(),function(json){
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