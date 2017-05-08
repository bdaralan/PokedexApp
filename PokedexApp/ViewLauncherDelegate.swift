//
//  ViewLauncherDelegate.swift
//  PokedexApp
//
//  Created by Dara on 5/7/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit


@objc protocol ViewLauncherDelegate: NSObjectProtocol {
    
    @objc optional func viewLauncher(willLaunch launchOrigin: CGPoint)
    
    @objc optional func viewLauncher(didLaunch launchOrigin: CGPoint)
    
    @objc optional func viewLauncher(willDismiss dismissOrigin: CGPoint)
    
    @objc optional func viewLauncher(didDismiss dismissOrigin: CGPoint)
}
