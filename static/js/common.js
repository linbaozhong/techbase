// 扩展字符串方法，按最大长度截取字符串
String.prototype.cut = function(max,end) {
    var returnValue = [];
    var byteValLen = 0;
    for (var i = 0; i < this.length; i++) {

        if (this[i].match(/[^x00-xff]/ig) == null)
            byteValLen += 1;
        else
            byteValLen += 2;

        if (byteValLen > max){
        	returnValue.push(end || '');
            break;
        }
        
        returnValue.push(this[i]);
    }
    
    return returnValue.join('');
}

// 扩展字符串方法，用指定字符填充字符串
String.prototype.padLeft = function(int, char) {
	if (this.length >= int) {
		return this;
	} else {
		var n = int - this.length,
			s = [];
		for (var i = 0; i < n; i++) {
			s.push(char);
		}
		return s.join('') + this;
	}
};
// 扩展日期方法，日期格式化
Date.prototype.format = function(format) {
	var date = this;
	if (arguments.length == 0 && !date.getTime) {
		format = date;
		date = new Date();
	}
	if (typeof format != 'string') {
		var _now = new Date(),
			_fmt = [];
		if (date.getFullYear() != _now.getFullYear()) {
			_fmt.push('yyyy年');
		}
		if (date.getMonth() != _now.getMonth()) {
			_fmt.push('MM月');
		}
		if (date.getDate() != _now.getDate()) {
			if (_fmt.length) {
				_fmt.push('dd日');
			} else {
				var _day = (_now.getTime() - date.getTime()) / (24*60*60*1000);
				if (_day > 2) {
					_fmt.push('dd日');
				} else if (_day > 0){
					return _day == 1 ? '昨天' : '前天';
				}else{
					_fmt.push('dd日');
				}
			}
		}
		if (!_fmt.length) {
			if (date.getHours() != _now.getHours()) {
				return (_now.getHours() - date.getHours()).toString() + '小时前';
			}
			if (date.getMinutes() != _now.getMinutes()) {
				return (_now.getMinutes() - date.getMinutes()).toString() + '分钟前';
			}
			return '刚刚';
		}
		//format = 'yyyy年MM月dd日 hh时mm分ss秒';
		format = _fmt.join('');
	}
	var week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', '日', '一', '二', '三', '四', '五', '六'];
	return format.replace(/yyyy|yy|MM|dd|hh|mm|ss|星期|周|www|week/g, function(a) {
		switch (a) {
			case "yyyy":
				return date.getFullYear();
			case "yy":
				return (date.getFullYear() + "").slice(2);
			case "MM":
				return (date.getMonth() + 1).toString(); //.padLeft(2,'0');
			case "dd":
				return date.getDate().toString(); //.padLeft(2, '0');
			case "hh":
				return date.getHours().toString().padLeft(2, '0');
			case "mm":
				return date.getMinutes().toString().padLeft(2, '0');
			case "ss":
				return date.getSeconds().toString().padLeft(2, '0');
			case "星期":
				return "星期" + week[date.getDay() + 7];
			case "周":
				return "周" + week[date.getDay() + 7];
			case "week":
				return week[date.getDay()];
			case "www":
				return week[date.getDay()].slice(0, 3);
		}
	});
};


/*
jQuery弹窗插件 By 哈利蔺特 
 * 使用方法:
 * $('.lexus-container').popWindow({width: 1000,height: 400,close:'X'});
 * width:弹窗的宽度
 * height:弹窗的高度
 * close:关闭按钮中显示的内容
 * 
 * */
(function($) {
	$.fn.popWindow = function(option) {
		var self = $(this[0]),
			selfHidden = self.is(':hidden'),
			wd = $(window),
			width = wd.width(),
			height = wd.height() - 20,
			defaults = {
				close: 'X',
				width: self.width(),
				height: height,
				speed: 200
			},
			opts = $.extend(true, defaults, option),
			// 最外层遮罩
			container = $('.pop-container'),
			// 关闭按钮
			closeBtn = $('.pop-close'),
			// 窗口层
			model = $('.pop-model'),
			//
			closeSelf = function() {
				container.fadeOut();
				model.fadeOut();
				// 内容移回原位
				if (selfHidden) {
					self.hide();
				}
				// 将占位符替换
				$('.pop-self-position').replaceWith(self);
			};

		// 最外层遮罩
		if (!container.length) {
			container = $('<div class="pop-container" style="position:fixed;top:0;right:0;bottom:0;left:0;background:#000000;opacity:0.7;z-index:90000;display:none;"></div>').appendTo($('body'));
			container.click(function() {
				closeSelf();
			});
		}
		// 弹窗
		if (!model.length) {
			model = $('<div class="pop-model" style="position:fixed;top:0;right:0;bottom:0;left:0;width:0;height:0;background:#ffffff;z-index:90001;overflow:hidden;margin:auto;display:none;"><div class="pop-body"></div></div>').appendTo($('body'));
		} else if (model.is(':hidden')) {
			model.css({
				height: 0,
				width: 0
			});
		}
		// 关闭按钮
		if (opts.close && !closeBtn.length) {
			closeBtn = $('<div class="pop-close" title="关闭" style="position:absolute;top:0;right:0;width:25px;height:25px;line-height:25px;text-align:center;z-index:99000;cursor:pointer;"></div>').appendTo(model);
			closeBtn.html(opts.close).click(function() {
				closeSelf();
			}).hover(
				function() {
					$(this).css({
						background: 'rgba(204,51,51,1)',
						color: '#fff'
					});
				},
				function() {
					$(this).css({
						color: '#999',
						background: 'rgba(204,51,51,0)'
					});
				}
			);
		}
		// 记录占位
		var _tagName = self[0].tagName.toLowerCase();
		self.before('<' + _tagName + ' class="pop-self-position" style="display:none;"></' + _tagName + '>')
			// 写入内容，并中心向外展开
		model.show().animate({
			height: opts.height,
			width: opts.width
		}, opts.speed).children('.pop-body').empty().append(self.show());

		if (container.is(':hidden')) {
			container.fadeIn(opts.speed);
		}
		//
		this.close = function() {
			closeSelf();
		};
		return this;
	};
})(jQuery);


//全局变量
//
snow = snow || {};
// 缺省的透明图片
snow.default_img = '/static/img/png.png';

snow.confirm = function(msg) {
	return confirm(msg);
};

snow.alert = function(msg) {
	alert(msg);
}

snow.refresh = function(){
	window.location = window.location;
}

snow.go = function(u){
	window.location = u;
}

// 页脚自适应沉底，页眉自适应浮动
snow.footerBottom = function(){
//	// 页脚
//	var _footer_0 = $('#footer_0'),
//		_footer = $('#footer');
//	_footer.addClass('navbar-fixed-bottom');
//	if (_footer_0.offset().top > _footer.offset().top) {
//		_footer.removeClass('navbar-fixed-bottom');
//	}
	var _footer = $('#footer');
	var _footer_padding = $('#footer-padding');
	_footer_padding.css('paddingBottom',_footer.outerHeight());
	
	if($(document).height() > $(window).height()){
		$('body').css('position','relative');
	}else{
		$('body').css('position','initial');
	}
};

function getBasicName(type,value){
	var _name='';
	$.each(snow.basic,function(i,item){
		if(item.type==type && item.value==value){
			_name = item.name;
			return false;
		}
	});
	return _name;
}

function submit_disable(obj) {
	$('.btn[type="submit"]', obj).attr('disabled', true).prepend('<i class="fa fa-spinner fa-spin"></i> ');
}

function submit_enable(obj) {
	$('.btn[type="submit"]', obj).attr('disabled', false).find('i').remove();
}

function showMessage(obj, msg, success) {
	if (success) {
		obj.removeClass('alert-danger').addClass('alert-success').stop().fadeIn().html('<i class="fa fa-smile-o"></i> ,' + msg);
	} else {
		obj.removeClass('alert-success').addClass('alert-danger').stop().fadeIn().html('<i class="fa fa-frown-o"></i> ,' + msg);
	}
	setTimeout(function() {
		obj.stop().fadeOut(600);
	}, 5000)
}


//分页 index从1开始
function showPages(count,index,size){
	var pageHtml = [];

	if (count > 0) {
        //页码按钮数
        var buttons = 5;
        var start = 1;
        if (index >= buttons)
        {
            if (count - index > buttons)
            {
                start = index - 2;
            }
            else if (count - index < buttons)
            {
                start = count - buttons;
            }
            else if (count - index == buttons)
            {
                start = count - buttons - 1;
            }
        }
        if (index > 1)
        {
            pageHtml.push('<li data-id="1" title="首页"><a href="javascript:;">|<</a></li>');
            pageHtml.push('<li data-id="'+(index - 1)+'" title="上一页"><a href="javascript:;"><</a></li>');
        }
        else
        {
            pageHtml.push('<li disabled="disabled" data-id="0" title="首页"><a href="javascript:;">|<</a></li>');
            pageHtml.push('<li disabled="disabled" data-id="0" title="上一页"><a href="javascript:;"><</a></li>');
        }

		for( var i = start; i < count + 1; i++ ){ 
			if (i - start > 5)
            {
                break;
            }
            if ((count > buttons) && (index >= buttons && i == start) || (index <= count - buttons && i == start + buttons))
            {
            	pageHtml.push('<li class="pagemore" data-id="' + i + '"><a href="javascript:;" >...</a></li>');
            }
            else
            {
            	if(i==index){
            		pageHtml.push('<li class="active" disabled="disabled" data-id="' + i + '"><a href="javascript:;">' + i + '</a></li>');
            	}else{
            		pageHtml.push('<li data-id="' + i + '"><a href="javascript:;">' + i + '</a></li>');
            	}
            }
			
		}

		if (index < count)
        {
            pageHtml.push('<li data-id="'+(index + 1)+'" title="下一页"><a href="javascript:;">></a></li>');
            pageHtml.push('<li title="末页" data-id="'+count+'"><a href="javascript:;">>|</a></li>');
        }
        else
        {
            pageHtml.push('<li disabled="disabled" title="下一页" data-id="0"><a href="javascript:;">></a></li>');
            pageHtml.push('<li disabled="disabled" title="末页" data-id="0"><a href="javascript:;">>|</a></li>');
        }
	}
	return pageHtml.join('');
}

$(function(){
	(function($) {
		var speed = 5000,
			count = $('.slideshow li').length,
			index = 1;
		var slidetimes;

		function start(index) {
			$('.slideshow .banner-nav span').eq(index).addClass('current').siblings().removeClass('current');
			$('.slideshow li').eq(index).fadeIn('slow').siblings('li').fadeOut('slow');
		};

		function slideshow() {
			slidetimes = setInterval(function() {
			
				if (index == count) {
					index = 0;
				}
				start(index);
				index++;
			}, speed);
		};
		$('.slideshow li').hover(function() {
			clearInterval(slidetimes);
		}, function() {
			slideshow();
		});
		$('.slideshow .banner-nav span').click(function() {
			start($(this).index());
		});
		//
		if(count > 1){
			slideshow();
			$('.slideshow .banner-nav span').show();
		}else{
			$('.slideshow .banner-nav span').hide();
		}
	})(jQuery);
});

$(function(){
	$('img').each(function(){
		if(this.complete && !this.naturalWidth){
			this.src = snow.default_img;
		}
	});
});
