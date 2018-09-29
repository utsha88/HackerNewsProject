//
//  HackerNewsIntExtension.swift
//  Omnify
//
//  Created by Utsha Guha on 9/27/18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import Foundation
//import UIKit

extension Int{
//    func showAlert(heading:String, message:String, buttonTitle:String) {
//        let alert = UIAlertController(title: heading, message: message, preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func convertUnixTimeToDateStringWithTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        //dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd MMM, yyyy - HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func convertUnixTimeToDateString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        //dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd MMM, yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func timeIntervalSinceCurrentDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let difference = Int(Date().timeIntervalSince(date)/60.0)
        
        if difference>60{
            let hour = difference/60
            let min = difference%60
            return "\(hour)hr \(min)mins ago"
        }
        return "\(difference) mins ago"
    }
}
