//
//  TSGStringExtensions.swift
//  ServiceSample
//
//  Created by Yogesh Bhatt on 13/05/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

extension String {
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlpha:Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9.]+", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isNumeric:Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: "[0-9.]+", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
        
    }
    
    func findRangeIn(find: String) -> (Range<Index>?){
        print(self.rangeOfString(find) != nil)
        print(self.rangeOfString(find))

        return (self.rangeOfString(find))
    }
}