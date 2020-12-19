//
//  StatusData.swift
//  StatusCovid
//
//  Created by Blanca Cordova on 18/12/20.
//  Copyright © 2020 Blanca Cordova. All rights reserved.
//

import Foundation
struct StatusData:Codable {
    
    let country:String
    let cases:Int
    let deaths:Int
    let recovered:Int
    
    let todayCases:Int
    let todayDeaths:Int
    let todayRecovered:Int
    let countryInfo:CountryInfo
    let continent:String
    
    struct CountryInfo:Codable {
        let flag:String
    }
}


