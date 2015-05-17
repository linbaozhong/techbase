<style type="text/css">
	.banner .small {
		font-size: 0.7em;
		font-weight: initial;
		line-height: normal;
	}
	.slideshow {
		overflow: hidden;
		font-weight: bold;
		line-height: 1.5;
		position: relative;
	}
	.slideshow * {
		color: #fff;
	}
	.slideshow > .banner-nav {
		text-align: center;
		position: absolute;
		width: 100%;
		bottom: 10px;
	}
	.slideshow > .banner-nav span {
		display: inline-block;
		cursor: pointer;
		margin: 0 3px;
		-webkit-transition: background-color 0.2s;
		transition: background-color 0.2s;
	}
	.slideshow > .banner-nav span:before {
		font: normal normal normal 14px/1 FontAwesome;
		width: 32px;
		font-size: 14px;
		content: "\f10c";
	}
	.slideshow > .banner-nav span.current:before {
		content: "\f111";
	}
	.slides {
		list-style: none;
		padding: 0;
		margin: 0;
		position: relative;
		height: 425px;
		width: 100%;
		overflow: hidden;
		color: #333;
	}
	.slides > li {
		-webkit-perspective: 1600px;
		perspective: 1600px;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		display: none;
		height: 100%;
		padding: 180px 80px 60px;
		background-size: cover;
		background-position-x: center;
		background-position-y: center;
	}
	.slides > li.banner-1 {
		background-image: url(/html/images/banner02.png);
	}
	.slides > li.banner-2 {
		background-image: url(/html/images/banner01.png);
	}
	.slides .description {
		width: 100%;
		height: 100%;
		font-size: 1.5em;
		position: relative;
		z-index: 1000;
		letter-spacing: .2em;
	}
	.slides .description h2 {
		font-size: 200%;
	}
	.slides > li.current,
	.slides > li.show {
		display: block;
	}
	.more-brand {
		text-align: right;
	}
</style>
<div class="banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1">
				<div class="description" style="margin: 0 auto;width: 900px;">
					<h3>提示：</h3>
					<p class="small">1. 请尽量完善项目信息，以便投资人及潜在的合作伙伴更充分地了解您。</p>
					<p class="small">2. 项目的图文介绍、融资经历、团队信息都很重要。</p>
					<p class="small">3. 完成时，可点击“提交审核”。审核提交后，所有信息将无法再进行编辑。</p>
					<p class="small">4. 审核通过后，即可展示在“她项目”页面中，并且在“我的项目”页面中可以为项目快速申请融资。</p>
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<div class="">
				<h3>{{.subTitle}}</h3>
				<div class="pull-right">
					{{if and (lt .company.Id 0) (eq .company.Status 0)}}
					<a class="submit-review" href=""><i class="fa fa-check-circle-o"></i>&nbsp;提交审核</a>&nbsp;&nbsp;&nbsp;
					{{end}}
					<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的项目</a>
				</div>
			</div>
			<hr />
			<!--创建公司-->
			<div class="row snow-row-1">
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
							<label class="col-sm-3 control-label"><span class="snow-required">*</span>项目名称</label>
							<div class="col-sm-9">
								<input class="form-control" name="name" placeholder="项目名称" value="{{.company.Name}}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label"><span class="snow-required">*</span>一句话简介</label>
							<div class="col-sm-9">
								<textarea class="form-control" name="intro" rows="" cols="" placeholder="用一句话介绍项目">{{.company.Intro}}</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">行业领域</label>
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
							<label class="col-sm-3 control-label">所在地</label>
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
							<label class="col-sm-3 control-label">创办时间</label>
							<div class="col-sm-4">
								<input type="date" class="form-control" name="starttime" placeholder="公司全称" value="{{.company.StartTime}}">
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
			</div>

			<!--联系公司-->
			<div class="row snow-row-2">
			</div>

			<!--公司介绍-->
			<div class="row snow-row-3">
			</div>

			<!--相关链接-->
			<div class="row snow-row-4">
			</div>

			<!--创世团队-->
			<div class="row snow-row-5">
			</div>

			<!--融资经历-->
			<div class="row snow-row-6">
			</div>

		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<link rel="stylesheet" type="text/css" href="/static/css/upload.css"/>
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	function showMessage(obj,msg,success){
		if (success) {
			obj.removeClass('alert-danger').addClass('alert-success').addClass('visible').text(':) ,'+msg);
		} else{
			obj.removeClass('alert-success').addClass('alert-danger').addClass('visible').text(':( ,'+msg);
		}
	}
	function submit_disable(obj){
		$('.btn[type="submit"]',obj).attr('disabled',true).prepend('<i class="fa fa-spinner fa-spin"></i> ');
	}
	function submit_enable(obj){
		$('.btn[type="submit"]',obj).attr('disabled',false).find('i').remove();
	}
	$(function(){
//		$('.snow-row-1').load('/company/GetCompany/{{.companyId}}',function(){
//			$(window).resize();
//		});
		$('.snow-row-2').load('/company/GetContact/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-3').load('/company/GetIntroduce/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-4').load('/company/GetLinks/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-5').load('/company/GetMembers/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-6').load('/company/GetLoops/{{.companyId}}',function(){
			$(window).resize();
		});
		
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