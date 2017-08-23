//
//  Services.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/20/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation


public final class Services {
    
    // MARK: - Constants
    public enum ServiceType: String {
        case planes
        case hotels
        case cars
        
        public var title: String {
            switch self {
            case .planes:
                return NSLocalizedString("planes", comment: "")
            case .hotels:
                return NSLocalizedString("hotel", comment: "")
            case .cars:
                return NSLocalizedString("cars", comment: "")
            }
        }
    }
    
    internal struct Keys {
        static let id = "id"
        static let description = "description"
        static let available = "available"
        static let occupancy = "occupancy"
        static let price = "price"
        static let title = "title"
        static let reviews = "reviews"
        static let type = "type"
    }
    
    internal static var tableName = "services"
    
    // MARK: - Instance Properties
    public let identifier: Int?
    public let description: String
    public let available: Bool
    public let occupancy: Int
    public let price: Int
    public let reviews: Array<Any>
    public let title: String
    public let type: ServiceType
    
    // MARK: - Object Lifecycle
    public init?(json: [String: Any]) {
        
        /*
        let imageURL: URL?
        
        if let imageURLString = json[Keys.imageURL] as? String {
            imageURL = URL(string: imageURLString)
            
        } else {
            imageURL = nil
        }
 */
        
        guard let identifier = json[Keys.id] as? Int,
            let description = json[Keys.description] as? String,
            let available = json[Keys.available] as? Bool,
            let occupancy = json[Keys.occupancy] as? Int,
            let title = json[Keys.title] as? String,
            let reviews = json[Keys.reviews] as? Array<Any>,
            let rawType = json[Keys.type] as? String,
            let price = json[Keys.price] as? Int,
            let type = ServiceType(rawValue: rawType)
            else {
                return nil
        }
        self.identifier = identifier
        self.description = description
        self.available = available
        self.occupancy = occupancy
        self.title = title
        self.type = type
        self.price = price
        self.reviews = reviews
    }
 /*
    public init(imageURL: URL?,
                priceHourly: Double,
                priceSquareFoot: Double,
                productDescription: String,
                title: String,
                type: ServiceType) {
        
        self.identifier = nil
        self.imageURL = imageURL
        self.priceHourly = priceHourly
        self.priceSquareFoot = priceSquareFoot
        self.productDescription = productDescription
        self.title = title
        self.type = type
    }
 */
    
    // MARK: - Class Constructors
    public class func array(jsonArray: [[String: Any]]) -> [Services] {
        var array: [Services] = []
        for json in jsonArray {
            guard let service = Services(json: json) else { continue }
            array.append(service)
        }
        return array
    }
}
