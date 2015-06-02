package models

import (
	"fmt"
)

type SnsArticle struct {
	Id        int64  `json:"id"`
	AccountId int64  `json:"accountId"`
	SessionId string `json:"sessionId"`
	ArticleId int64  `json:"articleId"`
	Readed    int    `json:"readed"`
	Loved     int    `json:"loved"`
	Weixin    int    `json:"weixin"`
}

// 读过
func (this *SnsArticle) SetReaded() bool {
	//.Where("(accountId=? or sessionId=?) and articleId=?", this.AccountId, this.SessionId, this.ArticleId)
	ok, _ := db.Get(this)
	// 如果存在痕迹
	if ok {
		if this.Readed != 1 {
			this.Readed = 1
			db.Id(this.Id).Cols("readed").Update(this)
			return true
		}
		return false
	} else {
		this.Readed = 1
		n, _ := db.Insert(this)
		return n > 0
	}
}

// 喜欢
func (this *SnsArticle) SetLoved() bool {
	//.Where("(accountId=? or sessionId=?) and articleId=?", this.AccountId, this.SessionId, this.ArticleId)
	ok, _ := db.Get(this)
	// 如果存在痕迹
	if ok {
		if this.Loved == 1 {
			this.Loved = 0
		} else {
			this.Loved = 1
		}

		fmt.Println(this)
		db.Id(this.Id).Cols("loved").Update(this)
		return true
	} else {
		this.Loved = 1
		n, _ := db.Insert(this)
		return n > 0
	}
}

// weixin分享
func (this *SnsArticle) SetWeixin() bool {
	//.Where("(accountId=? or sessionId=?) and articleId=?", this.AccountId, this.SessionId, this.ArticleId)
	ok, _ := db.Get(this)
	// 如果存在痕迹
	if ok {
		if this.Weixin != 1 {
			this.Weixin = 1
			db.Id(this.Id).Update(this)
			return true
		}
		return false
	} else {
		this.Weixin = 1
		n, _ := db.Insert(this)
		return n > 0
	}
}
func (this *SnsArticle) GetSNS() (bool, error) {
	return db.Get(this)
}

/////////////////////////////////////
type SnsProject struct {
	Id        int64
	AccountId int64
	SessionId string
	ProjectId int64
	Readed    int
	Loved     int
	Weixin    int
}

// 读过
func (this *SnsProject) SetReaded() bool {
	//.Where("(accountId=? or sessionId=?) and ProjectId=?", this.AccountId, this.SessionId, this.ProjectId)
	ok, _ := db.Get(this)
	// 如果存在痕迹
	if ok {
		if this.Readed != 1 {
			this.Readed = 1
			db.Update(this)
			return true
		}
		return false
	} else {
		this.Readed = 1
		n, _ := db.Insert(this)
		return n > 0
	}
}
