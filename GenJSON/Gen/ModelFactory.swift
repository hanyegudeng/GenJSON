//   
//   ModelFactory.swift
//   GenJSON
//   
//   Created by Yun on 2022/1/5
//   
//   
//   =====================================
//   
//   =====================================
//
   

import Cocoa
import SwiftyJSON

let modelSubFix = "Model"

class ModelFactory: ClassFactory {
    var nestClass:[String] = []
    
    init(base:StructDefine, name:String) {
        super.init()
        self.baseClass = base
        
        self.this = StructDefine(name + modelSubFix)
        self.this?.parent = base
    }
    
    convenience init(base:String, name:String) {
        self.init(base:StructDefine(base),name:name)
    }
    
    fileprivate func visit(_ json: JSON, nestkey:String? = nil) {
        switch json.type {
        case .dictionary:
            if let nestkey = nestkey {
                let model = ModelFactory(base:baseClass!,name:nestkey)
                let modelCode  = model.genModel(json:json)
                nestClass.append(modelCode)
                return
            }
            
            for (key, value) in json.dictionary!{
                let property = MemberDefine(name:key ,type: value.type.optionalType(key: key + modelSubFix), prefix:["    ",Keywords.var.rawValue], getStament: [], setStament: [])
                this?.add(property)
                visit(value,nestkey: key)
            }
        case .array:
            if let nestkey = nestkey {
                if let value = json.array?.first{
                    let model = ModelFactory(base:baseClass!,name:nestkey)
                    let modelCode  = model.genModel(json:value)
                    nestClass.append(modelCode)
                }
            }
            
        default:
            print("-\(json.type)--\(json)")
        }
    }

    func genModel(src:String) ->String {
        let json = JSON( parseJSON:src)
        return genModel(json:json)
    }
    
    func genModel(json:JSON) ->String {
        visit(json)
        let code = this?.code()
        let codes = [code!] + nestClass
        let allcode = codes.joined(separator: "\n")
        return allcode
    }
}
