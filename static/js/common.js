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
		var self = this.eq(0),
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
			// 边距
			marginX = (width - opts.width) / 2,
			marginY = (height - opts.height) / 2,
			//
			closeSelf = function(){
				var _obj = model.children().eq(0);
				container.fadeOut();
				closeBtn.fadeOut();
				model.fadeOut();
				// 内容移回原位
				if (selfHidden) {
					_obj.hide();
				}
				// 将占位符替换
				$('.pop-self-position').replaceWith(_obj);
			};
		// 窗口大小变化	
		wd.resize(function() {
			marginX = (wd.width() - opts.width) / 2;
			marginY = (wd.height() - opts.height) / 2;
			model.css({
				height: opts.height,
				width: opts.width,
				left: marginX > 0 ? marginX : 0,
				top: marginY > 0 ? marginY : 0,
				right: 'auto',
				bottom: 'auto'
			});
			// 考虑滚动条的宽度
			if (self.outerHeight() > opts.height) {
				closeBtn.css({
					right: marginX ,//+ 20,
					top: marginY
				});
			} else {
				closeBtn.css({
					right: marginX,
					top: marginY
				});
			}
		});
		// 最外层遮罩
		if (!container.length) {
			container = $('<div class="pop-container" style="position:fixed;top:0;right:0;bottom:0;left:0;background:#000000;opacity:0.7;z-index:90000;display:none;"></div>').appendTo($('body'));
			container.click(function() {
				closeSelf();
			});
		}
		// 关闭按钮
		if (opts.close && !closeBtn.length) {
			closeBtn = $('<div class="pop-close" title="关闭" style="position:fixed;top:' + marginY + 'px;right:' + marginX + 'px;width:25px;height:25px;line-height:25px;text-align:center;z-index:99000;cursor:pointer;display:none;"></div>').appendTo($('body'));
			closeBtn.html(opts.close).click(function() {
				closeSelf();
			}).hover(
				function() {
					$(this).css({
						background:'rgba(204,51,51,1)',
						color:'#fff'
						});
				},
				function() {
					$(this).css({
						color:'#999',
						background:'rgba(204,51,51,0)'
						});
				}
			);
		}
		// 弹窗
		if (!model.length) {
			model = $('<div class="pop-model" style="position:fixed;top:' + (height / 2) + 'px;right:' + (width / 2) + 'px;bottom:' + (height / 2) + 'px;left:' + (width / 2) + 'px;background:#ffffff;z-index:90001;overflow-x:hidden;overflow-y:hidden;display:none;"></div>').appendTo($('body'));
		} else if (model.is(':hidden')) {
			model.css({
				top: height / 2,
				bottom: height / 2,
				left: width / 2,
				right: width / 2,
				height: 'auto',
				width: 'auto'
			});
		}
		// 记录占位
		var _tagName = self[0].tagName.toLowerCase();
		self.before('<' + _tagName + ' class="pop-self-position" style="display:none;"></' + _tagName + '>')
			// 写入内容，并中心向外展开
		model.empty().append(self.show()).show().animate({
			top: marginY,
			bottom: marginY,
			left: marginX,
			right: marginX
		}, opts.speed, function() {
			wd.resize();
			closeBtn.fadeIn();
		});
		if (container.is(':hidden')) {
			container.fadeIn(opts.speed);
		}
		//
		this.close = function(){
			closeSelf();
		};
		return this;
	};
})(jQuery);