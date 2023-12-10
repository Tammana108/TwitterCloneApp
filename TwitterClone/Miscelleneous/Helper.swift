//
//  Helper.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 09/12/23.
//

import Foundation

class Helper {
    static let shared = Helper()
    
    private init() { }
    
    func convertDate(from date : Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "MMM YYYY"

        // Convert Date to String
        
        return dateFormatter.string(from: date)
    }
}
