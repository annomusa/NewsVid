//
//  Config.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation

class Config {
    
    static let instance: Config = Config()
    
    let googleKey: String
    
    init() {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        let googleKey = keys?["google"] as? String ?? "Get your own API key from Google Developer Page"
        self.googleKey = googleKey
        
    }
    
}
