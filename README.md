# ObjectFromJSON

## <a id="如何使用ObjectFromJSON"></a>如何使用ObjectFromJSON
* 如何使用ObjectFromJSON：
```objc
	let path:NSString = NSBundle.mainBundle().pathForResource("JSONString", ofType: nil)!
        // 加载JSONString文件中json字符串，转化为二进制数据
        let data = NSData.dataWithContentsOfMappedFile(path as String) as! NSData
        
        
        // 将二进制数据转化为json字符串
//        let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        // 将二进制数据转化为字典
        let dict:NSDictionary = try!  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! NSDictionary
        let arr = dict.objectForKey("tngou") as! NSArray
        
        // 将字典数组转化为DataModel数据模型
        self.modelArr = DataModel.objectArrayWithKeyValuesArray(arr as [AnyObject])
        
        // 刷新tableview
        self.tableview.reloadData()
        
        print("\(dict)");
```

* 解析出来的数据效果：
![](http://a3.qpic.cn/psb?/V12PCdgi42tvjF/sLxD4ZWsvsFHZiXG9fIQthJZ6FxaIrbpCM5Ew24R6XA!/b/dFoBAAAAAAAA&ek=1&kp=1&pt=0&bo=gAJwBAAAAAABB9Y!&sce=0-12-12&rf=viewer_4)

<img src="http://a3.qpic.cn/psb?/V12PCdgi42tvjF/sLxD4ZWsvsFHZiXG9fIQthJZ6FxaIrbpCM5Ew24R6XA!/b/dFoBAAAAAAAA&ek=1&kp=1&pt=0&bo=gAJwBAAAAAABB9Y!&sce=0-12-12&rf=viewer_4" width="30%" height="30%">
