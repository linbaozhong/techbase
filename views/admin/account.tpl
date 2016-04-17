<div class="container banner" style="margin-top:-75px;height: 75px;overflow: hidden;z-index: -1;">
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
			<h3 class="snow-color-red">账号管理</h3>
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
							<th>角色</th>
							<th>禁用</th>
                            <th></th>
						</tr>
					</thead>
					<tbody>
						{{$option := str2html .option}} {{range $index,$account := .accounts}}
						<tr>
							<td>{{$index}}</td>
							<td>{{$account.NickName}}</td>
							<td>{{$account.Telphone}}</td>
							<td>{{$account.Email}}</td>
							<td>
								<select value="" data-id="{{$account.Id}}" data-role="{{$account.Role}}">
									{{$option}}
								</select>
							</td>
							<td>
								<input type="checkbox" name="status" data-id="{{$account.Id}}" {{if eq $account.Status 1}}checked{{end}} />
							</td>
                            <td><a href="#" class="snow-reset" data-id="{{$account.Id}}">密码重置</a></td>
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
        // 密码重置
        $('a.snow-reset').click(function(){
            var _self = $(this);
            $.getJSON('/admin/resetpassword', {
				id: _self.data('id')
			}, function(json) {
				if (json.ok) {
 					alert('hi,密码已经重置,不用谢了……');                   
                } else {
					alert(json.message);
				}
			});
            return false;
        });
	});
</script>