//
//  ObjectFromAssign.swift
//  Swift - UITabBarController
//
//  Created by 聂宽 on 15/12/24.
//  Copyright © 2015年 聂宽. All rights reserved.
//

import UIKit

extension NSObject
{
    // 将字典数组转换为模型数组
    class func objectArrayWithKeyValuesArray(keyValuesArray : [AnyObject]) -> [AnyObject] {
        var count:UInt32 = 0
        let propertise = class_copyPropertyList(self.classForCoder(), &count)
        
        var modelArray = [AnyObject]()
        
        for dict in keyValuesArray
        {
            // 判断如果不是字典类型则跳过
            if !dict.isKindOfClass(NSDictionary.classForCoder())
            {
                continue
            }
            let aClass = self
            let model = aClass.init()
            
            for var i = 0; i < Int(count); i++
            {
                let property:objc_property_t = propertise[i]
                
                var key:NSString! = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)
                key = key.lowercaseString
                
                let value :AnyObject? = dict.objectForKey(key)
                
                // 判断值为空则跳过
                if value!.isKindOfClass(NSNull.classForCoder())
                {
                    continue
                }
                if !(value!.isKindOfClass(NSString.classForCoder())){
                    model.setValue(value?.stringValue, forKey: key as String)
                }else
                {
                    model.setValue(value, forKey: key as String)
                }
                
            }
            modelArray.append(model)
        }
        
        return modelArray
    }
    
    // 字典转换为模型
    class func objectWithKeyValues(keyValues : NSDictionary) -> AnyObject
    {
        let model = self.init()
        
        if !keyValues.isKindOfClass(NSDictionary.classForCoder())
        {
            print("keyValues 不是字典类型")
            return model
        }
        var count:UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder(), &count)
        
        for var i = 0; i < Int(count); i++
        {
            let property:objc_property_t = properties[i]
            var key:NSString! = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)
            key = key.lowercaseString
            
            let value = keyValues.objectForKey(key)
            
            if !(value!.isKindOfClass(NSString.classForCoder())){
                model.setValue(value?.stringValue, forKey: key as String)
            }else
            {
                model.setValue(value, forKey: key as String)
            }
        }
        return model
    }
}

