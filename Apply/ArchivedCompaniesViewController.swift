//
//  ArchivedCompaniesViewController.swift
//  Apply
//
//  Created by Yi Xu on 11/8/20.
//  Copyright © 2020 Yi Xu. All rights reserved.
//

import UIKit

class ArchivedCompaniesViewController: UITableViewController {

    let companiesModel = CompaniesModel.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.reloadData()
    }
    
    
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
        return companiesModel.numberOfArchivedCompanies()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayArchivedCompanies", for: indexPath)
        
        guard let label = cell.textLabel else {
            return cell
        }
        
        guard let subtitle = cell.detailTextLabel else {
            return cell
        }

        // Configure the cell...
       let name = companiesModel.archivedCompany(at: indexPath.row)?.getName()
       let note = companiesModel.archivedCompany(at: indexPath.row)?.getNote()
       let image = companiesModel.archivedCompany(at: indexPath.row)?.getImage()
       
       
       label.text = name
       subtitle.text = note
       
       if let imageName = image {
           if imageName != "Default" {
               
               let manager = FileManager.default
               let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
                      
                      
               let imagePath = url!.appendingPathComponent(imageName)
               
               print(imagePath)
               
               do {
                   cell.imageView?.image = UIImage(data: try Data(contentsOf: imagePath))
                   
               } catch {
                   
               }

           }
       }
        


        return cell
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
