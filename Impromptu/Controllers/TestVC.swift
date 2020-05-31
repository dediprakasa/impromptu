//
//  TestVC.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/31/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class TestVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButon = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
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
