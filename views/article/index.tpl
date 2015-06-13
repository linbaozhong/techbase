<div class="container banner" style="height: 75px;overflow: hidden;">
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
	<div class="col-md-12">
		<h3 class="snow-color-red">媒体管理</h3>
		<div class="pull-right" style="margin-top:-30px;">
			<select name="status">
				<option value="0" {{if eq .status 0}}selected{{end}}>草稿</option>
				<option value="1" {{if eq .status 1}}selected{{end}}>审核中</option>
				<option value="2" {{if eq .status 2}}selected{{end}}>已发布</option>
				<option value="-1" {{if eq .status -1}}selected{{end}}>审核未通过</option>
				<option value="-2" {{if eq .status -2}}selected{{end}}>回收站</option>
			</select>&nbsp;&nbsp;
			<a class="btn btn-primary btn-create" style="padding-top: 0;padding-bottom: 0;" href="/article/edit"><i class="fa fa-plus-circle"></i>&nbsp; 新建文章</a>
		</div>

		<!--账号列表-->
		<div class="row snow-row-1 snow-padding-top-40">
			<table class="table table-condensed table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>置顶</th>
						<th>推荐</th>
						<th>标题</th>
						<th>编辑日期</th>
						<th>状态</th>
						<th>
						</th>
					</tr>
				</thead>
				<tbody id="snow-article-list">

				</tbody>
			</table>

		</div>
	</div>
	<div id="snow-wrap-valid" class="text-center" style="display: none;padding: 40px">
		<h3>文章审核</h3>
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
				<textarea class="form-control" maxlength="250" name="reason" rows="" cols=""></textarea>
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary col-md-12">提交</button>
			</div>
		</form>
	</div>
</article>

<script type="text/javascript">
	$(function() {
		
		function loadNews(index,status){
			$('#snow-article-list').empty();
			
			$.getJSON('/article/list',{size:20,index:index,status:status},function(json){
				if(json.ok){
					$.each(json.data,function(i,art){
						var _html=[],_status='';
						
						switch(art.status){
							case 0:
								_status = '草稿';
								break;
							case 1:
								_status = '审核中';
								break;
							case 2:
								_status = '发布';
								break;
							default:
								_status = '<span title="'+ art.reason+ '">审核未通过<i class="fa fa-exclamation-circle"></i></span>';
								break;
						}
						
						_html.push('<tr id="snow-row-'+art.id +'">');
						_html.push('<td></td>');
						_html.push('<td><input class="snow-istop" type="checkbox" data-id="' + art.id + '" ' + (art.isTop==1 ? 'checked' : '') + ' /></td>');
						_html.push('<td><input class="snow-recommend" type="checkbox" data-id="' + art.id + '" ' + (art.Recommend==1 ? 'checked' : '') + ' /></td>');
						_html.push('<td>['+ art.tag + ']' + art.title + '</td>');
						_html.push('<td>' + (new Date(art.updated)).format() + '</td>');
						_html.push('<td>' + _status + '</td>');
						_html.push('<td>');
						// 如果是回收站
						if(art.deleted){
							_html.push('<a href="javascript:;" class="snow-del" data-id="'+art.id+'" data-value="'+art.deleted+'">还原</a>');
						}else{
							_html.push('<a href="/home/show/'+art.id+'?review=1" target="_blank">预览</a>&nbsp;&nbsp;');
							// 审核和发布状态，不允许编辑
							if(art.status < 1){
								_html.push('<a class="submit-review" href="javascript:;" data-id="'+art.id+'">提审</a>&nbsp;&nbsp;');
								_html.push('<a href="/article/edit/'+art.id+'">编辑</a>&nbsp;&nbsp;');
							}else if(art.status == 1 && parseInt('{{.account.Role}}') < 3){
								_html.push('<a href="javascript:;" class="snow-valid" data-id="'+art.id+'">审核</a>&nbsp;&nbsp;');
							}
							_html.push('<a href="javascript:;" class="snow-del" data-id="'+art.id+'" data-value="'+art.deleted+'">删除</a>');
						}
						
						_html.push('</td>');
						_html.push('</tr>');
						
						$('#snow-article-list').append(_html.join(''));
						//
						snow.footerBottom();
					});
				}else{
					
				}
			});
		};
		
		$('select[name="status"]').change(function(){
			loadNews(0,$(this).val());
		}).change();
		
		// 附属操作
		$('#snow-article-list').on('click','.snow-istop',function(){
			// 置顶
			var _this = $(this),_id = _this.data('id');
			$.getJSON('/article/settop',{id:_id,istop:_this.is(':checked')?1:0},function(json){
				if(json.ok){
					
				}else{
					_this.attr('checked',!_this.is(':checked'));
					snow.alert(json.data.message);
				}
			});
		}).on('click','.snow-recommend',function(){
			// 推荐
			var _this = $(this),_id = _this.data('id');
			$.getJSON('/article/setrecommend',{id:_id,recommend:_this.is(':checked')?1:0},function(json){
				if(json.ok){
					
				}else{
					_this.attr('checked',!_this.is(':checked'));
					snow.alert(json.data.message);
				}
			});
		}).on('click','.snow-del',function(){
			// 删除
			var _this = $(this),_id = _this.data('id');
			$.post('/article/setdelete',{id:_id,value:_this.data('value')},function(json){
				if(json.ok){
					_this.closest('tr').slideUp(1000,function(){
						$(this).remove();
					});
				}else{
					snow.alert(json.data.message);
				}
			});
		}).on('click','.snow-valid',function(){
			// 审核
			$('form.snow-form-1 input[name="id"]').val($(this).data('id'));
			
			snow.popWindow = $('#snow-wrap-valid').popWindow({
				width: 400,
				height: 340,
				close: '<span><i class="fa fa-times"></i></span>'
			});
		}).on('click','.submit-review',function(e){
			// 提交审核
			var _this = $(this),_id = _this.data('id');
			$.getJSON('/article/audit',{id:_id},function(json){
				if (json.ok) {
					_this.closest('tr').slideUp(1000,function(){
						$(this).remove();
					});
				} else{
					snow.alert(json.data.message);
				}
			});
		});


//
		// 提交审核
		$('form.snow-form-1').submit(function(e){
			e.preventDefault();
			var _form = $(this);

			// 禁用提交按钮
			submit_disable(_form);
			
			$.getJSON('/article/audit',_form.serialize(),function(json){
				// 启用提交按钮
				submit_enable(_form);
				if (json.ok) {
					$('#snow-row-'+_form.find('input[name="id"]').val()).slideUp(1000,function(){
						$(this).remove();
					});
					_form.find('input[name="id"]').val('');
					_form[0].reset();
					snow.popWindow.close();
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