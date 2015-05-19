<div class="banner">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="">
					<div class="snow-upload-target" title="点我上传图片" style="width:100px;height:100px;overflow: hidden;margin: 0 auto;">
						<img src="{{.company.Logo}}"/>
					</div>
					<span class="small" style="width: 100px;clear: both;"> ( 仅支持100*100像素的JPG、GIF、PNG格式图片文件 )</span>
				</div>
				<div style="padding-top:15px;">
					<span class="snow-required">*</span><input class="small snow-rel-field" style="padding: 5px;width: 200px;color:initial;" data-rel="snow-form-1" data-field="name" placeholder="项目名称" value="{{.company.Name}}" />
				</div>
				<div style="padding-top:15px;">
					<span class="snow-required">*</span><input class="small snow-rel-field" style="padding: 5px;width: 300px;color:initial;" data-rel="snow-form-1" data-field="intro" placeholder="用一句话介绍项目" value="{{.company.Intro}}" />
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="snow-row snow-row-1">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<h4>{{.subTitle}}</h4>
				<div class="pull-right">
					<a class="submit-review" href="#"><i class="fa fa-check-circle-o"></i>&nbsp;提交审核</a>&nbsp;&nbsp;&nbsp;
					<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的项目</a>
				</div>
				<hr />
			</div>
		</div>
		<!--项目简介-->
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
	
				<form class="form-horizontal snow-form-1">
					<div class="form-group">
						<div class="col-sm-3">
							<input type="hidden" name="id" value="{{.company.Id}}" />
							<input type="hidden" name="logo" value="{{.company.Logo}}" />
							<input type="hidden" required name="name" value="{{.company.Name}}" />
							<input type="hidden" required name="intro"  value="{{.company.Intro}}" />
						</div>
						<div class="col-sm-9">
							<div class="alert snow-alert-1" role="alert"></div>
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
							<input class="form-control" required name="companyName" placeholder="公司简称" value="{{.company.CompanyName}}">
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
						</label>
						<div class="col-sm-9">
							<button type="submit" class="btn btn-primary col-sm-12">保存</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!--联系公司-->
	<div class="snow-row snow-row-2">
	</div>

	<!--公司介绍-->
	<div class="snow-row snow-row-3">
	</div>

	<!--相关链接-->
	<div class="snow-row snow-row-4">
	</div>

	<!--创世团队-->
	<div class="snow-row snow-row-5">
	</div>

	<!--融资经历-->
	<div class="snow-row snow-row-6">
	</div>
	
	<div class="snow-row snow-row-7">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
			<div class="col-md-10 col-md-offset-2">
				<h4>提示：</h4>
				<p class="small">1. 请尽量完善项目信息，以便投资人及潜在的合作伙伴更充分地了解您。</p>
				<p class="small">2. 项目的图文介绍、融资经历、团队信息都很重要。</p>
				<p class="small">3. 完成时，可点击“提交审核”。审核提交后，所有信息将无法再进行编辑。</p>
				<p class="small">4. 审核通过后，即可展示在“她项目”页面中，并且在“我的项目”页面中可以为项目快速申请融资。</p>
				<button type="button" class="btn btn-primary col-sm-12 submit-review">提交审核</button>
			</div>
			</div>
		</div>
	</div>
</article>
<link rel="stylesheet" type="text/css" href="/static/css/upload.css"/>
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	function showMessage(obj,msg,success){
		if (success) {
			obj.removeClass('alert-danger').addClass('alert-success').slideDown().html('<i class="fa fa-smile-o"></i> ,'+msg);
		} else{
			obj.removeClass('alert-success').addClass('alert-danger').slideDown().html('<i class="fa fa-frown-o"></i> ,'+msg);
		}
		setTimeout(function(){
			obj.slideUp(600);
		},5000)
	}
	function submit_disable(obj){
		$('.btn[type="submit"]',obj).attr('disabled',true).prepend('<i class="fa fa-spinner fa-spin"></i> ');
	}
	function submit_enable(obj){
		$('.btn[type="submit"]',obj).attr('disabled',false).find('i').remove();
	}
	
	$(function(){
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
		//
//		if (parseInt('{{.companyId}}') > 0) {
//			$('article .snow-row').show();
//		}
		// 提交审核 事件
		$('.submit-review').click(function(e){
			e.preventDefault();
			if('{{.company.Status}}'=='0' && $('form.snow-form-1 input[name="id"]').val() > 0
				&& $('form.snow-form-2 input[name="id"]').val() > 0
				&& $('form.snow-form-3 input[name="id"]').val() > 0
				&& $('.snow-loop').length > 0 && $('.snow-member').length > 0
				){
				// 提交审核
				$.getJSON('/company/submitaudit',{id:$('form.snow-form-1 input[name="id"]').val()},function(json){
					if (json.ok) {
						snow.alert('你的项目已提交审核，请等待……');
					} else{
						snow.alert(json.data.message);
					}
				});
			}else{
				snow.alert('你的项目信息不完善，请尽量完善项目信息……');
			}
			return false;	
		});
		// 关联输入字段
		$('.snow-rel-field').change(function(){
			var _this=$(this);
			$('form.'+_this.data('rel')+' input[name="'+_this.data('field')+'"]').val(_this.val());
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
				console.log(json);
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 启用全部表单
					$('article .snow-row').show();
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					// 写入本页面全部companyid域
					$('input[name="companyId"]').val(json.data.id).change();
					
					showMessage($('.snow-alert-1'),'hi,我已经为你保存好了,不用谢了……',true);
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('.snow-alert-1'),_errors.join(';'),false);
				}
			});
		});
		
		$(".slides .snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png',
		    action:'/up/avatar',
		    postData:{width:100,height:100}
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