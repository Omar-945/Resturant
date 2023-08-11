//
//  Catogory.swift
//  rest
//
//  Created by Omar Osama on 09/08/2023.
//

import UIKit
@MainActor
class Catogory: UITableViewController {
    var categories:[String] = []
    var menuItems:[MenuItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init {
                    do {
                        let categories = try await
                        MenuController.shared.fetchCategories()
                        updateUI(with: categories)
                    } catch {
                        displayError(error, title: "Failed to Fetch Categories")
                    }
            
            
                }
        

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
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
       configureCell(cell, forCategoryAt: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "menu")as! MenuTable
        let index : Int = tableView.indexPathForSelectedRow!.row
        screen.category = categories[index]
        self.navigationController?.pushViewController(screen, animated: true)
        
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


    
    func updateUI(with categories:[String])
    {
        self.categories = categories
        self.tableView.reloadData()
    }

    func displayError( _ error : Error , title : String)
    {
          guard let _ = viewIfLoaded?.window else { return }
                let alert = UIAlertController(title: title, message:
                   error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                   style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    func configureCell(_ cell : UITableViewCell, forCategoryAt indexPath : IndexPath)
    {
        let category = categories[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = category.capitalized
        cell.contentConfiguration = content
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let menu = segue.destination as! MenuTable
//        menu.category = self.categories[tableView.indexPathForSelectedRow!.row]
//    }
//

    }

