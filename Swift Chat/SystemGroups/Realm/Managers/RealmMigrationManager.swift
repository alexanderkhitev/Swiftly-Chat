//
//  RealmMigrationManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMigrationManager {
    
    private init() { }
    
    class func migrate() {
        let schemaVersionNumber = UInt64(AppManager.versionBuildNumber())
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: schemaVersionNumber,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            // migration and ol
            migrationBlock: { _, oldSchemaVersion in
                // We haven't migrated anything yet, so oldSchemaVersion == 0
                //if (oldSchemaVersion < 1) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
                //}
                debugPrint("oldSchemaVersion", oldSchemaVersion)
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
    }
    
}
