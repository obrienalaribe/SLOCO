//
//  DateExtension.swift
//  SLOCO
//
//  Created by mac on 6/26/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import Foundation

extension NSDate {
    func dayOfWeek() -> Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) {
            return comp.weekday
        } else {
            return nil
        }
    }
}
