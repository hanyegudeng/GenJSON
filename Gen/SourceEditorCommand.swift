//   
//   SourceEditorCommand.swift
//   Gen
//   
//   Created by Yun on 2022/1/5
//   
//   
//   =====================================
//   
//   =====================================
//


import Foundation
import XcodeKit
import SwiftyJSON

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        let range = invocation.buffer.selections.firstObject as! XCSourceTextRange
        // match clipped text
        let match = xTextMatcher.match(selection: range, invocation: invocation, options: .selected)

        let endLineIndex = (range.end.line + 2) > invocation.buffer.lines.count ? (invocation.buffer.lines.count - 1) : (range.end.line + 2)
        let jsonstr = match.text


        let baseClass =  invocation.commandIdentifier
        let model = ModelFactory(base:baseClass,name:"NewModelName")
        let modelCode  = model.genModel(src: jsonstr)
        invocation.buffer.lines.insert(modelCode, at: endLineIndex)
        completionHandler(nil)
    }
    
}
