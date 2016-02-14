<div class="container banner" style="margin-top:75px;">

</div>
<div class="container" style="padding:50px 0;">

	<span style="background-color: #FE4A66;color:white;padding: 20px 30px 10px 50px;">
	<span id="now_month" style="font-size: 2em;">
			
		</span>
	<span id="now_year">
			
		</span>
	</span>

</div>
<div class="container">

	<ul class="row header">
		<li class="span">星期日</li>
		<li class="span">星期一</li>
		<li class="span">星期二</li>
		<li class="span">星期三</li>
		<li class="span">星期四</li>
		<li class="span">星期五</li>
		<li class="span">星期六</li>
	</ul>
</div>
<div id="rili" class="container" style="position:relative;margin-bottom:40px;">

</div>

<style type="text/css">
	.row {
		padding: 0 60px;
	}
	
	.row.header {
		text-align: center;
		font-weight: bold;
	}
	
	.row.header .span {
		background: #666;
		color: white;
		border-width: 1px 1px 1px 0 !important;
		border-color: #666 !important;
	}
	
	.span {
		width: 14.2857%;
		float: left;
		border-width: 0 1px 1px 0;
		border-color: #eee;
		border-style: solid;
	}
	
	.row .span:first-child {
		border-left-width: 1px;
	}
	
	.row.date {
		text-align: right;
		font-weight: bold;
	}
	
	.row .off {
		color: #ccc !important;
	}
	
	.row.events .span {
		height: 110px;
		min-height: 110px;
		color: #FE4A66;
	}
	
	.row.events .event {
		display: block;
		padding: 2px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	.row.events a {
		color: inherit;
	}
	
	.prev,
	.next {
		position: absolute;
		top: 0;
		bottom: 0;
		margin: auto 0;
		font-size: 6em;
		height: 1em;
		padding: 0 10px;
		color: #eee;
		cursor: pointer;
	}
	
	.prev {
		left: 0;
	}
	
	.next {
		right: 0;
	}
	
	.prev:hover,
	.next:hover {
		color: #ddd;
	}
</style>
<script type="text/javascript">
	$(function() {
		//
		var _rili = $('#rili');
		//事件
		_rili.on('click', '.prev,.next',
			function() {
				var _this = $(this);
				var _now = new Date(parseInt(_this.data('year')), parseInt(_this.data('month')), 1);
				getRili(_now);
			});
		var _month = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月', ];

		function getRili(_now) {
			_rili.empty();
			// 起始月
			var _start = new Date(_now.getFullYear(), _now.getMonth(), 1);
			var _today = {
				year: _now.getFullYear(),
				month: _now.getMonth(),
				day: _now.getDate(),
				week: _now.getDay()
			};
			$('#now_year').text(_today.year);
			$('#now_month').text(_month[_today.month]);
			//如果起始日期在一周中的天数大于0，调整起始日期
			if (_start.getDay() > 0) {
				_start.setDate(_start.getDate() - _start.getDay());
			}
			var _prev = new Date(_today.year, _today.month - 1, 1);
			var _next = new Date(_today.year, _today.month + 1, 1);
			var __today = new Date();
			while (_start < _next) {
				var _date = [],
					_event = [];
				_date.push('<ul class="row date">');
				_event.push('<ul class="row events">');
				for (var i = 0; i < 7; i++) {
					if (_start.getMonth() == _now.getMonth()) {
						_date.push('<li class="span">' + _start.getDate() + '</li>');
					} else {
						_date.push('<li class="span off">' + _start.getDate() + '</li>');
					}
					if (_start < __today) {
						_event.push('<li class="span off" id="event-' 
							+ _start.format('yyyy-MM-dd')
							+ '"></li>');
					} else {
						_event.push('<li class="span" id="event-' 
							+ _start.format('yyyy-MM-dd')
							+ '"></li>');
					}
					_start.setDate(_start.getDate() + 1);
				}
				_date.push('</ul>');
				_event.push('</ul>');
				_rili.append(_date.join('')).append(_event.join(''));
				// 日历导航
				_rili.append('<span class="prev fa fa-angle-left" data-year="' + _prev.getFullYear() + '" data-month="' + _prev.getMonth() + '"></span><span class="next fa fa-angle-right" data-year="' + _next.getFullYear() + '" data-month="' + _next.getMonth() + '"></span>');
			}
			//读取活动数据
			$.getJSON('/home/events', {
				time: new Date(_today.year, _today.month, 1).getTime()
			}, function(result) {
				if (result.ok) {
					console.log(result.data);
					var events = result.data;
					$.each(events, function(i, obj) {
						var _days = Math.abs(Math.floor((obj.endTime - obj.startTime) / (24 * 60 * 60 * 1000)));
						_days += 1;
						
						var __start = new Date(obj.startTime);
						$('#event-' + __start.format('yyyy-MM-dd')).append('<a class="event" href="/home/event/' + obj.id + '" target="_blank" style="width:' + (1 * 100) + '%;">' + obj.title + '</a>');
//						//处理跨日期事件
//						for (var i = 1; i < _days; i++) {
//							__start.setDate(__start.getDate() + 1);
//							
//							$('#event-' + __start.format('yyyy-MM-dd')).append('<span class="event">&nbsp;</span>');
//						}
					});
				} else {
					console.log(result.data);
				}
			});
		}
		getRili(new Date());
	});
</script>