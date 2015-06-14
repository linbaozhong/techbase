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
		<div class="col-md-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
			<h3 class="snow-color-red">{{.subTitle}}</h3>
			<a class="btn btn-primary pull-right" style="padding-top: 0;padding-bottom: 0;margin-top:-30px;" href="/company/edit"><i class="fa fa-plus-circle"></i>&nbsp; 创建项目</a>
	
			<!--数据在这里-->
			<div class="" id="snow-list" style="margin-top: 30px;">

			</div>
		</div>
	</div>
	<div id="snow-form" style="display:none;padding:30px;">
		<div class="text-center">
			<h5>转移管理权 - 意味着你将失去管理权</h5>
		</div>
		<form class="form-horizontal" style="position: absolute;left: 31px;right: 30px;bottom: 20px;">
			<div class="alert" role="alert">hi</div>
			<input type="hidden" name="id" id="inputId" value="0" />
			<div class="form-group">
				<div class="col-sm-12 snow-shift-url" style="word-wrap: break-word;">
					
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail" class="col-sm-3 control-label">Email</label>
				<div class="col-sm-9">
					<input type="email" required class="form-control" id="inputEmail" name="email" placeholder="Email" value="">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-12">
					<button type="submit" class="btn btn-primary col-sm-12">转移</button>
				</div>
			</div>
		</form>
	</div>
</article>
<script type="text/javascript">
	function push_item(item){
		console.log(item);
		
		var _row = $('#snow-list').find('.row-id-'+item.id),
			_html = [],_url='',_rongzi='';
			
		if(item.creator=={{.account.Id}} && item.status < 1){
		//if(item.accountId=={{.account.Id}}){
			_url = '/company/edit/'+item.id
		}else{
			_url = '/item/info/'+item.id
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
		 		_rongzi = '<div class="pull-right"><a href="/apply/index/'+item.id+'">申请融资</a></div>';
		 		break;
		 	default:
		 		_html.push('<span>审核未通过</span> <span title="'+item.reason+'"><i class="fa fa-exclamation-circle"></i></span>');
		 		_rongzi = '<div class="pull-right"><span>申请融资</span> <span title="项目提交并通过审核后,即可快速申请融资"><i class="fa fa-question-circle"></i></span></div>';
		 		break;
		 }
		 
		 _html.push('<div class="pull-right small"><i class="fa fa-eye"></i>&nbsp;'+item.readed+'</div>');
		 _html.push('</div><p>');
		 _html.push(item.intro);                                                         
		 _html.push('</p>');
		 _html.push('<div><div class="pull-right">&nbsp;&nbsp;<a class="snow-shift" data-id="'+item.id+'" href="javascript:;">转移管理权</a></div>'+_rongzi+'</div>');
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
		$('#snow-list').empty();
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
		$('#snow-list').on('click','.snow-shift',function(){
			// 重置表单
			$('#snow-form').find('form')[0].reset();
			$('#snow-form input[name="id"]').val($(this).data('id'));
			$('#snow-form .snow-shift-url').text('');
			// 弹窗
			pop_window();
		});
		// 提交表单
		$('#snow-form form').submit(function(e){
			e.preventDefault();
			var _form = $(this);
			
			$.post('/company/shift',_form.serialize(),function(json){
				if (json.ok) {
					var _url = window.location.protocol 
						+ '//' + window.location.host 
						+ '/company/shifted?id='+json.data.companyId+'&token='+json.data.token;
						
					$('#snow-form .snow-shift-url').html('邮件已经发出，也可以将此链接发给对方:<br>'+_url);
					showMessage(_form.find('.alert'),'邮件已经发出，也可以将此链接发给对方:<br>'+_url,true);
					//snow.popWindow.close();
				} else{
					showMessage(_form.find('.alert'),json.message,false);
				}
			});
		})
	});
</script>