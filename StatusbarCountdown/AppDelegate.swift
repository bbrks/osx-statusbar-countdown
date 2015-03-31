//
//  AppDelegate.swift
//  StatusbarCountdown
//
//  Created by Ben Brooks on 31/03/2015.
//  Copyright (c) 2015 Ben Brooks. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let countToDate = NSDate(timeIntervalSince1970: 1431000000)
    let countdownName = "Diss"

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    @IBOutlet weak var statusMenu: NSMenu!

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        statusItem.title = "Countdown"
        statusItem.menu = statusMenu

        // Run tick() once a second
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick", userInfo: nil, repeats: true)

    }

    func tick() {
        let now = NSDate()
        var diff = secondsToHoursMinutesSeconds(countToDate.timeIntervalSinceDate(now))
    
        statusItem.title = countdownName + ": " + formatHMS(diff)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Double) -> (Double, Double, Double) {
        let (hr,  minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return (hr, min, 60 * secf)
    }
    
    func formatHMS(hmsTuple: (Double, Double, Double)) -> (String) {
        return String(Int(hmsTuple.0)) + "h " + String(Int(hmsTuple.1)) + "m " + String(Int(hmsTuple.2)) + "s"
    }

    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self);
    }

}
