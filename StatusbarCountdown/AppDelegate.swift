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
        let diff = Int(countToDate.timeIntervalSinceDate(now))

        statusItem.title = String(diff)
    }

    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self);
    }

}
