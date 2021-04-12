//
//  CalendarVars.swift
//  TABATIMER
//
//  Created by Jakub Rękas on 08/04/2021.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)

