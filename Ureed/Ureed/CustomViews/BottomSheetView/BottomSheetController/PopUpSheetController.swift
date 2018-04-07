//
//  PopUpSheetController.swift
//  Ureed
//
//  Created by Amjad Private on 11/1/17.
//  Copyright © 2017 Ureed. All rights reserved.
//

import UIKit

class PopUpSheetController: BottomSheet {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupConsrints() {
        ConstraintsHelper.constrainToCenter(parent: view, child: sheetView, childSize: sheetView.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }

}
