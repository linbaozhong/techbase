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
			<a class="btn btn-primary btn-create" style="padding-top: 0;padding-bottom: 0;" href="/events/edit"><i class="fa fa-plus-circle"></i>&nbsp; 新建活动</a>
		</div>

		<!--账号列表-->
		<div class="row snow-row-1 snow-padding-top-40">
			<table class="table table-condensed table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>标题</th>
						<th>开始时间</th>
						<th>结束时间</th>
						<th>锁定</th>
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
		function loadEvents(status) {
			$('#snow-article-list').empty();
			$.getJSON('/events/list', {
				status: status
			}, function(json) {
				if (json.ok) {
					console.log(json.data);
					$.each(json.data, function(i, art) {
						var _html = [],
							_status = '';
						switch (art.status) {
							case 1:
								_status = 'checked';
								break;
							default:
								_status = '';
								break;
						}
						_html.push('<tr id="snow-row-' + art.id + '">');
						_html.push('<td></td>');
						_html.push('<td>' + art.title + '</td>');
						_html.push('<td>' + (new Date(art.startTime)).format('yyyy-MM-dd') + '</td>');
						_html.push('<td>' + (new Date(art.endTime)).format('yyyy-MM-dd') + '</td>');
						_html.push('<td><input class="snow-status" type="checkbox" data-id="' + art.id + '" value="' + art.status + '" ' + _status + ' /></td>');
						_html.push('<td>');
						// 如果是回收站
						if (art.deleted) {
							_html.push('<a href="javascript:;" class="snow-del" data-id="' + art.id + '" data-value="' + art.deleted + '">还原</a>');
						} else {
							_html.push('<a href="/home/show/' + art.id + '?review=1" target="_blank">预览</a>&nbsp;&nbsp;');
							_html.push('<a href="/events/edit/' + art.id + '">编辑</a>&nbsp;&nbsp;');
							_html.push('<a href="javascript:;" class="snow-del" data-id="' + art.id + '" data-value="' + art.deleted + '">删除</a>');
						}
						_html.push('</td>');
						_html.push('</tr>');
						$('#snow-article-list').append(_html.join(''));
						//
						snow.footerBottom();
					});
				} else {
				}
			});
		};
		loadEvents();
		// 附属操作
		$('#snow-article-list').on('click', '.snow-del', function() {
			// 删除
			var _this = $(this),
				_id = _this.data('id');
			$.post('/events/setdeleted', {
				id: _id,
				deleted: _this.data('value')
			}, function(json) {
				if (json.ok) {
					_this.closest('tr').slideUp(1000, function() {
						$(this).remove();
					});
				} else {
					snow.alert(json.data.message);
				}
			});
		}).on('change', 'input.snow-status', function(e) {
			// 提交审核
			var _this = $(this),
				_id = _this.data('id');
			$.getJSON('/events/setstatus', {
				id: _id,
				status: _this.val()
			}, function(json) {
				if (json.ok) {
					//					_this.closest('tr').slideUp(1000,function(){
					//						$(this).remove();
					//					});
				} else {
					snow.alert(json.data.message);
				}
			});
		});
	});
</script>