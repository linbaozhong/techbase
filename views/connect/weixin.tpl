<div class="text-center" id="signin" style="display:none;">
	<header>
		<div class="row" style="margin-top:30px;">
			<div class="col-md-3 col-sm-3">

			</div>
			<div class="col-md-6 col-sm-6">
				<div>她本营</div>
				<div class="" style="margin-top:30px;">
					女性科技互联网创业生态圈
				</div>
				<a href="/help" target="_blank" title="隐私说明"><span style="position:absolute;top:0;right:0;"><i class="fa fa-info-circle"></i></span></a>
			</div>
			<div class="col-md-3 col-sm-3">

			</div>
		</div>

		<div class="" style="position: absolute;top: 140px;width: 100%;">
			<div class="col-md-4 col-sm-5">
				<hr />
			</div>
			<div class="col-md-4 col-sm-2">
				<!--<h5><img src="https://open.weixin.qq.com/zh_CN/htmledition/res/assets/res-design-download/icon32_wx_logo.png"/> 微信扫码登录</h5>-->
			</div>
			<div class="col-md-4 col-sm-5">
				<hr />
			</div>
		</div>
	</header>
	<div id="signin-weixin" style="margin-top:30px;">

	</div>
	<footer></footer>
</div>
<script type="text/javascript">

	var obj = new WxLogin({
		id: "signin-weixin",
		appid: "{{.appid}}",
		scope: "snsapi_login",
		redirect_uri: "{{.callback}}",
		state: escape(window.location.href),
		style: "",
		href: ""
	});
</script>