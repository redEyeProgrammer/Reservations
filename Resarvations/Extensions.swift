//
//  Extensions.swift
//  Resarvations
//
//  Created by redEyeProgrammer on 8/20/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation
import UIKit




//Mark: ImageView
extension UIImageView {
    
    // MARK: - Constants
    private struct AssociationKey {
        static var dataTask = "rw_dataTask"
        static var session = "rw_imageDownloadSession"
    }
    
    // MARK: - Static Properties
    public static let imageDownloader = URLSession(configuration: .default)
    
    // MARK: - Instance Properties
    public var dataTask: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &AssociationKey.dataTask) as? URLSessionDataTask
            
        } set {
            dataTask?.cancel()
            objc_setAssociatedObject(self, &AssociationKey.dataTask, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Instance Methods
    @discardableResult public func rw_setImage(url: URL?) -> URLSessionDataTask? {
        guard let url = url else {
            self.dataTask = nil
            image = nil
            return nil
        }
        let dataTask = UIImageView.imageDownloader.dataTask(
            with: url, completionHandler: { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                guard let data = data, let image = UIImage(data: data) else {
                    print("Image download failed: \(String(describing: error))")
                    strongSelf.image = nil
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.image = image
                }
        })
        dataTask.resume()
        self.dataTask = dataTask
        return dataTask
    }
}



//Mark: Ints
extension Int {
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}


//Mark: UIViewControllers
extension UIViewController {
    
    private struct AssociationKey {
        static var loadingHUD = "rw_loadingHUD"
    }
    
    public var loadingHUD: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociationKey.loadingHUD) as? UIView
        } set {
            objc_setAssociatedObject(self, &AssociationKey.loadingHUD, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func showLoadingHUD(_ animated: Bool = true) {
        
        guard self.loadingHUD == nil else { return }
        view.isUserInteractionEnabled = false
        
        let loadingHUD = LoadingHUD.instanceFromNib()
        self.loadingHUD = loadingHUD
        view.addSubview(loadingHUD)
        
        loadingHUD.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        loadingHUD.frame.origin.x = (view.frame.width - loadingHUD.frame.width) / 2
        loadingHUD.frame.origin.y = (view.frame.height - loadingHUD.frame.height) / 2
        
        guard animated else { return }
        
        loadingHUD.alpha = 0.0
        UIView.animate(withDuration: 0.33) {
            loadingHUD.alpha = 1.0
        }
    }
    
    public func dismissLoadingHUD(_ animated: Bool = true) {
        
        guard let loadingHUD = loadingHUD else { return }
        view.isUserInteractionEnabled = true
        
        let closure: (Bool) -> Void = { [weak self] _ in
            guard let strongSelf = self else { return }
            loadingHUD.removeFromSuperview()
            strongSelf.loadingHUD = nil
        }
        guard animated else {
            closure(true)
            return
        }
        UIView.animate(withDuration: 0.33, animations: {
            loadingHUD.alpha = 0.0      
        }, completion: closure)
    }
}



