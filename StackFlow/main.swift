//
//  main.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/22/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa

let path = Bundle.main.path(forResource: "Bridge", ofType: "plugin")
print("Yo")
guard let pluginbundle = Bundle(path: path!) else {
    fatalError("Could not load python plugin bundle")
}
pluginbundle.load()

guard let pc = pluginbundle.principalClass as? BridgeInterface.Type else {
    fatalError("Could not load principal class from python bundle")
}

// Create an instance of the principal class and store it
let interface = pc.createInstance()
Bridge.setSharedInstance(to: interface)

NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

