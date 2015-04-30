/*
*	基础数据
 */
package models

type Basic struct {
	Id       int64  `json:"id"`
	ParentId int64  `json:"parentId"`
	Type     int    `json:"type"`
	Name     string `json:"name"`
	Value    int    `json:"value"`
	Status   int    `json:"status"`
	Deleted  int    `json:"deleted"`
	Updator  int64  `json:"updator"`
	Updated  int64  `json:"updated"`
	Ip       string `json:"ip"`
}

// 列表
func (this *Basic) List() ([]Basic, error) {
	bs := make([]Basic, 0)

	err := db.Where("parentid=? and type=? and deleted=?", this.ParentId, this.Type, Undelete).Find(&bs)

	return bs, err
}

func (this *Basic) Save() (int64, error) {
	if this.Id == 0 {
		return db.Insert(this)
	} else {
		return db.Id(this.Id).Update(this)
	}
}

func (this *Basic) MaxValue() (bool, error) {
	return db.Where("type=? and parentid=? and deleted=?", this.Type, this.ParentId, Undelete).Limit(1).Desc("value").Get(this)
}
