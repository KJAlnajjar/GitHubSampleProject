//
//  Utilities.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/24/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit
import SystemConfiguration
import RealmSwift

struct Utilities {
    
    static func showImageFromURL(url: String) -> UIImage {
        if let url = URL(string: url) {
            let data = try! Data(contentsOf: url)
            return UIImage(data: data)!
        }
        return UIImage()
    }
    
    static func isConnectedToNetwork() -> Bool {

         var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
         zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
         zeroAddress.sin_family = sa_family_t(AF_INET)

         let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
             $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                 SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
             }
         }

         var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
         if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
             return false
         }

         let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
         let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
         let ret = (isReachable && !needsConnection)

         return ret
     }
    
    static func isLocalDataBaseEmpty() -> Bool {
        let OfflineData = try! Realm().objects(MainHeaderEventsRealmModel.self)
        return OfflineData.first?.results == nil
    }
    
    static func getLocalData() -> [MainEventsRealmModel] {
        let OfflineData = try! Realm().objects(MainHeaderEventsRealmModel.self)
        let OfflineDataArray = Array(OfflineData.first!.results)
        return OfflineDataArray
    }
}
