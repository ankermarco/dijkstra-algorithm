//
//  ViewController.swift
//  tui
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel : ViewControllerModel!
    var flightConnections = [Connection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewControllerModel(environmentName: "production", url: "https://raw.githubusercontent.com/punty/TUI-test/master/")
        viewModel.fetchFlightConnections { (connections) in
            self.useData(data: connections)
        }
        
    }
    
    
    private func useData(data: [Connection]) {
        print(data)
    }
 

    
}




