//
//  ViewController.swift
//  ObjectFromJSON-demo
//
//  Created by 聂宽 on 16/2/4.
//  Copyright © 2016年 聂宽. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableview:UITableView!
    
    // 存储数据模型
    var modelArr:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化tableview
        tableview = UITableView(frame: self.view.frame)
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
        
        // 加载数据
        self.getData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "TestCell"
        var cell = tableview.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        }
        let model = self.modelArr[indexPath.row] as! DataModel
        cell?.textLabel?.text = model.name
        cell?.detailTextLabel?.text = model.keywords

        return cell!
    }

    func getData()
    {
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
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

