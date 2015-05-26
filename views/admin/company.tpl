<div class="banner" style="height: 90px;overflow: hidden;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container">
	<div class="row">
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<h3>项目审核</h3>
			<div class="text-right">

			</div>
			<!--<hr />-->
			<!--创建公司-->
			<div class="row snow-row-1 snow-padding-top-40">
				{{range $index,$company := .companys}}
				<div class="media">
					<div class="media-left">
						<a href="/item/info/{{$company.Id}}" target="_blank">
							<img class="media-object" src="{{$company.Logo}}" style="width: 100px;">
						</a>
					</div>
					<div class="media-body">
						<div><span class="media-heading lead">{{$company.Name}}</span> 
							<div class="pull-right" style="display: inline-flex;margin-left: 20px;">
								<input class="" type="checkbox" name="startup" value="{{$company.Id}}" {{if eq $company.Startup 1}}checked{{end}} />
								大赛项目
							</div>	
							{{if eq $company.Status 0}}
							<span>未提交审核</span>
							{{else if eq $company.Status 1}}
							<span>正在审核中</span>
							<div class="pull-right">
								<a class="snow-btn-valid" href="javascript:;" data-id="{{$company.Id}}">审核</a>
							</div>
							{{else if eq $company.Status 2}}
							<span>审核通过</span>
							{{else}}
							<span>审核未通过</span>
							{{end}}
						
							<p>{{$company.Intro}}</p>
						</div>
					</div>
				</div>
				{{end}}
			</div>
		</div>
	</div>
	<div id="snow-wrap-valid" class="text-center" style="display: none;padding: 40px">
		<h3>项目审核</h3>
		<hr />
		<form class="form-horizontal snow-form-1 text-left">
			<input type="hidden" name="id" id="id" value="0" />
			<div class="form-group text-center">
				<label class="control-label">
					<input class="" required type="radio" name="status" value="2" />
					审核通过
				</label>
				<label class="control-label">
					<input class="" required type="radio" name="status" value="-1" />
					审核未通过
				</label>
			</div>
			<!--<div class="form-group text-center">
				<label class="control-label">
					<input class="" required type="checkbox" name="startup" value="1" />
					参加大赛项目
				</label>
			</div>-->
			<div class="form-group">
				<label class="control-label">审核未通过的原因:</label>
				<textarea class="form-control" name="reason" rows="" cols=""></textarea>
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary col-md-12">提交</button>
			</div>
		</form>
	</div>
</article>
<script type="text/javascript">
	$(function() {

		$('.snow-btn-valid').click(function(e){
			$('form.snow-form-1 input[name="id"]').val($(this).data('id'));
			
			$('#snow-wrap-valid').popWindow({
				width: 400,
				height: 340,
				close: '<span><i class="fa fa-times"></i></span>'
			});
		});
		// 设置大赛项目
		$('input[name="startup"]').click(function(){
			var _this = $(this),
				_id = _this.val(),
				_startup = _this.is(':checked') ? 1 : 0;
				
			$.getJSON('/admin/startup',{id:_id,startup:_startup},function(json){
				if(json.ok){
					
				}else{
					
				}
			});
		});
		
		// 提交审核
		$('form.snow-form-1').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 检查项目主体是否已经存在
			if (_form.find('input[name="companyId"]').val() <= 0) {
				showMessage($('.snow-alert-2'),'项目不存在，请创建项目后重试',false);
				return false;
			}
			// 禁用提交按钮
			submit_disable(_form);
			
			$.getJSON('/admin/submitaudit',_form.serialize(),function(json){
				//console.log(json);
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					snow.alert('本项目已经审核完成');
					snow.refresh();
				} else{
					snow.alert(json.data.message);
				}
			});
			return false;
		}).find('input[name="status"]').change(function(){
			if($(this).val() == 2){
				$('form.snow-form-1 textarea[name="reason"]').attr('required',false);
			}else{
				$('form.snow-form-1 textarea[name="reason"]').attr('required',true);
			}
		});
	});
</script>