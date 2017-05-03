//
//  CalendarViewController.swift
//  Assignment Helper
//
//  Created by Oliver on 4/27/17.
//  Copyright © 2017 Oliver. All rights reserved.
//



import UIKit
//coco pod from https://github.com/patchthecode/JTAppleCalendar
import JTAppleCalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupcalendarview()

        // Do any additional setup after loading the view.
    }
    func setupcalendarview() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//cocopods tutorial from https://www.youtube.com/watch?v=Qd_Gc67xzlw&spfreload=5
extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate{
    //display the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.dateLabel.text = cellState.text
        if cellState.isSelected{
            cell.selectedView.isHidden = false
        }else{
            cell.selectedView.isHidden = true
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        validCell.selectedView.isHidden = false
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        validCell.selectedView.isHidden = true
        }
    
}

extension UIColor{
    convenience init(colorWithHexValue: Int, alph:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            
        
        
        )
    }
    
    
}
