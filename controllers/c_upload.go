package controllers

import (
	"zouzhe/utils"
)

type Upload struct {
	Auth
}

func (this *Upload) Post() {
	fs, err := this.upload("file")

	if err == nil {
		this.renderJson(utils.JsonData(true, "", fs))
	} else {
		this.renderJson(utils.JsonData(false, "", err))
	}
}
