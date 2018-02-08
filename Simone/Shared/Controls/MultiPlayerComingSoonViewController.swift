//
//  MultiPlayerComingSoonViewController.swift
//  Simone
//
//  Created by Nicola Giancecchi on 08.02.18.
//  Copyright © 2018 Simone Games, Inc. All rights reserved.
//

import UIKit

class MultiPlayerComingSoonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack() {
        self.performSegue(withIdentifier: "unwindMultiPlayerMode", sender: self)
    }
    
    @IBAction func returnFromSegue(sender: UIStoryboardSegue) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
