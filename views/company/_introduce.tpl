<div class="alert" role="alert"></div>
<div class="col-md-3">
	
</div>
<div class="col-md-9">
	<div class="" style="margin-top: 10px;">

	</div>
	<form class="form-horizontal snow-form-3">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">公司介绍</h4>
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
			</label>
			<div class="col-sm-9">
			<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>

</div>

<script type="text/javascript">
	$(function(){
		// 加载图片
		var _images = '{{.introduce.Images}}';
		if (_images.length) {
			var _imageA = _images.split(',');
			$.each(_imageA, function(index,item) {    
				$(".snow-form-3 .snow-upload-target").before('<li class="snow-img"><i class="fa fa-lg fa-times-circle-o"></i><img src="'+item+'"></li>');                                                          
			});
		}
		// 删除图片
		$('.snow-form-3').on('click','.snow-img i',function(e){
			e.preventDefault();
			$(this).closest('li').remove();
		});
		// 提交
		$('.snow-form-3').submit(function(e){
			e.preventDefault();
			
		});
		//
		$(".snow-form-3 .snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png'
		});
	});
</script>