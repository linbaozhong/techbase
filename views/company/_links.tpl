<div class="row">
	<div class="col-md-10 col-md-offset-1">
		<h4 class="snow-color-red">{{.subTitle}}</h4>
		<div class="pull-right">
			<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的项目</a>
		</div>
		<hr />
	</div>
</div>

<div class="row">
	<div class="col-md-8 col-md-offset-2">
		<form class="form-horizontal snow-form-4">
			<div class="form-group">
				<div class="col-sm-3">
				</div>
				<div class="col-sm-9">
					<div class="alert snow-alert-4" role="alert"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">微信二维码</label>
				<div class="col-sm-9">
					<span class="small"> ( 仅支持JPG、GIF、PNG格式，文件小于5M )</span>
					<div class="snow-upload-target text-center" title="点我上传二维码" style="width:100px;height:100px;line-height:100px;overflow: hidden;border: 1px dashed #ccc;">
						<div class="snow-progress"></div>
						<img src="{{.links.Qrcode}}"/>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Web端链接</label>
				<div class="col-sm-9">
					<input class="form-control" maxlength="250" name="web" placeholder="Web端链接" value="{{.links.Web}}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">iPhone下载链接</label>
				<div class="col-sm-9">
					<input class="form-control" maxlength="250" name="iphone" placeholder="iPhone下载链接" value="{{.links.Iphone}}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">PC下载端链接</label>
				<div class="col-sm-9">
					<input class="form-control" maxlength="250" name="windows" placeholder="PC下载端链接" value="{{.links.Windows}}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Android下载链接</label>
				<div class="col-sm-9">
					<input class="form-control" maxlength="250" name="android" placeholder="Android下载链接" value="{{.links.Android}}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">iPad下载链接</label>
				<div class="col-sm-9">
					<input class="form-control" maxlength="250" name="ipad" placeholder="iPad下载链接" value="{{.links.Ipad}}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">
					<input type="hidden" name="id" value="{{.links.Id}}" />
					<input type="hidden" name="companyId" value="{{.links.CompanyId}}" />
					<input type="hidden" name="qrcode" value="{{.links.Qrcode}}" />
				</label>
				<div class="col-sm-9">
					<button type="submit" class="btn btn-primary col-sm-12">保存</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		// 验证表单
		var validator_form_4 = $('form.snow-form-4').validate();
		// 提交表单
		$('form.snow-form-4').submit(function(e){
			e.preventDefault();
			//
			if(!validator_form_4.valid()){
				return false;
			}
			var _form = $(this);
			// 检查项目主体是否已经存在
			if (_form.find('input[name="companyId"]').val() <= 0) {
				showMessage($('.snow-alert-4'),'项目不存在，请创建项目后重试',false);
				return false;
			}
			
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postlinks',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					// 写入表单id域
					_form.find('input[name="id"]').val(json.data.id);
					showMessage($('.snow-alert-4'),'hi,我已经为你保存好了,不用谢了……',true);
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('.snow-alert-4'),_errors.join(';'),false);
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
		
		$("form.snow-form-4 .snow-upload-target").upload({
		    label: '<div style="line-height: initial;display: inline-block;vertical-align: middle;"><span style="display:block;font-size:1.3em;margin-top:-8px;">上传</span><span>微信二维码</span></div>',//"<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png',
		    maxQueue:1,
		    action:'/up',
		    postData:{}
		}).on("filestart.upload",function(e,file){
			$('.snow-progress',this).show();
		}).on("fileprogress.upload", function(e,file,percent){
			var _progress = $('.snow-progress',this).css({width:percent+'%'});
			percent==100 && _progress.hide();
		}).on("filecomplete.upload", function(e,file,response){
		  	if (response.ok) {
		  		var _src=response.data[0].path;
		  		// 写入表单域
		  		$(this).find('img').attr('src',_src);
			  	$('form.snow-form-4 input[name="qrcode"]').val(_src);
		  	} else{
		  		alert(response.data[0].message);
		  	}
		  })
		  .on("fileerror.upload", function(){});
	});
</script>