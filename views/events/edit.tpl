<script src="/static/ckeditor/ckeditor.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/ckeditor/adapters/jquery.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/bootstrap-datetimepicker.min.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="/static/css/bootstrap-datetimepicker.min.css"/>
<div class="container banner" style="height: 75px;overflow: hidden;">
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
					<a href="/events/index"><i class="fa fa-th-list"></i>&nbsp;返回</a>
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
							<input type="hidden" name="id" value="{{.event.Id}}" />
						</div>
						<div class="col-sm-9">
							<div class="alert snow-alert-1" role="alert"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span class="snow-required">*</span>标题</label>
						<div class="col-sm-9">
							<input class="form-control" required maxlength="250" name="title" placeholder="标题" value="{{.event.Title}}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span class="snow-required">*</span>开始时间</label>
						<div class="col-sm-9">
							<input id="startTime" class="form-control" required name="startTime" placeholder="开始时间" value="{{dateformat (m2t .event.StartTime) "2006-01-02"}}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span class="snow-required">*</span>结束时间</label>
						<div class="col-sm-9">
							<input id="endTime" class="form-control" required name="endTime" placeholder="结束时间" data-data-format="yyyy-mm-dd" value="{{dateformat (m2t .event.EndTime) "2006-01-02"}}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span class="snow-required">*</span>活动介绍</label>
						<div class="col-sm-9">
							<textarea id="form-content" name="intro" placeholder="内容" style="width: 100%;height: 300px;">{{.event.Intro}}</textarea>
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
<link rel="stylesheet" type="text/css" href="/static/css/upload.css"/>
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	CKEDITOR.disableAutoInline = true;
	
	$(function(){

		$('#form-content').ckeditor();
		
		var _option = {format:"yyyy-mm-dd",language:"zh-CN",minView:"month",autoclose:true};
		
		var startTime = $('#startTime').datetimepicker(_option).on('changeDate',function(ev){
			endTime.datetimepicker('setStartDate',ev.date);
			//如果开始时间>结束时间
			if (ev.date.valueOf() > endTime.datetimepicker('getDate').valueOf()) {
				endTime.val(startTime.val()).datetimepicker('update');
			}
		});
		
		var endTime = $('#endTime').datetimepicker(_option).datetimepicker('setStartDate',startTime.val());
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
			
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/events/save',{
				id:$('input[name="id"]',_form).val(),
				title:$('input[name="title"]',_form).val(),
				startTime:new Date($('input[name="startTime"]',_form).val()).getTime(),
				endTime:new Date($('input[name="endTime"]',_form).val()).getTime(),
				intro:$('textarea[name="intro"]',_form).val()
			},function(json){
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
	});
</script>