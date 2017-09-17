//
//  SquaredViewController.swift
//  Simone
//
//  Created by Nicola on 12/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class SquaredViewController: UIViewController, SquaredViewProtocol {

    @IBOutlet var btnFirst : UIButton!
    @IBOutlet var btnSecond : UIButton!
    @IBOutlet var btnThird : UIButton!
    @IBOutlet var btnFourth : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapFirst() {
        
    }

    @IBAction func didTapSecond() {
        
    }
    
    @IBAction func didTapThird() {
        
    }
    
    @IBAction func didTapFourth() {
        
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
