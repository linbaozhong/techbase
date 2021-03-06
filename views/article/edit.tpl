<script src="/static/ckeditor/ckeditor.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/ckeditor/adapters/jquery.js" type="text/javascript" charset="utf-8"></script>
<style type="text/css">
	.snow-image-position span{
		width: 30px;
		height: 30px;
	}
	.snow-image-position span i{
		cursor: pointer;
	}
</style>
<div class="container banner" style="margin-top:-75px;height: 75px;overflow: hidden;z-index: -1;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="snow-row snow-row-1">
		<!--<div class="row">-->
		<div class="col-md-12 col-xs-12">
			<h4 class="snow-color-red">{{.subTitle}}</h4>
			<div class="pull-right">
				<a class="submit-review" href="#"><i class="fa fa-check-circle-o"></i>&nbsp;提交审核</a>&nbsp;&nbsp;&nbsp;
				<a href="/article/index"><i class="fa fa-th-list"></i>&nbsp;返回我的文章</a>
			</div>
			<hr />
		</div>
		<!--</div>-->
		<!--项目简介-->
		<!--<div class="row">-->
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<form class="form-horizontal snow-form-1">
				<div class="form-group">
					<div class="col-sm-3">
						<input type="hidden" name="id" value="{{.article.Id}}" />
						<input type="hidden" name="topic" value="{{.article.Topic}}" />
						<input type="hidden" name="topicCss" value="{{.article.TopicCss}}" />
					</div>
					<div class="col-sm-9">
						<div class="alert snow-alert-1" role="alert"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">频道</label>
					<div class="col-sm-9 snow-type">
						<label class="checkbox-inline">
							<input type="radio" name="type" value="0" {{if eq .article.Type 0}} checked {{end}}>站内文章</label>
						<label class="checkbox-inline">
							<input type="radio" name="type" value="1" {{if eq .article.Type 1}} checked {{end}}>外部对她本营的报道</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">所属板块</label>
					<div class="col-sm-9 snow-tags">

					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">主题图</label>
					<div class="col-sm-9 text-center">
						<div class="snow-upload-target" title="点我上传主题图片" style="width:300px;height:150px;line-height:150px;overflow: hidden;margin: 0 auto;border: 1px dashed #ccc;">
							<div class="snow-progress"></div>
							<img style="{{css .article.TopicCss}}" src="{{.article.Topic}}" />
						</div>
						<div class="snow-image-position">
							<div>
								<span id="">
									<i class="fa fa-lg fa-arrow-up"></i>
								</span>
							</div>
							<div>
								<span id="">
										<i class="fa fa-lg fa-arrow-left"></i>
									</span>
								<span>&nbsp;&nbsp;</span>
								<span id="">
										<i class="fa fa-lg fa-arrow-right"></i>
									</span>
							</div>
							<div>
								<span id="">
										<i class="fa fa-lg fa-arrow-down"></i>
									</span>
							</div>
						</div>
						<span class="small" style="width: 100px;clear: both;"> ( 仅支持JPG、GIF、PNG格式图片文件 )</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label"><span class="snow-required">*</span>标题</label>
					<div class="col-sm-9">
						<input class="form-control" required maxlength="250" name="title" placeholder="标题" value="{{.article.Title}}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">副标题</label>
					<div class="col-sm-9">
						<input class="form-control" maxlength="250" name="subTitle" placeholder="副标题" value="{{.article.SubTitle}}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label"><span class="snow-required">*</span>摘要</label>
					<div class="col-sm-9">
						<textarea class="form-control" maxlength="250" name="intro" rows="" cols="" placeholder="文章摘要">{{.article.Intro}}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label"><span class="snow-required">*</span>正文</label>
					<div class="col-sm-9">
						<textarea id="form-content" name="content" placeholder="文章内容" style="width: 100%;height: 300px;">{{.article.Content}}</textarea>
					</div>
				</div>
				<!--<div class="form-group">
						<label class="col-sm-3 control-label">发布时间</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" name="publicDate" placeholder="发布日期" value="{{.article.Published}}">
						</div>
						<div class="col-sm-4 col-sm-offset-1">
							<label></label>
						</div>
					</div>-->
				<div class="form-group">
					<label class="col-sm-3 control-label">作者</label>
					<div class="col-sm-4">
						<input class="form-control" name="author" placeholder="作者" value="{{.article.Author}}">
					</div>
					<div class="col-sm-5">
						<label>
							<input type="checkbox" class="checkbox-inline" name="original" {{if eq .article.Original 1}} checked {{end}} placeholder="是否原创" value="{{.article.Original}}">是否原创</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">文章来源</label>
					<div class="col-sm-3">
						<input class="form-control" name="resource" placeholder="单位" value="{{.article.Resource}}">
					</div>
					<div class="col-sm-6">
						<input class="form-control" name="resourceUrl" placeholder="来源网址" value="{{.article.ResourceUrl}}">
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
		<!--</div>-->
	</div>
</article>
<link rel="stylesheet" type="text/css" href="/static/css/upload.css" />
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	CKEDITOR.disableAutoInline = true;
	
	$(function(){

		$('#form-content').ckeditor();

		// 手机号码验证
		$.validator.addMethod('isMobile', function(value, element) {
			var length = value.length,mobile = /^1[3-8]+\d{9}/;
			console.log(length,mobile.test(value));
			return this.optional(element) || (length == 11 && mobile.test(value));
		}, '请正确填写您的手机号码');
	
		// 文章所属板块
		$.each(snow.basic, function(index,item) {   
			var _tags='{{.article.Tags}}'.split(',');
			
			if(item.type == 8)   {
				var _html = [];
				_html.push('<label class="checkbox-inline"><input');
				
				if ($.inArray(item.value.toString(),_tags) != -1) {
					_html.push(' checked');                                                          
				}
				_html.push(' type="radio" name="tags" value="'+item.value+'">'+item.name+"</label>"); 
				//
				$('form.snow-form-1 .snow-tags').append(_html.join(''))
			}
		});

		// 提交审核 事件
		$('.submit-review').click(function(e){
			e.preventDefault();
			if(parseInt('{{.article.Status}}') < 1 && $('form.snow-form-1 input[name="id"]').val() > 0){
				// 提交审核
				$.getJSON('/article/audit',{id:$('form.snow-form-1 input[name="id"]').val()},function(json){
					if (json.ok) {
						snow.alert('你的文章已提交审核，请等待……');
						snow.go('/article/index');
					} else{
						snow.alert(json.data.message);
					}
				});
			}else{
				snow.alert('你的文章信息不完善，请尽量完善项目信息……');
			}
			return false;	
		});

		$('form.snow-form-1 input[name="original"]').change(function(){
			var _this = $(this);
			if(_this.is(':checked')){
				_this.val(1);
			}else{
				_this.val(0);
			}
		});

		// 验证表单
		var validator_form_1 = $('form.snow-form-1').validate();
	
		// 提交表单
		$('form.snow-form-1').submit(function(e){
			e.preventDefault();
			//
			if(!validator_form_1.valid()){
				return false;
			}
			
			var _form = $(this);
			// 主题图样式
			_form.find('input[name="topicCss"]').val($('.snow-upload-target img').attr('style'));
			
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/article/save',_form.serialize(),function(json){
				console.log(json);
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 启用全部表单
					$('article .snow-row').show();
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					
					showMessage($('form .snow-alert-1'),'hi,我已经为你保存好了,不用谢了……',true);
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('form .snow-alert-1'),_errors.join(';'),false);
				}
			});
		});
		
		$("form.snow-form-1 .snow-upload-target").upload({
		    label: '<div style="line-height: initial;display: inline-block;vertical-align: middle;">上传主题图片</div>',//"<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.png',
		    action:'/up',
		    postData:{width:100,height:100}
		}).on("filestart.upload", function(e,file){
			$('.snow-progress',this).show();
		}).on("fileprogress.upload", function(e,file,percent){
			var _progress = $('.snow-progress',this).css({width:percent+'%'});
			percent==100 && _progress.hide();
		}).on("filecomplete.upload", function(e,file,response){
			  	if (response.ok) {
			  		var _img = $(this).find('img'),_src = response.data[0].path;
			  		if (_img.length) {
			  			_img.attr('src',_src);
			  		} else{
			  			$(this).prepend('<img src="' + _src + '">');
			  		}
			  		// 写入表单logo域
			  		$('form.snow-form-1 input[name="topic"]').val(_src);
			  	} else{
			  		alert(response.data[0].message);
			  	}
		  })
		  .on("fileerror.upload", function(){});
		
		// 主题图位置微调
		$('.snow-image-position').on('click','i.fa-arrow-up',function(e){
			e.stopPropagation();
			e.preventDefault();
			var _img = $('.snow-upload-target img');
			_img.css({
				marginTop:parseInt(_img.css('marginTop'))-5
			});
		}).on('click','i.fa-arrow-down',function(e){
			e.stopPropagation();
			e.preventDefault();
			var _img = $('.snow-upload-target img');
			_img.css({
				marginTop:parseInt(_img.css('marginTop'))+5
			});
		}).on('click','i.fa-arrow-left',function(e){
			e.stopPropagation();
			e.preventDefault();
			var _img = $('.snow-upload-target img');
			_img.css({
				marginLeft:parseInt(_img.css('marginLeft'))-5
			});
		}).on('click','i.fa-arrow-right',function(e){
			e.stopPropagation();
			e.preventDefault();
			var _img = $('.snow-upload-target img');
			_img.css({
				marginLeft:parseInt(_img.css('marginLeft'))+5
			});
		})
	});
</script>