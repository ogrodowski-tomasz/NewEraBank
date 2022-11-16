//
//  Extensions+Colors.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import SwiftUI

struct ColorTheme {
    let background = Color("background")
    let label = Color("label")
    let lightGreen = Color("light-green")
    let lightPurple = Color("light-purple")
    let veryLightGreen = Color("very-light-green")
}

extension Color {
    static let theme = ColorTheme()
}
