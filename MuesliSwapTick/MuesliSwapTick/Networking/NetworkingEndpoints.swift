//
//  Endpoints.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import Foundation

enum NetworkingEndpoints: String {
    case summary
    
    var url: URL? {
        return URL.init(string: "https://analytics.muesliswap.com/"+self.rawValue)
        
    }
}
