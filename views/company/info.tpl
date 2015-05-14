<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10 snow-padding-top-40">
			<div class="text-right">
				{{if and (eq .company.Status 0) (eq .company.Creator .account.Id)}}
				<a href="/company/edit/{{.company.Id}}"><i class="fa fa-pencil"></i>&nbsp;编辑</a>&nbsp;&nbsp;&nbsp;
				{{end}}
				<a href="/my/company"><i class="fa fa-th-list"></i>&nbsp;返回我的公司</a>
			</div>
			<hr />
			<!--创建公司-->
			<div class="row snow-row-1">
				<div class="media">
					<div class="media-left">
						<a href="/company/info/{{.company.Id}}">
							<img class="media-object" src="{{.company.Logo}}" style="width: 100px;">
						</a>
					</div>
					<div class="media-body">
						<div><span class="media-heading lead">{{.company.Name}}</span> 
							{{if eq .company.Status 0}}
							<span>未提交审核</span> <span title="您的公司仍未提交审核，请尽快完善公司注册内容并提交审核，审核通过后，她本营的工作人员会与您取得进一步联系"><i class="fa fa-question-circle"></i></span>
							<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span>
							</div>
							{{else if eq .company.Status 1}}
							<span>正在审核中</span> <span title="您的公司正在审核中，审核通过后，她本营的工作人员会与您取得进一步联系"><i class="fa fa-question-circle"></i></span>
							<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span>
							</div>
							{{else if eq .company.Status 2}}
							<span>审核通过</span>
							<div class="pull-right"><a href="/my/apply/{{.company.Id}}">申请融资</a>
							</div>
							{{else}}
							<span>审核未通过</span> <span title="审核未通过的原因"><i class="fa fa-exclamation-circle"></i></span>
							<div class="pull-right"><span>申请融资</span> <span title="审核通过后即可快速申请融资"><i class="fa fa-question-circle"></i></span>
							</div>
							{{end}}
							<p>{{.company.Intro}}</p>
						</div>
					</div>
				</div>
			</div>
			<hr />

			<!--联系公司-->
			<div class="row snow-row-2">

			</div>

			<!--公司介绍-->
			<div class="row snow-row-3 snow-padding-top-40">
				<div class="form-group">
					<div class="col-sm-1"></div>
					<div class="col-sm-2">
						<h4 class="snow-underline">公司介绍</h4>
					</div>
					<div class="col-sm-8">
						&nbsp;
					</div>
					<div class="col-sm-1"></div>
				</div>
				<div class="form-group">
					<div class="col-sm-1"></div>
					<div class="col-sm-2">
						&nbsp;
					</div>
					<div class="col-sm-8">
						{{$imgs := (split .introduce.Images ";")}}
						<ul class="snow-uploads" style="margin-top: 10px;">
							{{range $i,$img := $imgs}}
							<li>
								<img src="{{$img}}">
							</li>
							{{end}}
						</ul>
						<div>
							{{.introduce.Content}}
						</div>
					</div>
					<div class="col-sm-1"></div>
				</div>
			</div>

			<!--相关链接-->
			<div class="row snow-row-4 snow-padding-top-40">
				<div class="col-sm-1"></div>
				<div class="col-sm-2">
					<h4 class="snow-underline">产品介绍</h4>
				</div>
				<div class="form-horizontal col-sm-8">
					<div class="form-group">
						&nbsp;
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right">Web端链接</label>
						<div class="col-sm-9">
							{{.links.Web}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right">iPhone下载链接</label>
						<div class="col-sm-9">
							{{.links.Iphone}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right">PC下载端链接</label>
						<div class="col-sm-9">
							{{.links.Windows}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right">Android下载链接</label>
						<div class="col-sm-9">
							{{.links.Android}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right">iPad下载链接</label>
						<div class="col-sm-9">
							{{.links.Ipad}}
						</div>
					</div>
				</div>
				<div class="col-sm-1"></div>

			</div>

			<!--创始团队-->
			<div class="row snow-row-5 snow-padding-top-40">
				<div class="col-sm-1"></div>
				<div class="col-sm-2">
					<h4 class="snow-underline">创始团队</h4>
				</div>
				<div class="form-horizontal col-sm-8">
					<div class="form-group">
						&nbsp;
					</div>
					{{range .members}}
					<div class="snow-member col-sm-3 snow-members-{{.Id}}">
						<div class="snow-avatar img-circle">
							<img src="{{.Avatar}}" />
						</div>
						<div>
							<label class="control-label">{{.Name}}</label>
						</div>
						<div>
							<span class="snow-member-{{.Place}}"></span> <span>{{.Title}}</span>
						</div>
					</div>
					{{end}}
				</div>
				<div class="col-sm-1"></div>
			</div>

			<!--融资经历-->
			<div class="row snow-row-6 snow-padding-top-40">
				<div class="col-sm-1"></div>
				<div class="col-sm-2">
					<h4 class="snow-underline">融资经历</h4>
				</div>
				<div class="form-horizontal col-sm-8">
					<div class="form-group">
						&nbsp;
					</div>
					<!--融资经历个体-->
					{{range .loops}}
					<div class="snow-loop snow-loops-{{.Id}}">
						<div class="snow-tools">
							
						</div>
						<div>
							<label class="control-label lead snow-loop-{{.Loop}}">天使轮</label><span>{{.Year}}.{{.Month}}</span>
						</div>
						<div class="clearfix">
							<div class="pull-left">
								<label class="control-label">融资金额:</label><span><i class="fa snow-money-{{.AmountMoney}}"></i> {{.Amount}}</span><span>万</span>
							</div>
							<div class="pull-right">
								<label class="control-label">融资估值:</label><span><i class="fa snow-money-{{.ValueMoney}}"></i> {{.Value}}</span><span>万</span>
							</div>
						</div>
						<hr />
						<div>
							<label class="control-label">{{.Investor}}</label>
						</div>
					</div>
					{{end}}
				</div>
				<div class="col-sm-1"></div>
			</div>

		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>
<script type="text/javascript">
	$(function() {
		$.getJSON('/basic/place', function(json) {
			if (json.ok) {
				$.each(json.data, function(index, item) {
					// 修复创始成员
					$('.snow-row-5 .snow-member-' + item.value).text(item.name);
				});
			} else {}
		});
	});
</script>