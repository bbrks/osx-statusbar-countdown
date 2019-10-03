//
//  AppDelegate.swift
//  StatusbarCountdown
//
//  Created by Ben Brooks on 31/03/2015.
//  Copyright (c) 2015 Ben Brooks. All rights reserved.
//

import Cocoa
import Foundation

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, PreferencesWindowDelegate {

    let DEFAULT_NAME = "Countdown Name"
    let DEFAULT_DATE = NSDate(timeIntervalSince1970: 1597249800)
    
    var countToDate = NSDate(timeIntervalSince1970: 1597249800)
    var countdownName = "Countdown Name"

    var showName = true
    var showSeconds = true
    var zeroPad = false

    var formatter = NumberFormatter()

    let statusItem = NSStatusBar.system.statusItem(withLength: -1)
    @IBOutlet weak var statusMenu: NSMenu!
    var preferencesWindow: PreferencesWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
        statusItem.title = ""
        statusItem.menu = statusMenu
        formatter.minimumIntegerDigits = zeroPad ? 2 : 1

        Timer.scheduledTimer(timeInterval: 0.16, // 16ms ~ 60fps
                             target: self,
                             selector: #selector(tick),
                             userInfo: nil,
                             repeats: true)
        
        updatePreferences()
    }
    
    func preferencesDidUpdate() { // Delegate when setting values are updated
        updatePreferences()
    }
    
    func updatePreferences() {
        let defaults = UserDefaults.standard
        
        // Gets the saved values in user defaults
        countdownName = defaults.string(forKey: "name") ?? DEFAULT_NAME
        countToDate = defaults.value(forKey: "date") as? NSDate ?? DEFAULT_DATE
    }

    // Calculates the difference in time from now to the specified date and sets the statusItem title
    @objc func tick() {
        let diffSeconds = Int(countToDate.timeIntervalSinceNow)
        
        statusItem.title = (showName) ? countdownName + ": " : ""
        statusItem.title! += formatTime(diffSeconds)
    
    }
    
    // Convert seconds to 4 Time integers (days, hours minutes and seconds)
    func secondsToTime (_ seconds : Int) -> (Int, Int, Int, Int) {
        let days = seconds / (3600 * 24)
        var remainder = seconds % (3600 * 24)
        
        let hours = remainder / 3600
        remainder = remainder % 3600
        
        let minutes = remainder / 60
        
        let seconds = remainder % 60
        
        return (days, hours, minutes, seconds)
    }
    
    // Display seconds as Days, Hours, Minutes, Seconds.
    func formatTime(_ seconds: Int) -> (String) {
        let time = secondsToTime(abs(seconds))
        let daysStr    = (time.0 != 0) ? String(time.0) + "d " : ""
        let hoursStr   = (time.1 != 0 || time.0 != 0)               ? formatter.string(from: NSNumber(value: time.1))! + "h " : ""
        let minutesStr = (time.2 != 0 || time.1 != 0 || time.0 != 0) ? formatter.string(from: NSNumber(value: time.2))! + "m" : ""
        let secondsStr = (showSeconds) ? " " + formatter.string(from: NSNumber(value: time.3))! + "s" : ""
        let suffixStr  = (seconds < 0) ? " ago" : "" // TODO: i18n?
        return daysStr + hoursStr + minutesStr + secondsStr + suffixStr
    }

    // MenuItem click event to toggle showSeconds
    @IBAction func toggleShowSeconds(sender: NSMenuItem) {
        if (showSeconds) {
            showSeconds = false
            sender.state = .off
        } else {
            showSeconds = true
            sender.state = .on
        }
    }

    // MenuItem click event to toggle showName
    @IBAction func toggleShowName(sender: NSMenuItem) {
        if (showName) {
            showName = false
            sender.state = .off
        } else {
            showName = true
            sender.state = .on
        }
    }

    // MenuItem click event to toggle zeroPad
    @IBAction func toggleZeroPad(sender: NSMenuItem) {
        if (zeroPad) {
            zeroPad = false
            sender.state = .off
        } else {
            zeroPad = true
            sender.state = .on
        }
        formatter.minimumIntegerDigits = zeroPad ? 2 : 1
    }

    // MenuItem click event to open preferences popover
    @IBAction func configurePreferences(_ sender: Any) {
        preferencesWindow.showWindow(nil)
    }
    
    // MenuItem click event to quit application
    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.shared.terminate(self);
    }

}
