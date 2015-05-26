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
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>媒体管理</h3>
			<div class="text-right">

			</div>
			<!--账号列表-->
			<div class="row snow-row-1 snow-padding-top-40">
				<table class="table table-condensed table-hover">
					<thead>
						<tr>
							<th>#</th>
							<th>昵称</th>
							<th>电话</th>
							<th>Email</th>
							<th>简介</th>
							<th>注册时间</th>
							<th>角色</th>
							<th>禁用</th>
						</tr>
					</thead>
					<tbody>
						{{range $index,$art := .articles}}
						<tr>
							<td>{{$index}}</td>
							<td>{{$art.Title}}</td>
							<td>{{$t := m2t $art.Updated}}{{date $t "Y-m-d H:i"}}</td>
							
							<td>
								<input type="checkbox" name="status" data-id="{{$art.Id}}" {{if eq $art.Status 1}}checked{{end}} />
							</td>
						</tr>
						{{end}}</tbody>
				</table>

			</div>
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<script type="text/javascript">
	$(function() {
		// 变更角色
		$('.snow-row-1 select').each(function() {
			var _self = $(this);
			_self.val(_self.data('role'));
		}).change(function() {
			var _self = $(this);
			$.getJSON('/admin/updateRole', {
				id: _self.data('id'),
				role: _self.val()
			}, function(json) {
				if (json.ok) {
					_self.data('role', _self.val());
				} else {
					_self.val(_self.data('role'));
					alert(json.message);
				}
			});
		});
		// 禁用和启用
		$('.snow-row-1 input[name="status"]').change(function() {
			var _self = $(this),
				_status = _self.is(':checked') ? 1 : 0;
			$.getJSON('/admin/updateStatus', {
				id: _self.data('id'),
				status: _status
			}, function(json) {
				if (json.ok) {} else {
					_self.attr('checked', !_self.is(':checked'));
					alert(json.message);
				}
			});
		});
	});
</script>