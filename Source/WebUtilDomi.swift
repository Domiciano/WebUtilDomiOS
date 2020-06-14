//
//  WebUtilDomi.swift
//  iOS1FirebaseIntegration
//
//  Created by Domiciano Rincón on 10/06/20.
//  Copyright © 2020 Domiciano Rincón. All rights reserved.
//


import Foundation
import UIKit

class WebUtilDomi{
    
    
    static func doGetRequest(url:String, listener : OnResponseProtocol) {
        let serviceUrl = URL(string: url)
        var request = URLRequest(url: serviceUrl!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = "";
        let session = URLSession.shared
        session.dataTask(with: request) { (data, urlResponse, error) in
                if let data = data {
                    let str = String(decoding: data, as: UTF8.self)
                    listener.onResponse(response: str)
                }
        }.resume()
    }
    
    static func doGetRequest(url:String, onPostExecute: @escaping (String) -> Void) {
        let serviceUrl = URL(string: url)
        var request = URLRequest(url: serviceUrl!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = "";
        let session = URLSession.shared
        session.dataTask(with: request) { (data, urlResponse, error) in
                if let data = data {
                    let str = String(decoding: data, as: UTF8.self)
                    onPostExecute(str);
                }
        }.resume()
    }
    
    
    
    static func loadImage(from url: String, on imageView:UIImageView) {
        let serviceUrl = URL(string: url)!
        URLSession.shared.dataTask(with: serviceUrl){ (data, urlResponse, error) in
            DispatchQueue.main.async {
                guard let data = data else{
                    print("Ningun dato recibido")
                    return
                }
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    static func doPostRequest(to url:String, data json:String, onPostExecute: @escaping (String) -> Void){
        let serviceUrl = URL(string: url)
        var request = URLRequest(url: serviceUrl!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = DomiUtils.str2data(json: json)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, urlResponse, error) in
                if let data = data {
                    let str = String(decoding: data, as: UTF8.self)
                    onPostExecute(str)
                }
        }.resume()
    }
    
}
