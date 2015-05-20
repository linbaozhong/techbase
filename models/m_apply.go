package models

type Apply struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Bpath     string `json:"bpath" valid:"MaxSize(250)"` //BP文件路径
	Agree     int    `json:"agree"`                      //同意合同条款
	Accept    int    `json:"accept"`                     //接受法律服务
	State     int    `json:"state"`                      //融资状态 0-未申请，1-已申请，2-融资中，3-融资成功，4-融资失败
	Status    int    `json:"status"`                     //锁定
	Deleted   int    `json:"deleted"`                    //删除
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

func (this *Apply) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Where("id=? and companyId=?", this.Id, this.CompanyId).Update(this)
	}
	return err, nil

}
