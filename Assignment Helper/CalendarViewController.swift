//
//  CalendarViewController.swift
//  Assignment Helper
//
//  Created by Oliver on 4/27/17.
//  Copyright © 2017 Oliver. All rights reserved.
//


//in th middle of a tutorial learning about what and how this makes the callendar
//https://www.youtube.com/watch?v=zOphH-h-qCs
import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
//    func configureCalendar(_ calendar: JTAppleCalendarView) -> CofigurationParameters{
//        formatter.dateFormatter = "yyyy MM dd"
//        formatter.timeZone = Calendar.current.timeZone
//        formatter.locale = Calendar.current.locale
//        
//        let startDate = formatter.date(from: "2017 01 01")
//        let endDate = formatter.date(from: "2017 12 31")
//        
//        let paramaters = CofigurationParameters(startDate: Date, endDate: Date)
//        return paramaters
//    
//    }
//}

