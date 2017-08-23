//
//  ServiceDetailController.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/23/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit

class ServiceDetailController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOccupancy: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPlane: UIImageView!
    
    
    // MARK: - Injections
    public var planeViewModel: PlanesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        planeViewModel.configure(self)
        self.navigationController?.navigationItem.title = planeViewModel.titleText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - PlanesViewModelView
extension ServiceDetailController : PlanesViewModelView {
    
    public var planesTitleLabel : UILabel {
        return lblTitle
    }
    
    public var planesDescriptionLabel : UILabel {
        return lblDescription
    }
    
    public var planesPriceLabel : UILabel {
        return lblPrice
    }
    
    public var planesOccupancyLabel : UILabel {
        return lblOccupancy
    }
    
    public var planesImageView : UIImageView {
        return imgPlane
    }
    
}
