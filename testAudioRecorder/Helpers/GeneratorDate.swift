//
//  GenerateFormatDate.swift
//  testAudioRecorder
//
//  Created by Ira Golubovich on 2/3/20.
//  Copyright © 2020 Ira Golubovich. All rights reserved.
//

import Foundation

class GeneratorDate {
    private static var dayMonthYearAnd12HoursFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
        return dateFormatter
    }()
    
    static func dateDayMonthYearAnd12HoursFormatter(date: Date) -> String {
        return dayMonthYearAnd12HoursFormatter.string(from: date)
    }
}
