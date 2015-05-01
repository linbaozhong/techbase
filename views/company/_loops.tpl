<div class="alert" role="alert"></div>
<div class="col-md-3">
	
</div>
<div class="col-md-9">
	<div class="">

	</div>
	<form class="form-horizontal snow-form-6">
		<div class="form-group">
			<div class="col-sm-3">
				<h4 class="snow-underline">融资经历</h4>
			</div>
			<div class="col-sm-9 text-right">
				<a href="#" title="增加"><i class="fa fa-plus-circle fa-lg" style="padding-top: 20px;"></i></a>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>轮次</label>
			<div class="col-sm-3">
				<select class="form-control" name="loop">
					<option value=""></option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">融资金额</label>
			<div class="col-sm-3">
				<select class="form-control" name="amountMoney">
					<option value="">美元</option>
				</select>
			</div>
			<div class="col-sm-3">
				<input class="form-control" name="title" placeholder="" value="{{.loops.Amount}}">
			</div>
			<div class="col-sm-3">
				<label class="control-label">万</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">估值</label>
			<div class="col-sm-3">
				<select class="form-control" name="amountMoney">
					<option value="">美元</option>
				</select>
			</div>
			<div class="col-sm-3">
				<input class="form-control" name="title" placeholder="" value="{{.loops.Value}}">
			</div>
			<div class="col-sm-3">
				<label class="control-label">万</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"><span class="snow-required">*</span>融资时间</label>
			<div class="col-sm-3">
				<select class="form-control" name="year">
					<option value="2014">2014 年</option>
					<option value="2015">2015 年</option>
					<option value="2016">2016 年</option>
				</select>
			</div>	
			<div class="col-sm-3">
				<select class="form-control" name="month">
					<option value="1">1 月</option>
					<option value="2">2 月</option>
					<option value="3">3 月</option>
					<option value="4">4 月</option>
					<option value="5">5 月</option>
					<option value="6">6 月</option>
					<option value="7">7 月</option>
					<option value="8">8 月</option>
					<option value="9">9 月</option>
					<option value="10">10 月</option>
					<option value="11">11 月</option>
					<option value="12">12 月</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">投资主体</label>
			<div class="col-sm-9">
				<input class="form-control" name="name" placeholder="如：经纬中国" value="{{.loops.Investor}}">
			</div>
		</div>

		<div class="form-group">
			<label for="inputIntro" class="col-sm-3 control-label">
				<input type="hidden" name="id" value="{{.loops.Id}}" />
				<input type="hidden" name="companyId" value="{{.loops.CompanyId}}" />
			</label>
			<div class="col-sm-9">
				<button type="submit" class="btn btn-primary col-sm-12">保存</button>
			</div>
		</div>
	</form>

</div>
<script type="text/javascript">
	$(function(){
		
		$('.snow-form-6').submit(function(e){
			e.preventDefault();
			
		});
	});
</script>