//
//  BGConstants.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/17/23.
//

import Foundation

struct BGConstants {
    
    // MARK: - Network response status
    static var success:Int {return 200}
    static var added:Int {return 202}
    static var failed:Int {return 400}
    static var created:Int {return 201}
    static var unprocessableEntity : Int {return 401}
    static var notActive : Int {return 406}
    static var unauthenticated : Int {return 403}
    static var notAcceptable : Int {return 422}
    static var notFound : Int {return 404}
    static var userType : Int {return 1}
    
    
    // MARK: - GOOGLE MAPS Constants
    static var mapKey : String {return "AIzaSyAG9F2HDaTi93fzTTB0vdj5G0Ol6ys2SgQ"}
    static var mapStyle : String {return "&zoom=11&style=feature:transit.line%7Cvisibility:simplified%7Ccolor:0xbababa&style=feature:road.highway%7Celement:labels.text.stroke%7Cvisibility:on%7Ccolor:0xb06eba&style=feature:road.highway%7Celement:labels.text.fill%7Cvisibility:on%7Ccolor:0xffffff&maptype=terrain&scale=2&size=400x400&"}
    
    
    // MARK: - APIs Constants
    static var baseURL:String {return "https://api.football-data.org/v2/competitions/2021/"}
    static var apiURL:String {return "\(baseURL)"}
    
}
