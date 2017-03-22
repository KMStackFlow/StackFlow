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

NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

