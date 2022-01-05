//   
//   ViewController.swift
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

class ViewController: NSViewController {
    
    @IBOutlet weak var txtInput: NSTextField!
    @IBOutlet weak var txtOutput: NSTextField!
    
    @IBOutlet weak var txtBaseClass: NSTextField!
    
    @IBOutlet weak var txtClassName: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func generate(_ sender: Any) {
        let model = ModelFactory(base: txtBaseClass.stringValue, name: txtClassName.stringValue)
        let m = model.genModel(src: txtInput.stringValue)
        txtOutput.stringValue = m
    }
    
    @IBAction func copyClass(_ sender: Any) {
        NSPasteboard.general.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        NSPasteboard.general.setString(txtOutput.stringValue, forType: NSPasteboard.PasteboardType.string)
        let alert = NSAlert()
        alert.window.title = "提示"
        alert.messageText = "复制成功"
        alert.icon = NSImage(named: "icon")
        alert.runModal()
    }
}

