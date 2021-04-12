//
//  ViewController.swift
//  TABATIMER
//
//  Created by Jakub Rękas on 30/03/2021.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    @IBOutlet weak var calendarCV: UICollectionView!
    @IBOutlet weak var monthLbl: UILabel!
    
    
    
    
    let months = ["Styczeń", "Luty", "Marzec", "Kwieciec", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"]
    let daysOfWeek = ["Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela"]
    let daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox = 0
    var direction = 0
    var positionIndex = 0
    var leapYearCounter = 2
    var dayCounter = 0
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
        
            
        
            currentMonth = months[month]
            
            monthLbl.text = "\(currentMonth) \(year)"
        
        if weekday == 0 {
            weekday = 7
        }
        getStartDateDayPosition()
    }
    
    func getStartDateDayPosition() {
                switch direction {
                case 0:
                    numberOfEmptyBox = weekday
                    dayCounter = day
                    while dayCounter > 0 {
                        numberOfEmptyBox -= 1
                        dayCounter -= 1
                        if numberOfEmptyBox == 0 {
                            numberOfEmptyBox = 7
                        }
                    }
                    if numberOfEmptyBox == 7 {
                        numberOfEmptyBox = 0
                    }
                    positionIndex = numberOfEmptyBox
                        
                case 1...:
                    nextNumberOfEmptyBox = (positionIndex + daysInMonths[month])%7
                    positionIndex = nextNumberOfEmptyBox
                case -1:
                    previousNumberOfEmptyBox = (7 - (daysInMonths[month] - positionIndex)%7)
                    if previousNumberOfEmptyBox == 7 {
                        previousNumberOfEmptyBox = 0
                    }
                    positionIndex = previousNumberOfEmptyBox
                default:
                    fatalError()
                }
            }
    
    @IBAction func nextBtn(_ sender: UIButton) {
            switch currentMonth {
            case "Grudzień":
                month = 0
                year += 1
                direction = 1
                getStartDateDayPosition()
                
                currentMonth = months[month]
                monthLbl.text = "\(currentMonth) \(year)"
                calendarCV.reloadData()
                
            default:
                
                
                direction = 1
                getStartDateDayPosition()
                
                month += 1
                
                currentMonth = months[month]
                monthLbl.text = "\(currentMonth) \(year)"
                calendarCV.reloadData()
            }
        }
    
    @IBAction func backBtn(_ sender: UIButton) {
        switch currentMonth {
        case "Styczeń":
            month = 11
            year -= 1
            direction = -1
            getStartDateDayPosition()
            currentMonth = months[month]
            monthLbl.text = "\(currentMonth) \(year)"
            calendarCV.reloadData()
            
        default:
            month -= 1
            direction = -1
            getStartDateDayPosition()
            
            currentMonth = months[month]
            monthLbl.text = "\(currentMonth) \(year)"
            calendarCV.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch direction {
        case 0:
            return daysInMonths[month] + numberOfEmptyBox
        case 1...:
            return daysInMonths[month] + nextNumberOfEmptyBox
        case -1:
            return daysInMonths[month] + previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCV", for: indexPath) as! DateCollectionViewCell
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        cell.dateLbl.isUserInteractionEnabled = true
        cell.dateLbl.addGestureRecognizer(tap)
        
        
        cell.backgroundColor = UIColor.clear
        cell.dateLbl.textColor = UIColor.black
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch direction {
        case 0:
            cell.dateLbl.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1:
            cell.dateLbl.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dateLbl.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.dateLbl.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.dateLbl.text!)! > 0 {
                cell.dateLbl.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - numberOfEmptyBox == day{
            cell.dateLbl.textColor = UIColor.red
            
        }
        return cell
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        print("tap working")
    }
    
    
    @IBSegueAction func openTimer(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: TimerView())
    }
    
    
}

