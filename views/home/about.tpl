<section class="container" style="margin-top:75px;">
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
        <h1>我们的优势</h1>
        <p style="margin-top:20px;">北京市妇联战略合作伙伴
            <br /> 链接国内外顶尖战略资源
            <br /> 聚合国内优质女性项目与投资者
            <br /> 提供精细化的专业创业服务
            <br /> 转为女性设计的联合办公室
        </p>
    </div>
</section>
<section class="container">
    <div style="padding-top:25px;">
        <h1>我们的成就</h1>
        <ul class="row snow-chengjiu" style="margin-top:50px;">
            <li class="col-md-offset-1 col-md-2" data-min="1" data-max="14">
                <h5>孵化了</h5>
                <label>1</label><span>个</span>
                <h5>项目</h5>
            </li>
            <li class="col-md-2" data-min="1" data-max="116">
                <h5>采访了</h5>
                <label>1</label><span>位</span>
                <h5>人物</h5>
            </li>
            <li class="col-md-2" data-min="1" data-max="45">
                <h5>举办了</h5>
                <label>1</label><span>场</span>
                <h5>线上、线下活动</h5>

            </li>
            <li class="col-md-2" data-min="1" data-max="400">
                <h5>链接了</h5>
                <label>1</label>
                <label style="margin-left:-10px;">+</label><span>位</span>
                <h5>女性创业者</h5>

            </li>
            <li class="col-md-2" data-min="1" data-max="20">
                <h5>接受了</h5>
                <label>1</label>
                <label style="margin-left:-10px;">+</label><span>家</span>
                <h5>国内外媒体报道</h5>

            </li>
        </ul>
    </div>
</section>

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
                
                
                $.each(_chengjiu.find('li'),function(index){
                    var _this = $(this);
                        
                    _interval.push(setInterval(_loop,20,_this,index));
                });
            }
        });
	});

</script>