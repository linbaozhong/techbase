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
		<form class="form-horizontal snow-form-3">
			<div class="form-group">
				<div class="col-sm-3">
				</div>
				<div class="col-sm-9">
					<div class="alert snow-alert-3" role="alert"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">图片介绍</label>
				<div class="col-sm-9">
					<span class="small"> ( 最多可以上传 5 张，仅支持JPG、GIF、PNG格式，文件小于5M )</span>
					<ul class="snow-uploads" style="margin-top: 10px;">
						<li class="snow-upload-target"></li>
					</ul>
				</div>
			</div>
			<div class="form-group clearfix">
				<label class="col-sm-3 control-label">文字介绍</label>
				<div class="col-sm-9">
				<textarea class="form-control" name="content" rows="6" cols="" placeholder="">{{.introduce.Content}}</textarea>
				</div>
			</div>
	
			<div class="form-group">
				<label class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.introduce.Id}}" />
				<input type="hidden" name="companyId" value="{{.introduce.CompanyId}}" />
				<input type="hidden" name="images" value="{{.introduce.Images}}" />
				</label>
				<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12" {{if eq .introduce.CompanyId 0}}disabled{{end}}>保存</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(function(){
		// 加载图片
		function load_introduce_image(item){
			$("form.snow-form-3 .snow-upload-target")
				.before('<li class="snow-img"><i class="fa fa-lg fa-times-circle-o"></i><img src="'+item+'"></li>');
		};
		
		var _images = '{{.introduce.Images}}';
		if (_images.length) {
			var _imageA = _images.split(';');
			$.each(_imageA, function(index,item) { 
				load_introduce_image(item);
			});
		}
		// 删除图片
		$('form.snow-form-3').on('click','.snow-img i',function(e){
			e.preventDefault();
			$(this).closest('li').remove();
			// 
		  	if ($('form.snow-form-3 .snow-uploads li.snow-img').length < 5) {
		  		$("form.snow-form-3 .snow-upload-target").show();
		  	}
		});
		// 提交表单
		$('form.snow-form-3').submit(function(e){
			e.preventDefault();
			var _form = $(this),_imgs=[];
			
			$('form.snow-form-3 .snow-img img').each(function(){
				_imgs.push($(this).attr('src'));
			});
			_form.find('input[name="images"]').val(_imgs.join(';'));
			// 禁用提交按钮
			submit_disable(_form);
			
			$.post('/company/postintroduce',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					showMessage($('.snow-alert-3'),'hi,我已经为你保存好了,不用谢了……',true);
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('.snow-alert-3'),_errors.join(';'),false);
				}
			});
		}).find('input[name="companyId"]').change(function(){
			var _form=$(this).closest('form');
			if($(this).val() > 0){
				$('button:submit',_form).attr('disabled',false);
			}else{
				$('button:submit',_form).attr('disabled',true);
			}
		});
		// 最多允许上传5张
		if($("form.snow-form-3 .snow-uploads li.snow-img").length >= 5){
			$("form.snow-form-3 .snow-upload-target").hide();
		}
		
		$("form.snow-form-3 .snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png',
		    action:'/up'
		}).on("filestart.upload", function(){})
		  .on("fileprogress.upload", function(){})
		  .on("filecomplete.upload", function(e,file,response){
		  	if (response.ok) {
		  		console.log(file);
		  		var _src=response.data[0].path;
		  		// 写入表单域
		  		load_introduce_image(_src);
		  		// 限制5张图
			  	if (file.index > 3) {
			  		$(this).find(".snow-upload-target").hide();
			  	}
		  	} else{
		  		alert(response.data[0].message);
		  	}
		  })
		  .on("fileerror.upload", function(){});

	});
</script>