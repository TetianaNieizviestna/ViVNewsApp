//
//  UIImageView+load.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//

import UIKit
import Alamofire

extension UIImageView {
    
    func  setImage(by url: URL?, withCache: Bool = true, completion: ((DataResponse<UIImage>) -> Void)? = nil) {
        guard let url = url else { return }
        
        if withCache {
            self.af_setImage(withURL: url, placeholderImage: UIImage())
        } else {
            cleanCache(url: url)
            loadImage(fromURL: url)
        }
    }
    
    func  setImage(by string: String?, withCache: Bool = true, completion: ((DataResponse<UIImage>) -> Void)? = nil) {
        guard let string = string else { return }
        setImage(by: URL(string: string), withCache: withCache, completion: completion)
    }
    
    private func cleanCache(url: URL) {
        URLCache.shared.removeAllCachedResponses()
    }
}

extension UIImageView {
    
    func loadImage(fromURL url: URL) {
        let request = URLRequest(url: url)
        self.image = UIImage()
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage())
                }
            }
        }).resume()
    }
    
    func loadImage(from string: String?) {
        guard let str = string, let url = URL(string: str) else { return }
        let request = URLRequest(url: url)
        self.image = UIImage()
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage())
                }
            }
        }).resume()
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.image = image
        }, completion: nil)
    }
    
}
