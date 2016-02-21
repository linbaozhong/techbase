package main

import (
	"html/template"
	"os"
	"strings"
	_ "techbase/routers"
	"techbase/utils"
	"time"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"
)

const (
	version = "0.1.24.1105"
)

func main() {
	beego.Info(beego.AppName, version)
	beego.Run()

}

func init() {
	// 日志级别
	if beego.RunMode == "dev" {
		beego.SetLevel(beego.LevelDebug)
	} else {
		beego.SetLevel(beego.LevelNotice)
	}

	os.Mkdir("./logs", os.ModePerm)
	//日志文件名
	beego.BeeLogger.SetLogger("file", `{"filename": "logs/log.log"}`)

	initStaticPath()
	initTemplateExt()
	initFuncMap()
}

// 初始化模板函数
func initFuncMap() {

	beego.AddFuncMap("i18n", i18n.Tr)
	beego.AddFuncMap("loadtimes", loadtimes)
	beego.AddFuncMap("split", strings.Split)
	beego.AddFuncMap("m2t", utils.Msec2Time)
	beego.AddFuncMap("css", func(s string) template.CSS {
		return template.CSS(s)
	})
}

// 初始化静态目录
func initStaticPath() {
	beego.SetStaticPath("/html", "html")
	beego.SetStaticPath("/upload", beego.AppConfig.String("UploadPhysicalPath")) //"upload"
}

// 初始化模板后缀
func initTemplateExt() {
	//beego.AddTemplateExt(".html")
}

// 引用自beego官网
func loadtimes(t time.Time) int {
	return int(time.Now().Sub(t).Nanoseconds() / 1e6)
}
