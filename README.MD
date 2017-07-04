## `BFramework_swift`

>
通用UI配置，通用工具类
>
空余时间完善中....

- `Tags`：0.1

### `UIConfig`

#### `1、主体颜色配置使用`
- `MQTintColorConfig.plist`

>
![colorConfig](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/colorConfig.png)


- `使用:`

```
self.view.backgroundColor = UIColor.mq_backgroundColor
UIColor.mq_tintColor
UIColor.mq_borderColor
```

- `...`

#### `2、字体字号配置使用`
- `MQFontConfig.plist`

>
![fontConfig](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/fontConfig.png)

- `使用:`

```
颜色：
UIColor.mq_textColorTitle
UIColor.mq_textColorBody	
UIColor.mq_textColorMark

字体:
self.lbTitle.font   = UIFont.mq_titleFont (mq_bodyFont,mq_markFont)
self.lbTitle.font	= UIFont.mq_titleFont(20)

iconfont:
self.lbIconFont.font    = UIFont.mq_iconFont(30)
self.lbIconFont.text    = "IconFont,\u{e616}"

字号：
UIFont.mq_titleFontSize
```

- `...`

- `颜色、字体效果图`


|FIG1|
|--------|
|![fig1](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/fig1.png)|


- [iconfont配置](http://www.iconfont.cn/plus/help/detail?helptype=code&spm=a313x.7781069.1998910419.14.1Nl48b)

#### `3、NavigationBar配置使用`
- `MQNavBarConfig.plist`

>
![fontConfig](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/navbarConfig.png)

- `启用配置:`

```
AppDelegate:
MQStructs.loadnavBarConfig()
```

##### `扩展(设置navbar 左右两侧按钮):`

- `来自iconfont`

```
self.mq_navbarAddBarButtonItems(iconFontTexts: ["\u{e612}","\u{e613}"], fontSize: 30, color: UIColor.orange, at: .left)
```

- `来自纯文本`

```
self.mq_navbarAddBarButtonItems(textNames: ["Call"], font: nil, color: UIColor.white, at: .right)
```

- `来自图片`

```
self.mq_navbarAddBarButtonItems(imageNames: ["r1","r2"], useOriginalColor: true, at: .right)
```

- `自定义视图`

```
self.mq_navbarAddBarButtonItem(customView: view, at: .right)
```

- `事件`

```
override func mq_leftBarButtonAction(index: Int) {
	print("Left Action At Index:\(index)")
}

override func mq_rightBarButtonAction(index: Int) {
	print("Right Action At Index:\(index)")
}
    
```

- `修改颜色`

```
self.mq_setnavbarBackgroundColor(UIColor(red: r, green: g, blue: b, alpha: 1.0))
```

- `...`

- `NavBar 效果图`

|NAV1|NAV2|
|--------|--------|
|![nav1](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/nav1.png)|![nav2](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/nav2.png)|

|NAV3|NAV4|
|--------|--------|
|![nav3](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/nav3.png)|![nav4](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/nav4.png)|


#### `4、Tabbar配置使用`
- `MQNavBarConfig.plist`

>
![fontConfig](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/tabbarConfig.png)

- `启用配置:`

```
AppDelegate:
MQStructs.loadtabBarConfig()
```

##### `扩展(添加controller)`

```
1.按钮从plist文件读取:
tabBar?.mq_addChildViewController(demoVC, fromPlistItemIndex: 0)
```

```
2.代码配置
let itemInfo                = MQTabbarItem()
//Item 标题
itemInfo.title              = "不一样"
//未选中图片
itemInfo.normalImage        = "tabbarIcon4-normal"
//选中图片
itemInfo.selectedImage      = "tabbarIcon4-selected" 
//点击tabbar按钮是否present出来
itemInfo.showAsPresent      = false
//是否嵌入一层navigationcontroller
itemInfo.embedInNavigation  = true
tabBar?.mq_addChildViewController(MQHHViewController(), fromItem: itemInfo)
```

```
3.系统方法
tabBar?.addChildViewController(vc)
```

- `修改颜色`

```
self.mq_settabbarBackgroundColor(UIColor.clear)
```

`注`

>
如果 showAsPresent = true ，必须实现代理方法

>
	tabBar.delegate = self
	extension AppDelegate: UITabBarControllerDelegate {
	    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
	        return UITabBarController.mq_tabBarController(tabBarController,shouldSelectViewController:viewController)
	    }
	}

- `TabBar 效果图`

|有颜色|
|----|
|![tab1](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/tabbar1.png)|

|无颜色|
|----|
|![tab1](https://github.com/AidyBao/BFramework_swift/raw/master/imgs/tabbar2.png)|

- `...`


### `CommonUtils`

- `MQImagePickerUtils`

```
//相册取
imagePicker.choosePhoto(presentFrom: self) {[unowned self] (image, status) in
    if status == .success {
        self.imgView.image = image
    }else{
        if status == .denied {
            MQImagePickerUtils.showTips(at: self, type: .choosePhoto)
        }else{
            MQAlertUtils.showAlert(withTitle: "提示", message: status.description())
        }
    }
}
//拍照
imagePicker.takePhoto(presentFrom: self) { [unowned self] (image, status) in
    if status == .success {
        self.imgView.image = image
    }else{
        if status == .denied {
            MQImagePickerUtils.showTips(at: self, type: .takePhoto)
        }else {
            MQAlertUtils.showAlert(withTitle: "提示", message: status.description())
        }
    }
}
        
```

- `MQAlertUtils`

```
MQAlertUtils.showAlert(withTitle: "提示", message: errorMsg!)
```

- `MQLocationUtils`

```
MQLocationUtils.shareInstance.checkCurrentLocation(completion: { (status, location) in
    if status == .success,let location = location {
        print("latitude:\(location.coordinate.latitude),longitude:\(location.coordinate.longitude)")
    }else{
        print(status.description())
    }
})
```

- `MQDateUtils`

```
MQDateUtils.currentDateTime(true, timeWithSecond: true)//2017年04月19日 12:01:57
MQDateUtils.currentDate(true)//2017年04月19日
MQDateUtils.currentTime(true)//12:01:57
MQDateUtils.datetimeFromMilliSecond(1492569882000, chineseFormat: true, timeWithSecond: false)//2017年04月19日 10:44
MQDateUtils.dateFromMilliSecond(1492569882000, chineseFormat: false)//2017-04-19
MQDateUtils.timeFromMilliSecond(1492569882000, timeWithSecond: true)//10:44:42
MQDateUtils.milliSecondFromDate("2017/4/19 10:54:48",dateFormat: "YYYY/MM/dd HH:mm:ss")//1492570488000
MQDateUtils.milliSecondFromDate("2017年4月19日 10:54:48",dateFormat: "YYYY年MM月dd日 HH:mm:ss")//1492570488000
MQDateUtils.currentMillisecond()//1492574517213
MQDateUtils.intToTime(123456,componentString: nil)//10°17′36″
```

- `更新中...`

### `Network(Tiny)`

- `Async Request(JSON/String GET/POST)`

```
MQNetwork.asyncRequest(withUrl: "https://itunes.apple.com/search", params: ["term":"qq","limit":"1","entity":"software"], method: .get, completion: { (obj, stringValue) in
    print("\(obj ?? "")")
}, timeOut: { (errorMsg) in
    print("TimeOut:\(errorMsg)")
}) { (code, errorMsg) in
    print("HttpError:\(code) \(errorMsg)")
}
```

- `Upload Image`

```
MQNetwork.uploadImage(to: "https://192.168.0.81:8000/upload", images: [UIImage(named:"r1")!,UIImage(named:"r2")!], params: nil, compressRatio: 1, completion: { (obj, string) in
    print("\(obj ?? "")")
}, timeOut: { (errorMsg) in
    print("TimeOut:\(errorMsg)")
}) { (code, errorMsg) in
    print("HttpError:\(code) \(errorMsg)")
}
```

### `RemoteNotification`

- `更新中...`

### `Router`

- `更新中...`

### `Web`

- `更新中...`

### `CommonUI`

- `更新中...`

---
>
- `基础版本使用见Demo`
- `方便自己、方便个别人`
