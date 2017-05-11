//
//  AddAssignmentViewController.swift
//  Assignment Helper
//
//  Created by Oliver on 2/24/17.
//  Copyright © 2017 Oliver. All rights reserved.
//

import UIKit

// class controlls the add assignment view controller
class AddAssignmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var priorityLable: UILabel!
    @IBOutlet weak var priority: UIPickerView!
    @IBOutlet weak var dueDate: UIDatePicker!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    
    var thePriority = ["low", "medium", "high"]
    var data:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        priority.delegate = self
        priority.dataSource = self

    }
    
    //soiurce from http://sourcefreeze.com/ios-datepicker-tutorial-uidatepicker-using-swift/
    @IBAction func datePickerAction(sender: AnyObject) {
        //fromats date picker and sets the date to the label
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var strDate = dateFormatter.string(from: dueDate.date)
        self.dueDateLabel.text = strDate
        
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return thePriority.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return thePriority[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityLable.text = thePriority[row]
    }

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func addAssignmentToData(_ sender: UIButton) {
         
        let assignmentName = name.text
        let dueDate = dueDateLabel.text
        let Priority = priorityLable.text
        
        let file = "data.txt" //this is the file. we will write to and read from it
        
        let assignment = assignmentName! + ", " + dueDate! + ", " + (Priority! as! String) //assignemtn parameters
        
        
        //functions from biran wilkinson
        //http://stackoverflow.com
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //reading the file
            do {
                data = try String(contentsOf: path, encoding: String.Encoding.utf8)
                data += assignment + "\n"
            }
            catch {/* error handling here */}
            
            //writing
            do {
                try data.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading the file
            do {
                let data = try String(contentsOf: path, encoding: String.Encoding.utf8)
                print(data)
            }
            catch {/* error handling here */}
            
        
            
        }
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    }
