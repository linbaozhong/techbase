package main

import (
	"github.com/astaxie/beego"
	"github.com/beego/i18n"
	"os"
	"strings"
	_ "techbase/routers"
	"techbase/utils"
	"time"
)

const (
	APP_VER = "1.1.14.1105"
)

func main() {
	beego.Info(beego.AppName, APP_VER)
	beego.Run()

}

func init() {
	//beego.SetLevel(beego.LevelInformational)
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
