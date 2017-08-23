//
//  PlanesViewModel.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/22/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation
import UIKit


@objc public protocol PlanesViewModelView {
    @objc optional var planesDescriptionLabel: UILabel { get }
    @objc optional var planesImageView: UIImageView { get }
    @objc optional var planesPriceLabel: UILabel { get }
    @objc optional var planesTitleLabel: UILabel { get }
    @objc optional var planesOccupancyLabel: UILabel { get }
    @objc optional var planesAvailableLabel: UILabel { get }
}

public final class PlanesViewModel {
    
    // MARK: - Static Properties
    internal static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    // MARK: - Instance Properties
    public let services: Services
    
    public let descriptionText: String
    //public let imageURL: URL?
    public let priceText: String
    public let titleText: String
    public let available: Bool
    public let occupancy: Int
    
    // MARK: - Object Lifecycle
    public init(service: Services) {
        
        self.services = service
        descriptionText = service.description
        //imageURL = product.imageURL
        titleText = service.title
        occupancy = service.occupancy
        available = service.available
        
        if service.price > 0 {
            let price = PlanesViewModel.numberFormatter.string(from: service.price as NSNumber)!
            priceText = "Only \(price) / hour"
        }  else {
            priceText = "Contact Us for Pricing"
        }
    }
}

extension PlanesViewModel {
    
    public func configure(_ view: PlanesViewModelView) {
       // _ = view.productImageView?.rw_setImage(url: imageURL)
        view.planesPriceLabel?.text = priceText
        view.planesDescriptionLabel?.text = descriptionText
        view.planesTitleLabel?.text = titleText
        view.planesAvailableLabel?.text = String(available)
        view.planesOccupancyLabel?.text = String(occupancy)
        
    }
}
