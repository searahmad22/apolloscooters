//
//  NSObject.swift
//  apollo
//
//  Created by Sear Ahmad on 17/03/23.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
