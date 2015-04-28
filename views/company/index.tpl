<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>{{.subTitle}}</h3><a class="btn btn-primary btn-create pull-right" style="padding-top: 0;padding-bottom: 0;margin-top:-37px;" href="/company/create">创建公司</a>
	
			<!--数据在这里-->
			<div class="" id="snow-list" style="margin-top: 30px;">
				<div class="media row-id-">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" data-src="holder.js/64x64" alt="64x64" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PGRlZnMvPjxyZWN0IHdpZHRoPSI2NCIgaGVpZ2h0PSI2NCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjE0LjUiIHk9IjMyIiBzdHlsZT0iZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQ7ZG9taW5hbnQtYmFzZWxpbmU6Y2VudHJhbCI+NjR4NjQ8L3RleHQ+PC9nPjwvc3ZnPg==" 
				      data-holder-rendered="true" style="width: 84px; height: 84px;">
				    </a>
				  </div>
				  <div class="media-body">
				  	<div>
				  		<span class="media-heading">环球商贸网</span>
				  		<span>正在审核中</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span>
				  
				  		<span class="pull-right">申请融资</span>
				  	</div>
				    
				    Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
				  </div>
				</div>
				<div class="media">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" data-src="holder.js/64x64" alt="64x64" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PGRlZnMvPjxyZWN0IHdpZHRoPSI2NCIgaGVpZ2h0PSI2NCIgZmlsbD0iI0VFRUVFRSIvPjxnPjx0ZXh0IHg9IjE0LjUiIHk9IjMyIiBzdHlsZT0iZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQ7ZG9taW5hbnQtYmFzZWxpbmU6Y2VudHJhbCI+NjR4NjQ8L3RleHQ+PC9nPjwvc3ZnPg==" 
				      data-holder-rendered="true" style="width: 84px; height: 84px;">
				    </a>
				  </div>
				  <div class="media-body">
				    <div><span class="media-heading">环球商贸网</span>
				  		<span>正在审核</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span>
				  		
				  		 <div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-exclamation-circle"></i></span></div>
				  	</div>
				    Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
				  </div>
				</div>
			</div>
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<script type="text/javascript">
	function push_item(item){
		var _row = $('#snow-list').find('.row-id-'+item.id),
			_html = [];
		 _html.push('<div class="media row-id-'+item.id+'">');                                                         
		 _html.push('<div class="media-left"><a href="#"><img class="media-object" src="'+item.logo+'" style="width: 84px; height: 84px;"></a></div>');                                                         
		 _html.push('<div class="media-body"><div><span class="media-heading">'+item.name+'</span>');
		 
		 switch (item.state){
		 	case 0:
		 		_html.push('<span>正在审核中</span> <span title="您的融资申请正在审核中，审核通过后，她本营的工作人员会与您取得进一步联系"><i class="fa fa-question-circle"></i></span>');
		 		_html.push('<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span></div>');
		 		break;
		 	case 1:
		 		_html.push('<span>审核通过</span>');
		 		_html.push('<div class="pull-right"><a href="#">申请融资</a></div>');
		 		break;
		 	default:
		 		_html.push('<span>审核未通过</span> <span title="审核未通过的原因"><i class="fa fa-exclamation-circle"></i></span>');
		 		_html.push('<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span></div>');
		 		break;
		 }
		 
		 _html.push('</div>');

		 _html.push(item.intro);                                                         
		 _html.push('</div>'); 
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
	}
		
	// 读取数据列表
	function load_data(){
		// 清空数据列表
		$('#snow-list tbody tr.data-row').remove();
		// 拉取数据
		$.getJSON('/company/list',function(json){
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
	}
	
	$(function() {

		load_data();
		
		// 新建按钮事件，弹出编辑框
		$('#snow-list tbody').on('click','.btn-create',function(){
			// 重置表单
			$('#snow-form').find('form')[0].reset();
			// 弹窗
			pop_window();
		}).on('click','.btn-edit',function(){
			var item = $(this).closest('tr').data('data');
			// 重置表单
			$('#snow-form').find('form')[0].reset();
			$('#inputId').val(item.id);
			$('#inputName').val(item.name);
			$('#inputValue').val(item.value);
			// 弹窗
			pop_window();
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
					_form.children('.alert').removeClass('visible');
					snow.popWindow.close();
					push_item(json.data);
				} else{
					_form.children('.alert').removeClass('alert-success').addClass('alert-danger').addClass('visible').text(':( , '+json.message);
				}
			});
		})
	});
</script>