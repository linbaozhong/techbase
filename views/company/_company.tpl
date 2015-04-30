<div class="alert" role="alert"></div>
<div class="col-md-3">
	<div class="pull-right snow-upload-target" style="width:100px;height:100px;">
		<!--<img src="" alt="" style="width:100px;" />-->
		<!--<br />
						<button type="submit" class="btn btn-primary col-sm-12">上传</button>-->
	</div>
</div>
<div class="col-md-9">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-1">
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>公司简称</label>
			<div class="col-sm-9">
				<input class="form-control" name="name" placeholder="公司简称" value="{{.Company.Name}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司网址</label>
			<div class="col-sm-9">
				<input class="form-control" name="website" placeholder="公司网址" value="{{.Company.Website}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司全称</label>
			<div class="col-sm-9">
				<input class="form-control" name="fullname" placeholder="公司全称" value="{{.Company.Fullname}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>一句话简介</label>
			<div class="col-sm-9">
				<textarea class="form-control" name="intro" rows="" cols="" placeholder="用一句话介绍公司">{{.Company.Intro}}</textarea>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司所在地</label>
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
			<label class="col-sm-3 control-label">创办时间</label>
			<div class="col-sm-4">
				<input type="date" class="form-control" name="starttime" placeholder="公司全称" value="{{.Company.StartTime}}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">公司领域</label>
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
			<label for="inputIntro" class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.company.Id}}" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		// 国家发生变化
		$('.snow-form-1 select[name="country"]').change(function(){
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
				var _html=[],_field='{{.company.State}}'.split(',');
				$.each(json.data, function(index,item) {    
					_html.push('<label class="checkbox-inline"><input');
					if ($.inArray(item.value,_field) != -1) {
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
		
		// 提交表单
		$('.snow-form-1').submit(function(e){
			e.preventDefault();
			$('input[name="companyId"]').val(111);
		});
		
		$(".snow-upload-target").upload({
		    label: "<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png'
		});
	});
</script>