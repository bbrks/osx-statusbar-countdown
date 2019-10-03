//
//  SettingsWindow.swift
//  StatusbarCountdown
//
//  Created by Jacqueline Alves on 02/10/19.
//  Copyright © 2019 Ben Brooks. All rights reserved.
//

import Cocoa

class SettingsWindow: NSWindowController, NSWindowDelegate {

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    
    var delegate: SettingsWindowDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center() // Center the popover
        self.window?.makeKeyAndOrderFront(nil) // Make popover appear on top of anything else
        
        NSApp.activate(ignoringOtherApps: true) // Activate popover
    }
    
    override var windowNibName : String! {
        return "SettingsWindow"
    }
    
    @IBAction func save(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        defaults.set(nameTextField.stringValue, forKey: "name")
        defaults.set(datePicker.dateValue, forKey: "date")
        
        delegate?.settingsDidUpdate()
        close()
    }
    
    @IBAction func closePopover(_ sender: Any) {
        close()
    }
}
