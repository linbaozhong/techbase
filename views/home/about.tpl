<style type="text/css">
    section:nth-child(2n) {
        background-color: #eee;
    }
    
    section>div {
        width: 942px;
        height: 350px;
        display: table-cell;
        text-align: center;
        vertical-align: middle;
    }
    
    section p {
        text-align: center;
        line-height: 2em;
    }
    
    section ul li {
        width: 90px;
        display: inline-block;
        margin: 0 8px;
        vertical-align: top;
    }
    
    section li img {
        width: 70px;
    }
    
    section li .title {
        margin: 10px 0;
        text-align: center;
        /*font-size: 1.2em;*/
        font-weight: 700;
    }
    
    section .shuo {
        position: absolute;
        left: 0;
        right: 0;
        margin: 0 auto;
        display: none;
        width: 800px;
    }
    
    .snow-chengjiu label {
        font-size: 40px;
        font-weight: normal;
    }
</style>

<section class="container">
    <div style="vertical-align: top;padding-top: 25px;">
        <h1>{{i18n .Lang "yj biaoti"}}</h1>
        <p style="margin-top: 20px;">
            {{i18n .Lang "yj neirong" | str2html }}
        </p>
        <ul style="margin-top: 30px;">
            <li class="shuo" style="display: block;">
                <div class="title">
                    {{i18n .Lang "shuo 1"}}
                </div>
                <div>@{{i18n .Lang "who 1"}}</div>
            </li>
            <li class="shuo">
                <div class="title">
                    {{i18n .Lang "shuo 2"}}
                </div>
                <div>@{{i18n .Lang "who 2"}}</div>
            </li>
            <li class="shuo">
                <div class="title">
                    {{i18n .Lang "shuo 3"}}
                </div>
                <div>@{{i18n .Lang "who 3"}}</div>
            </li>
        </ul>
    </div>
</section>
<section class="container">
    <div style="padding-top:25px;">
        <h1>{{i18n .Lang "youshi"}}</h1>
        <p style="margin-top:20px;">{{i18n .Lang "youshi 1"}}
            <br /> {{i18n .Lang "youshi 2"}}
            <br /> {{i18n .Lang "youshi 3"}}
            <br /> {{i18n .Lang "youshi 4"}}
            <br /> {{i18n .Lang "youshi 5"}}
        </p>
    </div>
</section>
<section class="container">
    <div style="padding-top:25px;">
        <h1>{{i18n .Lang "chengjiu"}}</h1>
        <ul class="row snow-chengjiu" style="margin-top:50px;">
            <li class="col-md-offset-1 col-md-2 inc-10" data-min="1" data-max="14">
                {{i18n .Lang "chengjiu 1" | str2html}}
            </li>
            <li class="col-md-2 inc-100" data-min="1" data-max="116">
                {{i18n .Lang "chengjiu 2" | str2html}}
            </li>
            <li class="col-md-2 inc-10" data-min="1" data-max="45">
                {{i18n .Lang "chengjiu 3" | str2html}}
            </li>
            <li class="col-md-2 inc-400" data-min="1" data-max="400">
                {{i18n .Lang "chengjiu 4" | str2html}}
            </li>
            <li class="col-md-2 inc-10" data-min="1" data-max="20">
                {{i18n .Lang "chengjiu 5" | str2html}}
            </li>
        </ul>
    </div>
</section>

<script type="text/javascript">
    $(function() {
		var shuo = $('li.shuo');
		
		function slideshow(){
			
			var index = $('li.shuo:visible').index();
			var next = index+1;
			
			if (next == shuo.length) next = 0;
			
			shuo.eq(next).fadeIn();
			shuo.eq(index).fadeOut();
		};
		
		setInterval(slideshow,5000);
        
        // 滚动动画
        var _win = $(window),
            _chengjiu = $('section .snow-chengjiu');
            
        _win.on('scroll.a',function(){
            if(_chengjiu.offset().top + _chengjiu.height() < _win.height() + _win.scrollTop()){
                _win.off('scroll.a');
                
                var _interval = [];
                var _loop = function(obj,index){
                    var _min = parseInt(obj.data('min')),
                        _max = parseInt(obj.data('max'));
                    
                    if(_min <= _max){
                        obj.data('min',_min+1).find('label:eq(0)').text(_min);
                    }else{
                        // console.log(index);
                        clearInterval(_interval[index]);
                    }
                };
                
                // 数字轮换
                $.each(_chengjiu.find('li'),function(index){
                    var _this = $(this),_inter = 0;
                    if(_this.hasClass('inc-400')){
                    	_inter = 10;
                    }else if(_this.hasClass('inc-100')){
                    	_inter = 30;
                    }else{
                    	_inter = 80;
                    }
                    _interval.push(setInterval(_loop,_inter,_this,index));
                });
            }
        });
	});

</script>