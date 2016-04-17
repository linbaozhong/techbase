<style type="text/css">
	#footer_0{
		background-color: #eee;
	}
    section{
        padding: 2em 2em 4em !important;
    }
    section:nth-child(2n){
        background-color:#eee;
    }
    section .snow-icon{
    	width:50px;height:50px;
    	margin:3em 2em 3em 0;
    	display:inline-block;
    }
    section h3{
    	margin:0;
    	display:inline-block;vertical-align:middle;
    }
    section .snow-ul ul{
    	list-style: initial;
    	margin-top: 132px;
    	margin-left:20px;
    }
    .snow-ul li span:nth-child(1){
    	width:10em;
    	display: inline-block;
    }
    section .snow-ul-notop ul{
    	margin-top:2px;
    }
    section .snow-content{
    	padding-right:3em;
    	text-align:justify;
    }
    section .snow-content-right{
    	padding-left:3em;
    	text-align:justify;
    }
    section dd{
    	margin-bottom:1em;
    }
</style>
<section class="container">
	<div class="col-md-6 snow-content">
        <div>
        <img class="snow-icon" src="/html/images/zhongzi.png" alt="{{i18n .Lang "fa service"}}">
        <h3>{{i18n .Lang "fa service"}}</h3>
        </div>
        <div>
        	{{i18n .Lang "fa service 0"}}
        </div>
    </div>
    <div class="col-md-6 snow-content-right">
        <div>
            <h3 style="margin: 54px auto 52px;">{{i18n .Lang "case"}}</h3>
        </div>
        <div class="snow-ul snow-ul-notop">
        	{{i18n .Lang "case 0" | str2html}}
        </div>
    </div>
</section>
<section class="container">
	<div class="col-md-6 snow-content">
        <div>
        <img class="snow-icon" src="/html/images/ruzhu.png" alt="{{i18n .Lang "site services"}}">
        <h3>{{i18n .Lang "site services"}}</h3>
        </div>
        <div>
        	{{i18n .Lang "site services 0" | str2html}}
        </div>
    </div>
    <div class="col-md-6 snow-content-right">
    	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="margin-top:134px;">
		      <ol class="carousel-indicators">
		        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		        <li data-target="#carousel-example-generic" data-slide-to="1" class=""></li>
		        <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
		        <li data-target="#carousel-example-generic" data-slide-to="3" class=""></li>
		        <li data-target="#carousel-example-generic" data-slide-to="4" class=""></li>
		        <li data-target="#carousel-example-generic" data-slide-to="5" class=""></li>
		      </ol>
		      <div class="carousel-inner" role="listbox">
		        <div class="item active">
		          <img alt="Techbase她本营" src="/html/images/site/1.jpg" data-holder-rendered="true">
		        </div>
		        <div class="item">
		          <img alt="Techbase她本营" src="/html/images/site/2.jpg" data-holder-rendered="true">
		        </div>
		        <div class="item">
		          <img alt="Techbase她本营" src="/html/images/site/3.jpg" data-holder-rendered="true">
		        </div>
		        <div class="item">
		          <img alt="Techbase她本营" src="/html/images/site/4.jpg" data-holder-rendered="true">
		        </div>
		        <div class="item">
		          <img alt="Techbase她本营" src="/html/images/site/5.jpg" data-holder-rendered="true">
		        </div>
		        <div class="item">
		          <img alt="Techbase她本营" src="/html/images/site/6.jpg" data-holder-rendered="true">
		        </div>
		      </div>
		      <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
		        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		        <span class="sr-only">Previous</span>
		      </a>
		      <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
		        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		        <span class="sr-only">Next</span>
		      </a>
    	</div>
    </div>
</section>
<section class="container">
	<div class="col-md-6 snow-content">
        <div>
        <img class="snow-icon" src="/html/images/zixun.png" alt="{{i18n .Lang "integrated"}}">
        <h3>{{i18n .Lang "integrated" | str2html}}</h3>
        </div>
        <div>
        	{{i18n .Lang "integrated 0" | str2html}}
        </div>
    </div>
    <div class="col-md-6 snow-content-right snow-ul">
        	{{i18n .Lang "integrated 1" | str2html}}
    </div>
</section>
<section class="container">
	<div class="col-md-12">
        <div>
        <img class="snow-icon" src="/html/images/renli.png" alt="{{i18n .Lang "fw biaoti"}}">
        <h3>{{i18n .Lang "fw biaoti"}}</h3>
        </div>
        <dl>
        	<dt>{{i18n .Lang "fw 0"}}</dt>
        	<dd>{{i18n .Lang "fw a"}}</dd>
        	<dt>{{i18n .Lang "fw 1"}}</dt>
        	<dd>{{i18n .Lang "fw b"}}</dd>
        	<dt>{{i18n .Lang "fw 3"}}</dt>
        	<dd>{{i18n .Lang "fw d"}}</dd>
        	<dt>{{i18n .Lang "fw 4"}}</dt>
        	<dd>{{i18n .Lang "fw e"}}</dd>
        </dl>
    </div>
</section>

<section class="container">
	<div class="col-md-4">
        <h4>{{i18n .Lang "service 1"}}</h4>
        <h6>{{i18n .Lang "service 2"}}</h6>
        <img src="/static/img/yao-qrcode.jpg" alt="Techbase她本营" style="margin-top:12px;">
    </div>
    <div class="col-md-4">
        <h4>{{i18n .Lang "service 3"}}</h4>
        <h6>{{i18n .Lang "service 4" | str2html}}</h6>
        <img src="/static/img/weixin-qr-140.png" alt="Techbase她本营">
    </div>
    <div class="col-md-4">
        <h4>{{i18n .Lang "service 5"}}</h4>
        <h6>{{i18n .Lang "service 6"}}：techbase@tabenying.com</h6>
        <h4 style="margin-top:3em;">{{i18n .Lang "service 7"}}</h4>
        <h6>{{i18n .Lang "service 8" | str2html}}</h6>
    </div>
</section>
<script src="/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
	});
</script>