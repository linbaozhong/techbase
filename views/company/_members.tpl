
<div class="row">
	<div class="col-md-10 col-md-offset-1">
		<h4>{{.subTitle}}</h4>
		<div class="pull-right">
			{{if and (lt .company.Id 0) (eq .company.Status 0)}}
			<a class="submit-review" href=""><i class="fa fa-check-circle-o"></i>&nbsp;提交审核</a>&nbsp;&nbsp;&nbsp;
			{{end}}
			<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的项目</a>
		</div>
		<hr />
	</div>
</div>
<!--创始成员-->
<div class="row">
	<div class="col-md-8 col-md-offset-2">
		<form class="form-horizontal snow-form-5">
			<div class="form-group">
				<div class="col-sm-3">
				</div>
				<div class="col-sm-9">
					<!--<a class="abs-right-bottom snow-add-5" href="javascript:;" title="增加"><i class="fa fa-plus-circle fa-lg"></i></a>-->
					<div class="alert snow-alert-5" role="alert"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">头像</label>
				<div class="col-sm-9">
					<span class="small"> ( 仅支持100*100像素的JPG、GIF、PNG格式图片文件 )</span>
					<div class="snow-upload-target" style="width:100px;height:100px;">
						<img src="{{.Company.Avatar}}"/>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span class="snow-required">*</span>姓名</label>
				<div class="col-sm-9">
					<input class="form-control" required name="name" placeholder="姓名" value="">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span class="snow-required">*</span>职位</label>
				<div class="col-sm-3">
					<select class="form-control" required name="place">
						<option value="">创始人</option>
					</select>
				</div>
				<div class="col-sm-3">
					<input class="form-control" name="title" placeholder="如: CEO/COO" value="">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">简介</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="intro" placeholder="简介"></textarea>
				</div>
			</div>
	
			<div class="form-group">
				<label for="inputIntro" class="col-sm-3 control-label">
					<input type="hidden" name="id" value="" />
					<input type="hidden" name="companyId" value="{{.companyId}}" />
					<input type="hidden" name="avatar" value="" />
				</label>
				<div class="col-sm-9">
					<button type="submit" class="btn btn-primary col-sm-5 pull-left">保存</button>
					<button type="reset" class="btn btn-primary col-sm-5 pull-right">重置</button>
				</div>
			</div>
		</form>
	
		<div class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label"></label>
				<div class="col-sm-9 snow-list-5">
					{{range .members}}
					<div class="snow-member col-sm-4 snow-members-{{.Id}}">
						<div class="snow-tools">
							<a class="snow-edit" href="#" data-id="{{.Id}}"><i class="fa fa-pencil"></i></a> 
							<a class="snow-del" href="#" data-id="{{.Id}}"><i class="fa fa-times"></i></a>
						</div>
						<div class="snow-avatar img-circle">
							<img src="{{.Avatar}}" />
						</div>
						<div>
							<label class="control-label">{{.Name}}</label>
						</div>
						<div>
							<span class="snow-member-{{.Place}}">创始人</span> <span>{{.Title}}</span>
						</div>
					</div>
					{{end}}
				</div>
			</div>
		</div>
	
	</div>
</div>

<script type="text/javascript">
	snow.getPlace = function(v){
		_place = '创始人';
		$.each(snow.place, function(index,item) {  
			console.log(v,item.value);
			if (v == item.value) {
				_place = item.name;
				return false;
			}
		});
		return _place;
	};
	// 职位下拉选项
	function memberPlaceOptions(){
		var _html=[];
		$.each(snow.place, function(index,item) {    
			_html.push('<option');
			_html.push(' value="'+item.value+'">'+item.name+'</option>');                                                          
			// 修复创始成员
			$('.snow-list-5 .snow-member-'+item.value).text(item.name);
		});
		$('form.snow-form-5 select[name="place"]').empty().html(_html.join(''));
	}
	
	$(function(){
		var _template = '<div class="snow-member col-sm-4 snow-members-<%.id%>">'
					+'<div class="snow-tools">'
						+'<a class="snow-edit" href="#" data-id="<%.id%>"><i class="fa fa-pencil"></i></a>&nbsp;'
						+'<a class="snow-del" href="#" data-id="<%.id%>"><i class="fa fa-times"></i></a>'
					+'</div>'
					+'<div class="snow-avatar img-circle">'
						+'<img src="<%.avatar%>" />'
					+'</div>'
					+'<div>'
						+'<label class="control-label"><%.name%></label>'
					+'</div>'
					+'<div>'
						+'<span class=""><%.place%></span> <span><%.title%></span>'
					+'</div>'
				+'</div>';
		// 读取职位选项
		if(snow.place){
			memberPlaceOptions();
		}else{
			$.getJSON('/item/place',function(json){
				if (json.ok) {
					snow.place = json.data;
					memberPlaceOptions();
				} else{
					
				}
			});
		}

		// 编辑 删除
		$('.snow-list-5').on('click','.snow-edit',function(e){
			e.preventDefault();
			// 读取实体
			var _this=$(this);
			$.getJSON('/company/getmember',{id:_this.data('id')},function(json){
				console.log(json);
				if (json.ok) {
					var _form = $('form.snow-form-5').show();
					_form.find('input[name="id"]').val(json.data.id);
					_form.find('input[name="companyId"]').val(json.data.companyId);
					_form.find('input[name="avatar"]').val(json.data.avatar);
					_form.find('input[name="name"]').val(json.data.name);
					_form.find('input[name="title"]').val(json.data.title);
					_form.find('select[name="place"]').val(json.data.place);
					_form.find('textarea[name="intro"]').text(json.data.intro);
					_form.find('.snow-upload-target img').attr('src',json.data.avatar);
				} else{
					showMessage($('.snow-alert-5'),json.message,false);
				}
			});
		}).on('click','.snow-del',function(e){
			e.preventDefault();
			
			if (snow.confirm('你确定要删除吗?')) {
				var _this=$(this);
				$.getJSON('/company/deletemember',{id:_this.data('id')},function(json){
					if (json.ok) {
						_this.closest('.snow-member').remove();
					} else{
						showMessage($('.snow-alert-5'),json.message,false);
					}
				})
			}
		});
		
//		// 增加按钮事件
//		$('button.snow-add-5').click(function(){
//			$('form.snow-form-5').show();
//		});
		// 提交表单
		$('form.snow-form-5').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			// 检查项目主体是否已经存在
			if (_form.find('input[name="companyId"]').val() <= 0) {
				showMessage($('.snow-alert-5'),'项目不存在，请创建项目后重试',false);
				return false;
			}
			
			// 禁用提交按钮
			submit_disable(_form);
			$.post('/company/postmembers',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				
				console.log(json);
				
				if (json.ok) {
					showMessage($('.snow-alert-5'),'hi,我已经为你保存好了,不用谢了……',true);
					// 写入融资经历时间线
					var _html = _template
							.replace(/<%.id%>/ig,json.data.id)
							.replace(/<%.avatar%>/ig,json.data.avatar)
							.replace(/<%.name%>/ig,json.data.name)
							.replace(/<%.title%>/ig,json.data.title)
							.replace(/<%.place%>/ig,snow.getPlace(json.data.place));
					// 实体是否存在
					var _obj = $('.snow-list-5 .snow-members-'+json.data.id);
					if(_obj.length){
						// 替换
						_obj.replaceWith(_html);
					}else{
						// 追加
						$('.snow-list-5').append(_html);
					}
					// 初始化表单
					_form.find('input[name="id"]').val('');
					_form.find('img').attr('src','');
					_form[0].reset();
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage($('.snow-alert-5'),_errors.join(';'),false);
				}
			});
		}).find('button[type="reset"]').click(function(){
			var _form = $(this).closest('form');
			_form.find('input[name="id"]').val('0');
			_form.find('img').attr('src','');
		});
		//
		$("form.snow-form-5 .snow-upload-target").upload({
		    label: '<span style="display:block;font-size:1.3em;margin-top:-8px;">上传头像</span><span>点击选择照片</span>',//"<i class=\"fa fa-plus\"></i>",
		    accept:'.jpg,.jpeg,.gif,.png',
		    action:'/up/avatar',
		    postData:{width:100,height:100}
		}).on("filestart.upload", function(){})
		  .on("fileprogress.upload", function(){})
		  .on("filecomplete.upload", function(e,file,response){
		  	if (response.ok) {
		  		var _img = $(this).find('img'),_src=response.data[0].path;
		  		if (_img.length) {
		  			_img.attr('src',_src);
		  		} else{
		  			$(this).prepend('<img src="'+_src+'">');
		  		}
		  		// 写入表单logo域
		  		$('form.snow-form-5 input[name="avatar"]').val(_src);
		  	} else{
		  		alert(response.data[0].message);
		  	}
		  })
		  .on("fileerror.upload", function(){});
	});
</script>