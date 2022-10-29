//
//  ViewController.swift
//  PassData
//
//  Created by ashraf on 22/10/2022.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var unwindLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func passDataButton(_ sender: UIButton) {
        let destVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        
        destVC.passedText = textField.text!
        present(destVC, animated: true)
        
    }
    
//    @IBAction func pushNavController(_ sender: Any) {
//        let destVC3 = storyboard?.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdViewController
//
//        if let text = textField.text {
//            destVC3.text = text
//        }
//        navigationController?.pushViewController(destVC3, animated: true)
//    }
    
    @IBAction func unwindToFirst (_ Sender: UIStoryboardSegue) {
        
    }
}
