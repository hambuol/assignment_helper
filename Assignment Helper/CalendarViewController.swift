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
    @IBOutlet weak var year: UILabel?
    @IBOutlet weak var month: UILabel?
    
    
    let ousideMonthColor = UIColor.white
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.yellow
    //let currentDataSelectedViewColor = UIColor.white
    

    let formatter = DateFormatter()
    //changes color of selected cells and cells that are in or out of the month
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        }else{
            if cellState.dateBelongsTo == .thisMonth{
                validCell.dateLabel.textColor = monthColor
            }else{
                validCell.dateLabel.textColor = ousideMonthColor
            }
        }
        
    }
    //shows the cell is selected if clicked
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCell else {return}
        if validCell.isSelected{
            validCell.selectedView.isHidden = false
        }else{
            validCell.selectedView.isHidden = true
        }

    }
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
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        year?.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month?.text = formatter.string(from: date)
    }
    
}

//extension UIColor{
//    convenience init(colorWithHexValue: Int, alph:CGFloat = 1.0){
//        self.init(
//            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(value & 0x0000FF) / 255.0,
//            alpha: alpha
//        
//        
//        )
//    }
//    
//    
//}
