//
//  ClosestToFranceTableViewController.swift
//  Where Is France
//
//  Created by will quigley on 4/16/22.
// Corey Briscoe corbrisc
// Blythe Hammett blhamm
// William Quigley wquigley

import UIKit

class ClosestToFranceTableViewController: UITableViewController {

    var appDelegate: AppDelegate?
    var myModel: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //self.myModel = self.appDelegate?.myModel
        //return self.myModel?.distances.count ?? 0
        // We did not use the above, instead intentionally doing it this way,
        // so the user could see that we keep the top 3 best distances. It also tells them
        // to come back in the future to make these best scores fill in
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ctfCell", for: indexPath) as! ClosestToFranceTableViewCell
        if (indexPath.row >= self.myModel?.distances.count ?? 0) {
            cell.distanceLabel.text = "No record... yet. Come back again tomorrow!"
            cell.dateLabel.text = ""
        } else {
            // This outputs as a really long decimal number as-is...
            // Cast to Int, but then it might appear there are duplicate distances in the table. Ideally, truncate the Double to one or two decimal points to avoid.
            // However, this is unlikely with the addition of date-controlled records.
            if let cellDistanceUnwrap = (self.myModel?.distances[indexPath.row].distance) {
                cell.distanceLabel.text = "\(Int(cellDistanceUnwrap)) meters"
                
            }
            if let cellDateUnwrap = (self.myModel?.distances[indexPath.row].date) {
                cell.dateLabel.text = "Date Achieved: \(cellDateUnwrap.formatted())"
            }
            
        }
        // Configure the cell...

        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.rowHeight = 150
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
