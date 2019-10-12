//
//  PreferencesWindow.swift
//  StatusbarCountdown
//
//  Created by Jacqueline Alves on 02/10/19.
//  Copyright © 2019 Ben Brooks. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController, NSWindowDelegate {

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var nameBadInputFeedback: NSTextField!
    @IBOutlet weak var dateBadInputFeedback: NSTextField!
    
    var delegate: PreferencesWindowDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center() // Center the popover
        self.window?.makeKeyAndOrderFront(nil) // Make popover appear on top of anything else
        
        datePicker.dateValue = Date()

        NSApp.activate(ignoringOtherApps: true) // Activate popover
        
        nameTextField.delegate = self
    }
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    func save() {
        let defaults = UserDefaults.standard
        
        defaults.set(nameTextField.stringValue, forKey: "name")
        defaults.set(datePicker.dateValue, forKey: "date")
        
        delegate?.preferencesDidUpdate()
    }
    
    @IBAction func validate(_ sender: Any) {
        var validation = true
        
        if nameTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) == "" { // Check if name is empty
            nameBadInputFeedback.isHidden = false
            window?.shakeWindow()
            
            validation = false
            
        }
        
        if datePicker.dateValue < Date() { // Check if date is after today
            dateBadInputFeedback.isHidden = false
            window?.shakeWindow()
            
            validation = false
        }
        
        if validation { // Everything is ok, save values to user defaults and close popover
            save()
            close()
        }
    }
    
    @IBAction func changeDatePicker(_ sender: Any) {
        dateBadInputFeedback.isHidden = true // Hide bad input feedback when change the date
    }
    
    @IBAction func closePopover(_ sender: Any) {
        close()
    }
}

extension PreferencesWindow: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        nameBadInputFeedback.isHidden = true // Hide bad input feedback when something is entered on textfield
    }
}
