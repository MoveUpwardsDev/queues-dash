//
//  Optional+String.swift
//  
//
//  Created by lgriffie on 21/05/2021.
//

import Foundation

extension Optional where Wrapped == String {
    func toInt(or defaultValue: Int) -> Int {
        guard let str = self else { return defaultValue }
        return Int(str) ?? defaultValue
    }
}
