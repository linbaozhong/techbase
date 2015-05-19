<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>{{.subTitle}}</h3>
			<a class="btn btn-primary btn-create pull-right" style="padding-top: 0;padding-bottom: 0;margin-top:-30px;" href="/company/edit"><i class="fa fa-plus-circle"></i>&nbsp; 创建项目</a>
	
			<!--数据在这里-->
			<div class="" id="snow-list" style="margin-top: 30px;">

			</div>
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<script type="text/javascript">
	function push_item(item){
		console.log(item);
		
		var _row = $('#snow-list').find('.row-id-'+item.id),
			_html = [],_url='',_rongzi='';
			
		if(item.creator=={{.account.Id}} && item.status < 1){
			_url = '/company/edit/'+item.id
		}else{
			_url = '/company/info/'+item.id
		}
		 _html.push('<div class="media row-id-'+item.id+'">');                                                         
		 _html.push('<div class="media-left"><a href="'+_url+'"><img class="media-object" src="'+item.logo+'" style="width: 100px;"></a></div>');                                                         
		 _html.push('<div class="media-body"><div><a href="'+_url+'"><span class="media-heading" style="font-size:1.15em;">'+item.name+'</span></a>');
		 
		 switch (item.status){
		 	case 0:
		 		_html.push('<span>未提交审核</span> <span title="您的项目仍未提交审核，请尽快完善公司注册内容并提交审核，审核通过后，她本营的工作人员会与您取得进一步联系"><i class="fa fa-question-circle"></i></span>');
		 		_rongzi = '<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span></div>';
		 		break;
		 	case 1:
		 		_html.push('<span>正在审核中</span> <span title="您的项目正在审核中，审核通过后，她本营的工作人员会与您取得进一步联系"><i class="fa fa-question-circle"></i></span>');
		 		_rongzi = '<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span></div>';
		 		break;
		 	case 2:
		 		_html.push('<span>审核通过</span>');
		 		_rongzi = '<div class="pull-right"><a href="#">申请融资</a></div>';
		 		break;
		 	default:
		 		_html.push('<span>审核未通过</span> <span title="'+item.reason+'"><i class="fa fa-exclamation-circle"></i></span>');
		 		_rongzi = '<div class="pull-right"><span>申请融资</span> <span title="项目提交并通过审核后,即可快速申请融资"><i class="fa fa-question-circle"></i></span></div>';
		 		break;
		 }
		 
		 _html.push('<div class="pull-right"><i class="fa fa-eye"></i>&nbsp;'+item.readed+'</div>');
		 _html.push('</div><p>');
		 _html.push(item.intro);                                                         
		 _html.push('</p>');
		 _html.push('<div>'+_rongzi+'</div>');
		 _html.push('</div>');
		 
		 // 检查该行是否已经存在
		 if (_row.length) {
		 	// 替换
		 	_row.replaceWith($(_html.join('')).data('data',item));
		 } else{
		 	// 追加
		 	$('#snow-list').append($(_html.join('')).data('data',item));
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