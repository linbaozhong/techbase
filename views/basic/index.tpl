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
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3 class="snow-color-red">基础数据 - {{.subTitle}}</h3>
			{{if eq .typeid 2}}
				<div class="form-group text-right">
					<label class="control-label">选择国家：</label>
					{{str2html .options}}
				</div>
			{{end}}
			
			<!--数据在这里-->
			<table class="table table-condensed table-hover" id="snow-list">
				<thead>
				<tr>
					<th class="text-center">名称</th>
					<th class="text-center">取值</th>
					<th class="text-center">别名</th>
					<th class="text-center">禁用</th>
					<th class="text-center"><button class="btn btn-primary btn-create">新建</button></th>
				</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<article id="snow-form" style="display: none;padding:30px;">
	<div class="text-center">
		<h5>基础数据 - {{.subTitle}}</h5>
	</div>
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
			<label for="inputAlias" class="col-sm-3 control-label">别名</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="inputAlias" name="alias" placeholder="别名" value="">
			</div>
		</div>
		<div class="form-group">
			<label for="inputValue" class="col-sm-3 control-label">取值</label>
			<div class="col-sm-9">
				<input type="number" readonly class="form-control" id="inputValue" name="value" placeholder="取值" value="0">
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
	function push_item(item){
		var _row = $('#snow-list tbody').find('tr.row-id-'+item.id),
			_html = [];
		 _html.push('<tr class="data-row row-id-'+item.id+'">');                                                         
		 _html.push('<td class="text-center">'+item.name+'</td>');                                                         
		 _html.push('<td class="text-center">'+item.value+'</td>');                                                         
		 _html.push('<td class="text-center">'+item.alias+'</td>');                                                         
		 _html.push('<td class="text-center"><i class="fa '+(item.status?'fa-check-square-o':'fa-square-o')+' snow-check"></i></td>');                                                         
		 _html.push('<td class="text-center"><button class="btn btn-primary btn-edit">修改</button></td>');                                                         
		 _html.push('</tr>'); 
		 // 检查该行是否已经存在
		 if (_row.length) {
		 	// 替换
		 	_row.replaceWith($(_html.join('')).data('data',item));
		 } else{
		 	// 追加
		 	$('#snow-list tbody').append($(_html.join('')).data('data',item));
		 }
	}
	function push_list(list){
		
		$.each(list, function(index,item) {   
			push_item(item);
		});
		
		snow.footerBottom();
	}
		
	// 读取数据列表
	function load_data(){
		// 清空数据列表
		$('#snow-list tbody tr.data-row').remove();
		// 拉取数据
		$.getJSON('/basic/list',{typeId:'{{.typeid}}',parentId:$('#inputParentId').val()},function(json){
			if (json.ok) {
				push_list(json.data);
			} else{
//				$('#snow-list tbody').append('<tr class="data-row"><td colspan="4">:) 没有找到符合条件的数据</td></tr>');
			}
		});		
	}
	// 弹窗
	function pop_window(){
		snow.popWindow = $('#snow-form').popWindow({
			width: 400,
			height: 360,
			close: '<span><i class="fa fa-times"></i></span>'
		});
		$('#snow-form form #inputName').focus();
	}
	
	$(function() {

		load_data();
		
		// 新建按钮事件，弹出编辑框
		$('#snow-list thead').on('click','.btn-create',function(){
			// 重置表单
			var _form = $('#snow-form form');
			_form[0].reset();
			$('input[name="id"]').val(0);
			
			// 取当前类型的下一个取值
			$.getJSON('/basic/maxValue',{
				typeId:$('#inputType',_form).val(),
				parentId:$('#inputParentId',_form).val()
			},function(json){
				if (json.ok && $('#inputValue',_form).val()==0) {
					$('#inputValue',_form).val(json.data);
				}
			});
			// 弹窗
			pop_window();
		});
		// 编辑按钮事件
		$('#snow-list tbody').on('click','.btn-edit',function(){
			var item = $(this).closest('tr').data('data');
			// 重置表单
			$('#snow-form').find('form')[0].reset();
			$('#inputId').val(item.id);
			$('#inputName').val(item.name);
			$('#inputValue').val(item.value);
			$('#inputAlias').val(item.alias);
			// 弹窗
			pop_window();
		}).on('click','.snow-check',function(){
			var item = $(this).closest('tr').data('data');
			$.getJSON('/basic/status',{
				id:item.id,
				status:item.status
			},function(json){
				if (json.ok ) {
					var item=json.data,_row = $('#snow-list tbody').find('tr.row-id-'+item.id);
					_row.find('i').replaceWith('<i class="fa '+(item.status?'fa-check-square-o':'fa-square-o')+' snow-check"></i>');
				}else{
					
				}
			});
		});
		// 选项改变
		$('#selectParentId').change(function(){
			$('#inputParentId').val($(this).val());
			load_data();
		});
		// 提交表单
		$('#snow-form form').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			$.post('/basic/save',_form.serialize(),function(json){
				if (json.ok) {
					snow.popWindow.close();
					push_item(json.data);
				} else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].key +','+ json.data[i].message);
					}
					showMessage(_form.find('.alert'),_errors.join(';'),false);
				}
			});
		})
	});
</script>