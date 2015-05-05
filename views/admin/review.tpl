<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>公司审核</h3>
			<div class="text-right">
				
			</div>
			<hr />
			<!--创建公司-->
			<div class="row snow-row-1 snow-padding-top-40">
				{{range $index,$company := .companys}}
				<div class="media">
					<div class="media-left">
						<a href="/company/info/{{$company.Id}}" target="_blank">
							<img class="media-object" src="{{$company.Logo}}" style="width: 84px; height: 84px;">
						</a>
					</div>
					<div class="media-body">
						<div><span class="media-heading lead">{{$company.Name}}</span> 
							{{if eq $company.Status 0}}
							<span>未提交审核</span>
							<div class="pull-right">
							</div>
							{{else if eq $company.Status 1}}
							<span>正在审核中</span>
							<div class="pull-right">
							</div>
							{{else if eq $company.Status 2}}
							<span>审核通过</span>
							<div class="pull-right">
							</div>
							{{else}}
							<span>审核未通过</span>
							<div class="pull-right">
							</div>
							{{end}}
							<p>{{$company.Intro}}</p>
						</div>
					</div>
				</div>
			</div>
			{{end}}
		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<script type="text/javascript">
	$(function() {

	});
</script>