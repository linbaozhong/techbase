package models

type Company struct {
	Id        int64  `json:"id"`
	AccountId int64  `json:"accountId"`
	Name      string `json:"name" valid:"Required;MaxSize(50)"`
	Fullname  string `json:"fullname" valid:"MaxSize(250)"`
	Website   string `json:"website" valid:"MaxSize(250)"`
	Logo      string `json:"logo" valid:"MaxSize(250)"`
	Intro     string `json:"intro" valid:"Required;MaxSize(250)"`
	City      int    `json:"city"`
	Country   int    `json:"country"`
	StartTime int64  `json:"startTime"`
	State     int    `json:"state" valid:"Required"`
	Status    int    `json:"status"`
	Deleted   int    `json:"deleted"`
	Creator   int64  `json:"creator"`
	Created   int64  `json:"created"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 列表
func (this *Company) List() ([]Company, error) {
	cs := make([]Company, 0)

	err := db.Where("AccountId=? and deleted=?", this.AccountId, Undelete).Find(&cs)

	return cs, err
}

// 保存
func (this *Company) Save() (int64, error) {
	if this.Id == 0 {
		return db.Insert(this)
	} else {
		return db.Id(this.Id).Update(this)
	}
}
