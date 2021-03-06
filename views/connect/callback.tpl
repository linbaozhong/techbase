<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<script src="/static/js/device.min.js"></script>
		<script type="text/javascript" src="../../static/js/jquery-2.1.4.min.js."></script>
		<script type="text/javascript">
			
			$(function() {
				(function open_login(u) {
					//console.log(u);
					
					if(u){
						//记录登录状态
						$.post('/connect/signtrace', {
							from: u.From,
							token: u.Token,
							openId: u.OpenId,
							unionId:u.UnionId,
							nickName: u.NickName,
							gender: u.Gender,
							refresh: u.Refresh,
							avatar_1: u.Avatar_1,
							avatar_2: u.Avatar_2
						}, function(d) {
							if (d.ok) {
								//
								if(device.mobile()){
									//window.opener.open_login({{.sign}});
								 	window.opener = null;
									window.open('','_self','');//for IE7
									window.close(); 
								}else{
									var returnUrl = '{{.return_uri}}';
									if(returnUrl.indexOf('/home/error') > 0){
										window.location = '/'
									}else{
										window.location = returnUrl;
									}
								}

							}else{
								alert('服务器出现故障……');
								window.location = '{{.return_uri}}';
							}
						});
					}
				})({{.sign}});
			});
		</script>
	</head>

	<body></body>

</html>