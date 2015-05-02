<div class="col-md-3">
	
</div>
<div class="col-md-9 snow-padding-top-40">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-5">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">创始团队</h4>
			</div>
			<div class="col-sm-9">
				<a class="pull-right" href="#" title="增加"><i class="fa fa-plus-circle fa-lg" style="padding-top: 20px;"></i></a>
				<div class="alert" role="alert"></div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">头像</label>
			<div class="col-sm-9">
				<div class="snow-upload-target" style="width:100px;height:100px;">
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>姓名</label>
			<div class="col-sm-9">
				<input class="form-control" name="name" placeholder="姓名" value="{{.members.Name}}">
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
				<input class="form-control" name="title" placeholder="如: CEO/COO" value="{{.members.Title}}">
			</div>
		</div>

		<div class="form-group">
			<label for="inputIntro" class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.members.Id}}" />
				<input type="hidden" name="companyId" value="{{.members.CompanyId}}" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12" {{if not .members.CompanyId}}disabled{{end}}>保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		
		// 提交表单
		$('.snow-form-5').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postmembers',_form.serialize(),function(json){
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
		//
		$(".snow-form-5 .snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png'
		});
	});
</script>