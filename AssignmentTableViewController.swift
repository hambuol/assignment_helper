//
//  AssignmentTableViewController.swift
//  Assignment Helper
//
//  Created by Oliver on 2/16/17.
//  Copyright © 2017 Oliver. All rights reserved.
//

import UIKit

// class controlls the assignment view controller
class AssignmentTableViewController: UITableViewController{
    //arrar of assignments to display on table view
    var assignments = [Assignment]()
    var data:String = ""
    let file = "data.txt"
    var refresher: UIRefreshControl!
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LabelCell")
        
        //code from https://www.youtube.com/watch?v=sUGRDEZaDyQ
        //code adds and sets up refresher 
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(AssignmentTableViewController.loadData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return assignments.count
    }
    
    // function displays the assingment to the table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "LabelCell")
        //displays the name as the lable in the cell and the duedate as a detail in the cell
        cell.textLabel?.text = assignments[indexPath.row].name
        cell.detailTextLabel?.text = assignments[indexPath.row].duedate
        //resource from http://stackoverflow.com/questions/41149375/string-into-array-in-swift-3
        //takes priority and checks if first charachter, makes collor of cell accordingly
        var pri = assignments[indexPath.row].priority
        let array = Array(pri.characters)
        for char in array{
            if char == "l"{
                cell.backgroundColor = UIColor.green
            }
            if char == "m"{
                cell.backgroundColor = UIColor.yellow
            }
            if char == "h"{
                cell.backgroundColor = UIColor.red
            }
        }
        return cell
    }
    // reloads the data to the table view controller
    // sets the table view controller color to lightgrey
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    //deletes all the assignments and reloads the data so it isnt loaded twice
    override func viewWillAppear(_ animated: Bool) {
        assignments.removeAll()
        loadData()
    }
    
    //function deletes row when you slide
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //removes the row that is selected from the table view controller
            assignments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteAssignment(index: 0)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    // loads the data to the table view controller from the .txt file
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
        
        //supposed to nd the refreshing of the refresher
        //refresher.endRefreshing()
        tableView.reloadData()
        
    }
    
    func deleteAll() {
        //function removes and writes over all the data to remove all asignments
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //reads file and writes over the data, deleting all the assignments 
            do {
                //deletes all assignments
                data = try String(contentsOf: path, encoding: String.Encoding.utf8)
                data = ""
            }
            catch {/* error handling here */}
            //writing
            do {
                try data.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }

    }
    
    func deleteAssignment(index: Int) {

        //function removes assignment from source file
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //reading the file
            do {
                let data = try String(contentsOf: path, encoding: String.Encoding.utf8)
                print(data)
            }
            catch {/* error handling here */}
            
            //reading the file
            do {
                //deletes all assignments
                data = try String(contentsOf: path, encoding: String.Encoding.utf8)
                data = ""
            }
            catch {/* error handling here */}
            
            //writing
            do {
                try data.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
        
    }
    
    //button removes all assignments and refreshed the view
    @IBAction func removeAll(_ sender: UIBarButtonItem) {
        //deletes all of the assignents from the view controller and assignments array
        //although it does not update table view
        
        //assignments.removeAll()
        //loadData()
        //self.tableView.reloadData()
        deleteAll()
        
        
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

