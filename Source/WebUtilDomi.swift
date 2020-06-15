//
//  WebUtilDomi.swift
//  iOS1FirebaseIntegration
//
//  Created by Domiciano Rincón on 10/06/20.
//  Copyright © 2020 Domiciano Rincón. All rights reserved.
//


import Foundation
import UIKit

public class WebUtilDomi{
    
    
    private var method:String?
    private var url : String?
    private var body : String?
    private var response : String?
    private var headers : [String:String]?
    private var uiAction : ((String)->Void)?
    private var workerAction : ((String)->Void)?
    
    
    
    private init(){
        headers = [String:String]()
    }
    
    public static func create() -> WebUtilDomi {
        return WebUtilDomi();
    }
    
    //1
    public func withMethod(method:String) -> WebUtilDomi {
        self.method = method;
        return self;
    }
    
    //2
    public func toURL(url:String) -> WebUtilDomi{
        self.url = url;
        return self;
    }
    
    //3*
    public func withBody(json:String) -> WebUtilDomi {
        self.body = json;
        return self;
    }
    
    //4*
    public func setHeader(key:String, value:String) -> WebUtilDomi{
        self.headers?[key] = value
        return self;
    }
    
    //6*
    public func withWorkerEndAction(action: @escaping (String)->Void) -> WebUtilDomi{
        self.workerAction = action
        return self
    }
    //7*
    public func withUIEndAction( action: @escaping (String)->Void ) -> WebUtilDomi {
        self.uiAction = action
        return self
    }
    
    public func execute() {
        
        guard let url=self.url else {
            print("URL is missing")
            return
        }
        let serviceUrl = URL(string: url)
        guard let urlObject=serviceUrl else {
            print("Malformed URL")
            return
        }
        var request = URLRequest(url: urlObject)
        
        guard let method = self.method else {
            print("HTTP Method is missing")
            return
        }
        
        guard let headers = self.headers else {
            return
        }
        //Headers
        for key in headers.keys{
            let value = headers[key]
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpMethod = method
        if let body = self.body {
            request.httpBody = DomiUtils.str2data(json: body)
        } else {
            print("Message will be sent with no body")
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, urlResponse, error) in
                if let data = data {
                    let str = String(decoding: data, as: UTF8.self)
                    if let workerAction = self.workerAction{
                        workerAction(str)
                    }else{
                        print("Method has no workerAction")
                    }
                    if let uiAction = self.uiAction {
                        DispatchQueue.main.async {
                            uiAction(str)
                        }
                    }else{
                        print("Method has no uiAction")
                    }
                    
                    
                }
        }.resume()
    }
    
    public static func loadImage(from url: String, on imageView:UIImageView) {
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
    
}
