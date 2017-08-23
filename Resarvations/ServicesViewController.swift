//
//  ServicesViewController.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/21/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {
    
    
    // MARK: - Injections
    internal var networkClient = NetworkClient.shared
    
    internal var serviceType: Services.ServiceType! {
        didSet {
            title = serviceType.title
        }
    }
  
    // MARK: - Instance Properties
    internal var planesViewModels: [PlanesViewModel] = []
    
    
    // MARK: - Outlets
    @IBOutlet internal var collectionView: UICollectionView! {
        didSet {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(loadPlanes),
                                     for: .valueChanged)
            collectionView.refreshControl = refreshControl
            let layout = collectionView.collectionViewLayout
                as! UICollectionViewFlowLayout
            collectionView.collectionViewLayout =
                CollectionViewCenterFlowLayout(layout: layout)
        }
    }
    
    
    
    
    internal func loadPlanes() {
        collectionView.refreshControl?.beginRefreshing()
        networkClient.getService(
            forType: serviceType,
            success: { [weak self] services in
                guard let weakSelf = self else { return }
                weakSelf.planesViewModels = services.map {PlanesViewModel(service: $0)}
                weakSelf.collectionView.reloadData()
                weakSelf.collectionView.refreshControl?.endRefreshing()
                
            }, failure: { [weak self] error in
                print("Service download failed: \(error)")
                guard let weakSelf = self else { return }
                weakSelf.collectionView.refreshControl?.endRefreshing()
        })
    }
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadPlanes()
    }
    
    
    // MARK: - Segue
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination
            as? ServiceDetailController else { return }
        let indexPath = collectionView.indexPathsForSelectedItems!.first!
        viewController.planeViewModel = planesViewModels[indexPath.row]
    }
    
}


// MARK: - UICollectionViewDataSource
extension ServicesViewController: UICollectionViewDataSource {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return planesViewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "PlaneCell"
        let planeViewModel = planesViewModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! ServicesCollectionViewCell
        planeViewModel.configure(cell)
        return cell
    }
}

