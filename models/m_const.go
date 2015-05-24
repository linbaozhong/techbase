package models

const (
	Role_System        = 0 //超级管理员
	Role_Administrator = 1 //网站管理员
	Role_Auditor       = 2 //内容审核人
	Role_Author        = 3 //作者
	Role_Reader        = 4 //读者
	Role_Guest         = 5 //游客

	Open_Alipay = 0 //支付宝用户
	Open_QQ     = 1 //qq用户
	Open_Weibo  = 2 //微博用户

	Private  = 0 //私有的
	Internal = 1 //内部的
	Public   = 2 //公开的
	Free     = 3 //自由的

	Undelete = 0 //未删除
	Deleted  = 1 //删除

	Unlock = 0 //未锁定
	Locked = 1 //锁定

	Type_Country  = 0 //国家
	Type_Province = 1 //省市
	Type_City     = 2 //城市
	Type_Field    = 3 //领域
	Type_State    = 4 //运营状态
	Type_Place    = 5 //职位
	Type_Loop     = 6 //融资轮次
	Type_Money    = 7 //货币种类
	Type_Media    = 8 //媒体栏目标签

	Audit_Normal = 0  //未审核
	Audit_No     = -1 //未通过
	Audit_Ing    = 1  //审核中
	Audit_Yes    = 2  //通过
)
