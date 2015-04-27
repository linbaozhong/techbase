<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h2>她本营</h2>
			<h4>女性科技互联网创业生态圈</h4>
			<hr />
			<!--数据在这里-->
			<table class="table table-bordered table-condensed table-hover" id="snow-list">
				<tbody>
				<tr>
					<th class="text-center">名称</th>
					<th class="text-center">取值</th>
					<th class="text-center">禁用</th>
					<th class="text-center"><button class="btn btn-primary btn-create">新建</button></th>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<article id="snow-form" style="display: none;padding:20px;">
	<form class="form-horizontal">
		<div class="alert" role="alert">hi</div>
		<input type="hidden" name="id" id="inputId" value="0" />
		<input type="hidden" name="parentId" id="inputParentId" value="0" />
		<input type="hidden" name="type" id="inputType" value="{{.typeid}}">
		<div class="form-group">
			<label for="inputName" class="col-sm-3 control-label">名称</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="inputName" name="name" placeholder="名称" value="">
			</div>
		</div>
		<div class="form-group">
			<label for="inputValue" class="col-sm-3 control-label">取值</label>
			<div class="col-sm-9">
				<input type="number" class="form-control" id="inputValue" name="value" placeholder="取值" value="0">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-12">
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>
</article>
<script type="text/javascript">
	$(function() {
		$.getJSON('/basic/list/{{.typeid}}',function(json){
			if (json.ok) {
				var _html = [];
				$.each(json.data, function(index,item) {    
					 _html.push('<tr>');                                                         
					 _html.push('<td class="text-center">'+item.name+'</td>');                                                         
					 _html.push('<td class="text-center">'+item.value+'</td>');                                                         
					 _html.push('<td class="text-center"><i class="fa '+(item.status?'fa-check-square-o':'fa-square-o')+'"></i></td>');                                                         
					 _html.push('<td class="text-center"><button class="btn btn-primary btn-edit">修改</button></td>');                                                         
					 _html.push('</tr>');                                                         
				});
				$('#snow-list tbody').append(_html.join(''));
			} else{
				
			}
		});
		
		// 新建
		$('#snow-list tbody').on('click','.btn-create',function(){
			// 重置表单
			$('#snow-form').find('form')[0].reset();
			// 弹窗
			snow.popWindow = $('#snow-form').popWindow({
				width: 400,
				height: 360,
				close: '<span><i class="fa fa-times"></i></span>'
			});
		});
		
		// 保存
		$('#snow-form form').submit(function(e){
			e.preventDefault();
			$.post('/basic/save',$(this).serialize(),function(json){
				console.log(json);
				if (json.ok) {
					snow.popWindow.close();
				} else{
					
				}
			});
		})
	});
</script>