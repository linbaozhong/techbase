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
		<h3 class="snow-color-red">活动日历管理</h3>
		<div class="pull-right" style="margin-top:-30px;">
			<a class="btn btn-primary btn-create" style="padding-top: 0;padding-bottom: 0;" href="/article/edit"><i class="fa fa-plus-circle"></i>&nbsp; 新建文章</a>
		</div>

		<!--账号列表-->
		<div class="row snow-row-1 snow-padding-top-40">
			<table class="table table-condensed table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>标题</th>
						<th>开始日期</th>
						<th>地点</th>
						<th>状态</th>
						<th>
						</th>
					</tr>
				</thead>
				<tbody id="snow-article-list">

				</tbody>
			</table>
			<div class="clearfix small">
				
			</div>
		</div>
	</div>
</article>

<script type="text/javascript">
	$(function() {
		
		function loadNews(status){
			$('#snow-article-list').empty();
			
			$.getJSON('/article/list',{status:status},function(json){
				if(json.ok){
					console.log(json.data);
					
					$.each(json.data.data,function(i,art){
						var _html=[],_status='';
						
						switch(art.status){
							case 1:
								_status = '锁定';
								break;
							default:
								_status = '';
								break;
						}
						
						_html.push('<tr id="snow-row-'+art.id +'">');
						_html.push('<td></td>');
						_html.push('<td>['+ art.tag + ']' + art.title + '</td>');
						_html.push('<td>' + (new Date(art.updated)).format() + '</td>');
						_html.push('<td><input class="snow-position" type="number" data-id="' + art.id + '" value="'+art.position+'" style="width:50px;" /></td>');
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
		}).on('change','.snow-position',function(){
			// 提交审核
			var _this = $(this),_id = _this.data('id');
			$.getJSON('/article/setposition',{id:_id,position:_this.val()},function(json){
				console.log(json);
				if (json.ok) {
					
				} else{
					snow.alert(json.data.message);
				}
			});
		});

	});
</script>