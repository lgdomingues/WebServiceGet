//
//  CEP.swift
//  WebServiceGet
//
//  Created by Swift on 23/01/2018.
//  Copyright © 2018 Calebe. All rights reserved.
//

import UIKit
import SwiftyJSON

class CEP: NSObject {

    var uf: String?
    var cep: String?
    var bairro: String?
    var localidade: String?
    var logradouro: String?
    var complemento: String?

    convenience init(json: JSON) {
        
        self.init()
        
        if let uf = json["uf"].string {
            self.uf = uf
        }
        
        if let cep = json["cep"].string {
            self.cep = cep
        }
        
        if let bairro = json["bairro"].string {
            self.bairro = bairro
        }
        
        if let localidade = json["localidade"].string {
            self.localidade = localidade
        }
        
        if let logradouro = json["logradouro"].string {
            self.logradouro = logradouro
        }
        
        if let complemento = json["complemento"].string {
            self.complemento = complemento
        }
        
    }
    
}
