//
//  AppManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

class AppManager {
    
    class func versionBuild() -> (version: String, build: String) {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as? String
        let build = dictionary["CFBundleVersion"] as? String
        return (version ?? "", build ?? "")
    }
    
    class func versionNumber() -> Int {
        let version = versionBuild().version.replacingOccurrences(of: ".", with: "")
        guard let versionNum = Int(version) else { return 0 }
        return versionNum
    }
    
    class func versionBuildNumber() -> Int {
        let version = versionBuild().version.replacingOccurrences(of: ".", with: "")
        let build = versionBuild().build.replacingOccurrences(of: ".", with: "")
        let versionNumString = version.appending(build)
        guard let versionNum = Int(versionNumString) else { return 0 }
        return versionNum
    }
    
}
