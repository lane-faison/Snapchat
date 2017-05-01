//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Lane Faison on 4/30/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
