<div class="banner" style="height: 90px;overflow: hidden;">
	<div class="slideshow">
		<ol class="slides">
			<li class="current banner-1 text-center">
				<div class="description">
					
				</div>
			</li>
		</ol>
	</div>
</div>
<article class="container text-center">
	<div class="row">
		<div class="col-md-3">

		</div>
		<div class="col-md-6">
			<h2>她本营</h2>
			<h4>女性科技互联网创业生态圈</h4>
			<hr />
			<form class="form-horizontal">
				<div class="alert" role="alert">hi</div>
				<div class="form-group">
					<label for="inputNickname" class="col-sm-3 control-label">用户昵称</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="inputNickname" name="nickname" placeholder="用户昵称" value="{{.nickName}}">
					</div>
				</div>
				<div class="form-group">
					<label for="inputTelphone" class="col-sm-3 control-label">电话</label>
					<div class="col-sm-9">
						<input type="tel" class="form-control" id="inputTelphone" name="telphone" placeholder="电话" value="{{.profile.Telphone}}">
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail" class="col-sm-3 control-label">邮件</label>
					<div class="col-sm-9">
						<input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email" value="{{.profile.Email}}">
					</div>
				</div>
				<div class="form-group">
					<label for="inputIntro" class="col-sm-3 control-label">一句话介绍自己</label>
					<div class="col-sm-9">
						<textarea class="form-control" id="inputIntro" name="intro" rows="" cols="" placeholder="用一句话介绍自己">{{.profile.Intro}}</textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-12">
						<button type="submit" class="btn btn-primary col-sm-12">保存</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-3">

		</div>
	</div>

</article>
<script type="text/javascript">
	$(function(){
		$('form').submit(function(e){
			var _form = $(this);
			e.preventDefault();
			$.post('/my/save',_form.serialize(),function(json){
				//console.log(json);
				if(json.ok){
					$('#avatar .nickname').text(json.data.nickName);
					_form.children('.alert').removeClass('alert-danger').addClass('alert-success').addClass('visible').text('hi,我已经为你保存好了,不用谢了…… :)');
				}else{
					var _errors=[];
					for (var i = 0; i < json.data.length; i++) {
						_errors.push(json.data[i].message);
					}
					_form.children('.alert').removeClass('alert-success').addClass('alert-danger').addClass('visible').text(':( ,'+_errors.join(';'));
				}
			});
		});
	});
</script>