//
//  Constants.swift
//  translate
//
//  Created by Minan on 21.01.2023.
//

import Foundation
import AppKit
import HotKey

struct Constants {
    static let WIDTH = 550
    static let HEIGHT = 360
    
    static let SOURCE_LANGUAGE = "en"
    static let TRANSLATION_LANGUAGE = "tr"
    
    static let key: Key = .backslash
    static let closeKey = HotKey(key: .q, modifiers: [.command])
    public static let openHotKey = HotKey(key: .t, modifiers: [.command, .option])
    static let modifiers: NSEvent.ModifierFlags = [.command]
}
