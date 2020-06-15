//
//  DomiUtils.swift
//  iOS1FirebaseIntegration
//
//  Created by Domiciano Rincón on 10/06/20.
//  Copyright © 2020 Domiciano Rincón. All rights reserved.
//

import Foundation


public class DomiUtils{
    public static func data2str(data:Data) -> String{
        let str = String(decoding: data, as: UTF8.self)
        return str
    }
    public static func str2data(json:String) -> Data{
        let data = json.data(using: .utf8)
        return data!
    }
    public static func fromJson<T:Decodable>(data:Data, class:T.Type) -> T? {
        do{
            let decoderdec = JSONDecoder()
            let object = try decoderdec.decode(T.self, from: data)
            return object
        } catch {
            print(error)
            return nil
        }
    }
    public static func fromJson<T:Decodable>(json:String, class:T.Type) -> T? {
        do{
            let data = json.data(using: .utf8)
            let decoderdec = JSONDecoder()
            let object = try decoderdec.decode(T.self, from: data!)
            return object
        } catch {
            print(error)
            return nil
        }
    }
    public static func toJson <T:Encodable> (object : T) -> String {
        let encoderdec = JSONEncoder()
        do{
            let data = try encoderdec.encode(object)
            return DomiUtils.data2str(data: data)
        }catch{
            print(error)
            return "{}"
        }
    }
    public static func toJson(data:Data) -> String{
        let str = String(decoding: data, as: UTF8.self)
        return str
    }
}
