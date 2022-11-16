//
//  Extensions+Double.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import Foundation

extension Double {
    func abbreviated() -> String {
        return String(format: "%.2f", self)
    }
}
