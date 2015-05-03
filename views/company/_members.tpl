<div class="col-md-3">
	
</div>
<div class="col-md-9 snow-padding-top-40">
	<div class="form-group">
		<div class="col-sm-3">
			<h4 class="snow-underline">创始团队</h4>
		</div>
		<div class="col-sm-9">
			<a class="pull-right snow-add-5" href="javascript:;" title="增加"><i class="fa fa-plus-circle fa-lg" style="padding-top: 20px;"></i></a>
			<div class="alert" role="alert"></div>
		</div>
	</div>
	<form class="form-horizontal snow-form-5" style="display: none;">
		<div class="form-group">
			<label class="col-sm-3 control-label">头像</label>
			<div class="col-sm-9">
				<span class="small"> ( 仅支持100*100像素的JPG、GIF、PNG格式图片文件 )</span>
				<div class="snow-upload-target" style="width:100px;height:100px;">
					<img src="{{.Company.Avatar}}"/>
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
				<input type="hidden" name="avatar" value="{{.members.Avatar}}" />
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
				<div class="snow-member col-sm-5">
					<div class="snow-tools">
						<a href="#"><i class="fa fa-pencil"></i></a> 
						<a href="#"><i class="fa fa-times"></i></a>
					</div>
					<div>
						<img src="" style="width:100px;height:100px"/>
					</div>
					<div>
						<label class="control-label">王成武</label>
					</div>
					<div>
						<span>创始人</span> <span>CEO</span>
					</div>
				</div>
				<div class="snow-member col-sm-5">
					<div class="snow-tools">
						<a href="#"><i class="fa fa-pencil"></i></a> 
						<a href="#"><i class="fa fa-times"></i></a>
					</div>
					<div>
						<img src="" style="width:100px;height:100px"/>
					</div>
					<div>
						<label class="control-label">王成武</label>
					</div>
					<div>
						<span>创始人</span> <span>CEO</span>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script type="text/javascript">
	$(function(){
		// 增加按钮事件
		$('a.snow-add-5').click(function(){
			$('form.snow-form-5').show();
		});
		// 提交表单
		$('form.snow-form-5').submit(function(e){
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
		$("form.snow-form-5 .snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png',
		    action:'/up'
		}).on("filestart.upload", function(){})
		  .on("fileprogress.upload", function(){})
		  .on("filecomplete.upload", function(e,file,response){
		  	if (response.ok) {
		  		var _img = $(this).find('img'),_src=response.data[0].path;
		  		if (_img.length) {
		  			_img.attr('src',_src);
		  		} else{
		  			$(this).prepend('<img src="'+_src+'">');
		  		}
		  		// 写入表单logo域
		  		$('form.snow-form-5 input[name="avatar"]').val(_src);
		  	} else{
		  		alert(response.data[0].message);
		  	}
		  })
		  .on("fileerror.upload", function(){});
	});
</script>