//
//  DetailTopicViewController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class DetailTopicViewController: UIViewController {

    let viewModel: DetailTopicViewModel
    
    init(viewModel: DetailTopicViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

// VIEWMODEL COMMUNICATION
protocol DetailTopicViewControllerProtocol: class {
    
}

extension DetailTopicViewController: DetailTopicViewControllerProtocol {
    
}
