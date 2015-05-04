<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>{{.subTitle}}</h3>
			<hr />
			<!--创建公司-->
			<div class="row snow-row-1">
			</div>

			<!--联系公司-->
			<div class="row snow-row-2">
			</div>

			<!--公司介绍-->
			<div class="row snow-row-3">
			</div>

			<!--相关链接-->
			<div class="row snow-row-4">
			</div>

			<!--创世团队-->
			<div class="row snow-row-5">
			</div>

			<!--融资经历-->
			<div class="row snow-row-6">
			</div>

		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<link rel="stylesheet" type="text/css" href="/static/css/upload.css"/>
<script src="/static/js/core.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/js/upload.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	function showMessage(obj,msg,success){
		if (success) {
			obj.removeClass('alert-danger').addClass('alert-success').addClass('visible').text(':) ,'+msg);
		} else{
			obj.removeClass('alert-success').addClass('alert-danger').addClass('visible').text(':( ,'+msg);
		}
	}
	function submit_disable(obj){
		$('.btn[type="submit"]',obj).attr('disabled',true).prepend('<i class="fa fa-spinner fa-spin"></i> ');
	}
	function submit_enable(obj){
		$('.btn[type="submit"]',obj).attr('disabled',false).find('i').remove();
	}
	$(function(){
		$('.snow-row-1').load('/company/GetCompany/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-2').load('/company/GetContact/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-3').load('/company/GetIntroduce/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-4').load('/company/GetLinks/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-5').load('/company/GetMembers/{{.companyId}}',function(){
			$(window).resize();
		});
		$('.snow-row-6').load('/company/GetLoops/{{.companyId}}',function(){
			$(window).resize();
		});
	});
</script>