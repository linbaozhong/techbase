<div class="container banner" style="height: 90px;overflow: hidden;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container snow-padding-top-40">
	<div class="row">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1 text-center">
			<div><img src="/static/img/logo001.png" alt="logo" style="width:120px;"></div>
			<h4>她本营 融资顾问服务协议</h4>
			<pre class="text-left" style="min-height: 400px;margin-top: 30px;">
服务协议
    haha		
			</pre>
			<form class="snow-form-1">
				<div class="alert snow-alert-1" role="alert"></div>
				<div class="snow-upload-bp" title="点我上传图片" style="width:150px;height:35px;line-height:30px;overflow: hidden;margin: 0 auto;border-width:1px;margin-top: 30px;">
					<input type="hidden" required name="id" id="id" value="" />
					<input type="hidden" required name="companyId" id="companyId" value="{{.companyId}}" />
					<input type="hidden" required name="bpath" id="bpath" value="" />
				</div>
				<div style="margin-top: 30px;">
					<label><input type="checkbox" required name="agree" id="agree" /> 同意以上合同条款 </label>&nbsp;&nbsp;
					<label><input type="checkbox" name="accept" id="accept" /> 接受融资时的法律服务 </label>
				</div>
				<div style="margin-top: 30px;">
					<button class="btn btn-primary">提交申请</button>
				</div>
			</form>
		</div>
	</div>
</article>
<link rel="stylesheet" type="text/css" href="/static/css/upload.css"/>
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>

<script>
	$(function(){
		var _bp_uploaded=false;
		
		$(".snow-upload-bp").upload({
		    label: "上传 BP",
		    accept:'.pdf,.ppt',
		    action:'/up'
		}).on("filestart.upload", function(){})
		  .on("fileprogress.upload", function(){})
		  .on("filecomplete.upload", function(e,file,response){
		  	_bp_uploaded = response.ok;
			  	if (response.ok) {
			  		$(".snow-upload-bp .fs-upload-target").text("BP 上传成功");
			  		// 写入表单logo域
			  		$('form.snow-form-1 input[name="bpath"]').val(response.data[0].path);
			  	} else{
			  		snow.alert(response.data[0].message);
			  	}
		  }).on("fileerror.upload", function(){});
		  
		// 提交表单
		$('form.snow-form-1').submit(function(e){
			e.preventDefault();
			
			if(!_bp_uploaded){
				showMessage($('.snow-alert-1'),'请上传 BP',false);
				return false;
			}
			var _form = $(this);
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/apply/postapply',_form.serialize(),function(json){
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
	});
</script>