<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>账号管理</h3>
			<div class="text-right">

			</div>
			<!--账号列表-->
			<div class="row snow-row-1 snow-padding-top-40">
				<table class="table">
					<tr>
						<th>#</th>
						<th>昵称</th>
						<th>电话</th>
						<th>Email</th>
						<th>简介</th>
						<th>注册时间</th>
						<th>禁用</th>
					</tr>
					{{range $index,$account := .accounts}}
					<tr>
						<td>{{$index}}</td>
						<td>{{$account.NickName}}</td>
						<td>{{$account.Telphone}}</td>
						<td>{{$account.Email}}</td>
						<td>{{$account.Intro}}</td>
						<td>{{$t := m2t $account.Updated}}{{date $t "Y-m-d H:i"}}</td>
						<td>
							<input type="checkbox" name="status" id="inputStatus" value="{{$account.Status}}" />
						</td>
					</tr>
					{{end}}
				</table>

			</div>
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<script type="text/javascript">
	$(function() {});
</script>