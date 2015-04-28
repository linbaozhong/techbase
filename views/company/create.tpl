<article class="container">
	<div class="row">
		<div class="col-md-1">

		</div>
		<div class="col-md-10">
			<h3>{{.subTitle}}</h3>
	
			<!--数据在这里-->
			<hr />
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-9"></div>
			</div>
			<div class="alert" role="alert">hi</div>
			<div class="row">
				<div class="col-md-3">
					<div class="pull-right" style="width:84px;">
						<img src="" alt="" style="width:84px;height:84px;" />
						<br />
						<button type="submit" class="btn btn-primary col-sm-12">上传</button>
					</div>
				</div>	
				<div class="col-md-9">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputNickname" class="col-sm-3 control-label">公司简称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="inputNickname" name="nickname" placeholder="公司简称" value="{{.nickName}}">
							</div>
						</div>
						<div class="form-group">
							<label for="inputTelphone" class="col-sm-3 control-label">公司网址</label>
							<div class="col-sm-9">
								<input type="tel" class="form-control" id="inputTelphone" name="telphone" placeholder="公司网址" value="{{.profile.Telphone}}">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-3 control-label">公司全称</label>
							<div class="col-sm-9">
								<input type="email" class="form-control" id="inputEmail" name="email" placeholder="公司全称" value="{{.profile.Email}}">
							</div>
						</div>
						<div class="form-group">
							<label for="inputIntro" class="col-sm-3 control-label">一句话简介</label>
							<div class="col-sm-9">
								<textarea class="form-control" id="inputIntro" name="intro" rows="" cols="" placeholder="用一句话介绍公司">{{.profile.Intro}}</textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-3 control-label">公司所在地</label>
							<div class="col-sm-2">
								<select class="form-control" name="">
									<option value="">中国</option>
								</select>
							</div>							
							<div class="col-sm-2">
								<select class="form-control" name="">
									<option value="">北京市</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-3 control-label">创办时间</label>
							<div class="col-sm-4">
								<input type="date" class="form-control" id="inputEmail" name="email" placeholder="公司全称" value="{{.profile.Email}}">
							</div>
						</div>
						<div class="form-group">
							<label for="inputIntro" class="col-sm-3 control-label">公司领域</label>
							<div class="col-sm-9">
								<input type="checkbox" name="" id="" value=""/><span for="">二次元</span>
								<input type="checkbox" name="" id="" value=""/><span for="">二次元</span>
								<input type="checkbox" name="" id="" value=""/><span for="">二次元</span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputIntro" class="col-sm-3 control-label">运营状态</label>
							<div class="col-sm-9">
								<input type="radio" name="state" id="" value=""/><span for="">尚未开始运营</span>
								<input type="radio" name="state" id="" value=""/><span for="">运营中</span>
								<input type="radio" name="state" id="" value=""/><span for="">停止运营</span>
							</div>
						</div>


						<div class="form-group">
							<div class="col-sm-12">
								<button type="submit" class="btn btn-primary col-sm-12">保存</button>
							</div>
						</div>
					</form>
						
				</div>
			</div>

		</div>
		<div class="col-md-1">

		</div>
	</div>

</article>