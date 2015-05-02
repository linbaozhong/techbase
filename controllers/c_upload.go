package controllers

import (
	"zouzhe/utils"
)

type Upload struct {
	Auth
}

func (this *Upload) Post() {
	fs, err := this.upload("file")
	this.trace(fs, err)
	this.renderJson(utils.JsonData(true, "", fs))
}
