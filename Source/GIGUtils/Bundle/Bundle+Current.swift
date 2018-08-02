//
//  Bundle+Current.swift
//  GIGLibrary
//
//  Created by Eduardo González on 2/8/18.
//  Copyright © 2018 Gigigo SL. All rights reserved.
//

import Foundation

extension Bundle {
    class var current: Bundle {
        let caller = Thread.callStackReturnAddresses[1]
        
        if let bundle = _cache.object(forKey: caller) {
            return bundle
        }
        
        var info = Dl_info(dli_fname: "", dli_fbase: nil, dli_sname: "", dli_saddr: nil)
        dladdr(caller.pointerValue, &info)
        let imagePath = String(cString: info.dli_fname)
        
        for bundle in Bundle.allBundles + Bundle.allFrameworks {
            if let execPath = bundle.executableURL?.resolvingSymlinksInPath().path,
                imagePath == execPath {
                _cache.setObject(bundle, forKey: caller)
                return bundle
            }
        }
        fatalError("Bundle not found for caller \"\(String(cString: info.dli_sname))\"")
    }
    
    private static let _cache = NSCache<NSNumber, Bundle>()
}
