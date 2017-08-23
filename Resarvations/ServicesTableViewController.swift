//
//  ServicesTableViewController.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/21/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit

class ServicesTableViewController: UITableViewController {
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
    //Unwind Segue
    @IBAction func unwindToHomeVC(segue:UIStoryboardSegue) {
        
    }
    
    
    // MARK: - UITableViewDelegate
    private struct SegueIdentifiers {
        static let planes = "planes"
        static let cars = "cars"
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ServicesViewController else { return }
        
        if segue.identifier == SegueIdentifiers.planes {
            viewController.serviceType = .planes
            
        } else if segue.identifier == SegueIdentifiers.cars {
            viewController.serviceType = .cars
            
        } else {
            fatalError("Unknown ServicesViewController segue identifier: " +
                "\(String(describing: segue.identifier))")
        }
    }
    
    public override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
