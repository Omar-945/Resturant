//
//  OrderConfirmationViewControlle.swift
//  rest
//
//  Created by Omar Osama on 10/08/2023.
//

import UIKit

class OrderConfirmationViewControlle: UIViewController {
    @IBOutlet weak var time: UILabel!
    var minutesToPrepareOrder = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        time.text = minutesToPrepareOrder.formatted() + " minutes"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
