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

snow = snow || {};

	snow.confirm = function(msg) {
		return confirm(msg);
	};

	snow.alert = function(msg) {
		alert(msg);
	}

	function submit_disable(obj) {
		$('.btn[type="submit"]', obj).attr('disabled', true).prepend('<i class="fa fa-spinner fa-spin"></i> ');
	}

	function submit_enable(obj) {
		$('.btn[type="submit"]', obj).attr('disabled', false).find('i').remove();
	}

	function showMessage(obj, msg, success) {
		if (success) {
			obj.removeClass('alert-danger').addClass('alert-success').slideDown().html('<i class="fa fa-smile-o"></i> ,' + msg);
		} else {
			obj.removeClass('alert-success').addClass('alert-danger').slideDown().html('<i class="fa fa-frown-o"></i> ,' + msg);
		}
		setTimeout(function() {
			obj.slideUp(600);
		}, 5000)
	}

snow.refresh = function(){
	window.location = window.location;
}
