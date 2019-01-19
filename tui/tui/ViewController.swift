//
//  ViewController.swift
//  tui
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var departureTF: UITextField!
    @IBOutlet weak var destinationTF: UITextField!
    
    @IBOutlet weak var costLabel: UILabel!
    
    private var viewModel : ViewControllerViewModel!
    private var connectionViewModel: ConnectionViewModel!
    
    var flightConnections = [Connection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewControllerViewModel(environmentName: "production", url: "https://raw.githubusercontent.com/punty/TUI-test/master/")
        viewModel.fetchFlightConnections { [weak self] (connections) in
            self?.connectionViewModel = ConnectionViewModel(connections: connections)
        }
        
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        let from = departureTF.text
        let to = destinationTF.text
        if let from = from, let to = to {
            let cost = connectionViewModel.calculateCheapestFlight(from: from, to: to)
            costLabel.text = String(cost.1)
        }
        
    }
}

extension ViewController: UITextFieldDelegate {
    
}




