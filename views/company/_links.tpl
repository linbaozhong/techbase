<div class="alert" role="alert"></div>
<div class="col-md-3">
	
</div>
<div class="col-md-9">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-4">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">相关链接</h4>
			</div>
		</div>
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
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		$('.snow-form-4').submit(function(e){
			e.preventDefault();
			
		});
	});
</script>