//
//  SettingsWindow.swift
//  StatusbarCountdown
//
//  Created by Jacqueline Alves on 02/10/19.
//  Copyright © 2019 Ben Brooks. All rights reserved.
//

import Cocoa

class SettingsWindow: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center() // Center the popover
        self.window?.makeKeyAndOrderFront(nil) // Make popover appear on top of anything else
        
        NSApp.activate(ignoringOtherApps: true) // Activate popover
    }
    
    override var windowNibName : String! {
        return "SettingsWindow"
    }
    
}
