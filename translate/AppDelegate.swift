//
//  AppDelegate.swift
//  translate
//
//  Created by Minan on 15.01.2023.
//  Edited by RII798 on 25.11.2024.
//

import Cocoa
import HotKey

class AppDelegate: NSObject, NSApplicationDelegate {

    public var panel: FloatingPanel!
    public var hotKey: HotKey? {
        didSet {
            guard let hotKey = hotKey else {
                return
            }
            
            hotKey.keyDownHandler = { [weak self] in
                self?.panel.toggle()
            }
        }
    }
    
    var statusBar: NSStatusBar!
    var statusBarItem: NSStatusItem!
    var menu: NSMenu!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        panel = FloatingPanel()
        
        statusBar = NSStatusBar()
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusBarItem.button {
            button.image = NSImage(named: "icon")
            button.action = #selector(statusBarItemPressed)
        }
        
       
        
        //Hotkey to open panel without interacting with status menu icon
        hotKey = HotKey(key: .t, modifiers: [.command, .control])
        hotKey?.keyDownHandler = {
            self.panel.toggle()
        }
        
        // Status Bar menu
        menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        
        NSEvent.addLocalMonitorForEvents(matching: [.rightMouseDown]) { [weak self] event in
            self?.handleRightClick(event: event)
            return event
        }
    }
    
    
    //If Right-click, open menu
    func handleRightClick(event: NSEvent) {
        if let button = statusBarItem.button {
            menu.popUp(positioning: nil, at: NSPoint(x: 0, y: button.bounds.height), in: statusBarItem.button)
        }
     }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc func statusBarItemPressed() {
        self.panel.toggle()
    }
    
    @objc func quitApp() {
        NSApplication.shared.terminate(self)
    }
}

