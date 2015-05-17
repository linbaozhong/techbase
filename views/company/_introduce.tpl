<div class="banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1">
				<div class="description" style="margin: 0 auto;width: 900px;">
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="snow-row snow-row-2">
		<div class="row" style="margin-bottom: 40px;">
			<div class="col-md-8 col-md-offset-2 snow-item-line">
				<div class="col-md-3 snow-color-red">
					<i class="fa fa-circle"></i>
					<hr />
					项目简介
				</div>
				<div class="col-md-3 snow-color-red">
					<i class="fa fa-circle"></i>
					<hr />
					产品详情
				</div>
				<div class="col-md-3">
					<i class="fa fa-circle"></i>
					<hr />
					创始团队
				</div>
				<div class="col-md-3">
					<i class="fa fa-circle"></i>
					<hr />
					融资经历
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<h3>{{.subTitle}}</h3>
				<div class="pull-right">
					{{if and (lt .company.Id 0) (eq .company.Status 0)}}
					<a class="submit-review" href=""><i class="fa fa-check-circle-o"></i>&nbsp;提交审核</a>&nbsp;&nbsp;&nbsp;
					{{end}}
					<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的项目</a>
				</div>
				<hr />
			</div>
		</div>
		<!--公司详情-->
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<form class="form-horizontal snow-form-3">
					<div class="form-group">
						<div class="col-sm-3">
						</div>
						<div class="col-sm-9">
							<div class="alert" role="alert"></div>
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
				<form class="form-horizontal snow-form-4">
					<!--<div class="form-group">
						<div class="col-sm-3">
							<h4 class="snow-underline">相关链接</h4>
						</div>
						<div class="col-sm-9">
							<div class="alert" role="alert"></div>
						</div>
					</div>-->
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
							<button type="submit" class="btn btn-primary col-sm-12" {{if eq .links.CompanyId 0}}disabled{{end}}>保存</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</article>
<link rel="stylesheet" type="text/css" href="/static/css/upload.css"/>
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>
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
		  	if ($('form.snow-form-3 .snow-img').length < 5) {
		  		$(".snow-upload-target").show();
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
			if($(this).val() > 0){
				$('button:submit',_form).attr('disabled',false);
			}else{
				$('button:submit',_form).attr('disabled',true);
			}
		});
		//
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
			  		$(".snow-upload-target").hide();
			  	}
		  	} else{
		  		alert(response.data[0].message);
		  	}
		  })
		  .on("fileerror.upload", function(){});
	});
</script>