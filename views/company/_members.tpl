<div class="alert" role="alert"></div>
<div class="col-md-3">
	
</div>
<div class="col-md-9">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-5">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">创始团队</h4>
			</div>
			<div class="col-sm-9 text-right">
				<a href="#" title="增加"><i class="fa fa-plus-circle fa-lg" style="padding-top: 20px;"></i></a>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">头像</label>
			<div class="col-sm-9">
				<div class="snow-upload-target" style="width:100px;height:100px;">
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
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		
		$('.snow-form-5').submit(function(e){
			e.preventDefault();
			
		});
		//
		$(".snow-form-5 .snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png'
		});
	});
</script>