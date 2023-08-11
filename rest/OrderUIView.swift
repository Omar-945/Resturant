//
//  Order.swift
//  rest
//
//  Created by Omar Osama on 09/08/2023.
//

import UIKit

class OrderUITable: UITableViewController {
    var minutesToPrepareOrder = 0
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(tableView!,
               selector: #selector(UITableView.reloadData),
               name: MenuController.orderUpdatedNotification, object: nil)
        
        
          navigationItem.leftBarButtonItem = editButtonItem
            NotificationCenter.default.addObserver(tableView!,
               selector: #selector(UITableView.reloadData),
               name: MenuController.orderUpdatedNotification, object: nil)
        
        

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
        return MenuController.shared.order.menuItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath)
        configure(cell, forItemAt: indexPath)
        
        return cell
    }




    override func tableView(_ tableView: UITableView,
       commit editingStyle: UITableViewCell.EditingStyle,
       forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at:
               indexPath.row)
        }
    }
      
    

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
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = menuItem.price.formatted(.currency(code:
           "usd"))
        cell.contentConfiguration = content
    }
    
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        Task.init {
            do {
                let minutesToPrepare = try await
                   MenuController.shared.submitOrder(forMenuIDs: menuIds)
                minutesToPrepareOrder = minutesToPrepare
                let confirm = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "confirm") as! OrderConfirmationViewControlle
                confirm.minutesToPrepareOrder = minutesToPrepare
                self.navigationController?.pushViewController(confirm, animated: true)
                
            } catch {
                displayError(error, title: "Order Submission Failed")
            }
        }
    }
     
    func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        let alert = UIAlertController(title: title, message:
           error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default,
           handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
      
    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        let orderTotal =
               MenuController.shared.order.menuItems.reduce(0.0)
               { (result, menuItem) -> Double in
                return result + menuItem.price
            }
         
            let formattedTotal = orderTotal.formatted(.currency(code: "usd"))
         
            let alertController = UIAlertController(title:
               "Confirm Order", message: "You are about to submit yourorder with a total of \(formattedTotal)",
               preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Submit",
               style: .default, handler: { _ in
                self.uploadOrder()
            }))
         
            alertController.addAction(UIAlertAction(title: "Cancel",
               style: .cancel, handler: nil))
         
            present(alertController, animated: true, completion: nil)
        }
          
}
