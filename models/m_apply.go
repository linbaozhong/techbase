package models

type Apply struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Bpath     string `json:"bpath" valid:"MaxSize(250)"` //BP文件路径
	Agree     int    `json:"agree"`                      //同意合同条款
	Accept    int    `json:"accept"`                     //接受法律服务
	State     int    `json:"state"`                      //融资状态
	Status    int    `json:"status"`                     //锁定
	Deleted   int    `json:"deleted"`                    //删除
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}
