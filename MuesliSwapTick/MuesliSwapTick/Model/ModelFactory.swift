//
//  ModelFactory.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import Foundation

protocol ModelFactory {
    
    func create<T:Codable>() -> T
    
}
