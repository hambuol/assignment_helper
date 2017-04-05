//
//  AddAssignmentViewController.swift
//  Assignment Helper
//
//  Created by Oliver on 2/24/17.
//  Copyright © 2017 Oliver. All rights reserved.
//

import UIKit

// class controlls the add assignment view controller
class AddAssignmentViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var duedate: UITextField!
    @IBOutlet weak var priority: UITextField!
    var data:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
        

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func addAssignmentToData(_ sender: UIButton) {
         
        let assignmentName = name.text
        let dueDate = duedate.text
        let Priority = priority.text
        
        let file = "data.txt" //this is the file. we will write to and read from it
        
        let assignment = assignmentName! + ", " + dueDate! + ", " + Priority! //assignemtn parameters
        
        
        //functions from biran wilkinson 
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
