//
//  Item.swift
//  rest
//
//  Created by Omar Osama on 09/08/2023.
//

import UIKit
import Kingfisher

class Item: UIViewController {
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var addToOrderedButton: UIButton!
    var menuItem: MenuItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        ubdateUI()
        

        // Do any additional setup after loading the view.
    }
    func ubdateUI(){
        name.numberOfLines = menuItem!.name.count
        name.text = menuItem!.name
        price.text = menuItem!.price.formatted(.currency(code: "usd"))
        price.numberOfLines = 2
        details.numberOfLines = menuItem!.detailText.count
        details.text = menuItem!.detailText
        Image.kf.setImage(with: URL(string: "http://localhost:8080/images/\(menuItem!.id).png"))
    }
    

    @IBAction func OrderTabbed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.addToOrderedButton.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.addToOrderedButton.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        MenuController.shared.order.menuItems.append(self.menuItem!)
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
