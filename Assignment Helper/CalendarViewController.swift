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

var assignments = [Assignment]()

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel?
    @IBOutlet weak var month: UILabel?
    
    
    let ousideMonthColor = UIColor.white
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.yellow
    //let currentDataSelectedViewColor = UIColor.white
    

    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupcalendarview()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.calendarView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        assignments.removeAll()
        loadData()
    }


    
    func setupcalendarview() {
        //setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //setup labels
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    
    }
    //changes color of selected cells and cells that are in or out of the month
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = monthColor   
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
    
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.year?.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.month?.text = self.formatter.string(from: date)
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
        cell.eventLabel.text = ""
        //adds assignment to calendar...thank you brian
        for assignment in assignments {
            let strDate = formatter.string(from: date)
            if (assignment.duedate == strDate){
                cell.eventLabel.text = assignment.name
            }
        }
        cell.dateLabel.text = cellState.text
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    
    //func reloads date to calendar when themonth is changed
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        //updates calendar when month is changed
        self.calendarView.reloadData()
        
    }
    func loadData() {
        let file = "data.txt" //this is the file. we will write to and read from it
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = dir?.appendingPathComponent(file)
        //TODO: read data.txt into a array and add to assignment
        //reading the file
        
        /*
         create new assignment
         assignment.name = 1st item in array
         assignment.priority = 3rd
         assignment.duedate = 2nd
         add to assignment array
         */
        do {
            let data = try String(contentsOf: path!, encoding: String.Encoding.utf8)
            let temp = data.components(separatedBy: "\n")
            for assignment in temp {
                //creates new assignment
                let tempassignment = assignment.components(separatedBy: ",")
                if tempassignment.count == 3{
                    //makes the assignment name, duedate, and priority in order if the assignment has 3 parts
                    let newAssignment = Assignment(name: tempassignment[0] , priority: tempassignment[2] , duedate: tempassignment[1])
                    assignments.append(newAssignment)
                }
            }
            
        }
        catch {/* error handling here */}
    }

}

    

