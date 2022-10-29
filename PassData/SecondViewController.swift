//
//  SecondViewController.swift
//  PassData
//
//  Created by ashraf on 22/10/2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var passedDataLabel: UILabel!
    @IBOutlet var unwindText: UITextField!
    
    var passedText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        passedDataLabel.text = passedText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! FirstViewController
        if let text = unwindText.text {
            destVC.unwindLabel.text = text
        }
    }
}
