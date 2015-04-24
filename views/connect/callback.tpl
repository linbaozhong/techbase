<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.3/jquery.min.js"></script>
		<script type="text/javascript">
			
			$(function() {
				(function open_login(u) {
					console.log(u);	
					if(u){
						//记录登录状态
						$.post('/connect/signtrace', {
							from: u.From,
							token: u.Token,
							openId: u.OpenId,
							nickName: u.NickName,
							gender: u.Gender,
							refresh: u.Refresh,
							avatar_1: u.Avatar_1,
							avatar_2: u.Avatar_2
						}, function(d) {
							if (d.ok) {
								window.location = '{{.return_uri}}';
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