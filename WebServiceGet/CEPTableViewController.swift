//
//  CEPTableViewController.swift
//  WebServiceGet
//
//  Created by Calebe on 22/01/2018.
//  Copyright © 2018 Calebe. All rights reserved.
//

/*
 WebService - Aplicação com a premissa de conectar diferentes sistemas.
 
 SOAP: É um protocolo de comunicação que trabalha com XML.
 
 <?xml version="1.0"?>
     <soap:Envelope xmlns:soap="http://www.w3.org/2001/12/soap-envelope" soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
     <soap:Body xmlns:m="http://api.quaddro.com.br/cursos">
         <m:GetQuantidadeDeCursos>
             <m: Quantidade>20</m: Quantidade>
         </m:GetQuantidadeDeCursos>
     </soap:Body>
 </soap:Envelope>

 
 REST: É uma arquitetura de comunicação em cima do protocolo HTTP. Normalmente trabalha com JSON.
 
 XML:
 <?xml version="1.0"? encoding="UTF-8">
 <quantiade>20</quantidade>
 
 JSON:
 {"quantidade": 20}
 
 
 
 O protocolo HTTP:
 
 Uma requisição HTTP é formada por: URI, Porta, Header, Body, Método e Código da Resposta.
 
 -URI:
 
            URL             URN
 _________________________ ______
 http://api.quaddro.com.br/cursos
 
 
 -Porta:
 Normalmente a porta de uma API é a 80 (HTTP) ou 443 (HTTPS). Porém as portas vão de 1 a 65535, sendo as conhecidas de 1 a 1023.
 
 -Header:
 Cabeçalho da requisição, onde as principais informações são transferidas.
 
 Content-Type: Informa o tipo MIME do arquivo enviado no Body.
 Content-Length: Informa o tamanho do body.
 Accept-Language: Informa os idiomar preferidos do client.
 Authorization: Informa a chave de acesso, para APIs com autenticação.
 
 -Body:
 Onde será enviado/recebido os arquivos. JSON, image, audio, ...
 
 -Método:
 Create - POST
 Read   - GET
 Update - PUT
 Delete - DELETE
 
 -Código da Resposta:
 2xx - Sucesso
 3xx - Redirecionamento
 4xx - Erro client
 5xx - Erro server
 */

import UIKit
import Alamofire
import SwiftyJSON

class CEPTableViewController: UITableViewController {

    // MARK: - Propriedades
    let barraPesquisa = UISearchBar()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Adicionar a barra de pesquisa na NavigationBar
        self.navigationItem.titleView = self.barraPesquisa
        
        self.barraPesquisa.placeholder = "Digite um CEP e toque em Search"
        self.barraPesquisa.delegate = self
        
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var labelLogradouro: UILabel!
    @IBOutlet weak var labelComplemento: UILabel!
    @IBOutlet weak var labelBairro: UILabel!
    @IBOutlet weak var labelLocalidade: UILabel!
    @IBOutlet weak var labelUF: UILabel!
    
    // MARK: - Métodos Próprios
    func mostrarCEP(cep: CEP) {
        self.labelUF.text = cep.uf
        self.labelBairro.text = cep.bairro
        self.labelLocalidade.text = cep.localidade
        self.labelLogradouro.text = cep.logradouro
        self.labelComplemento.text = cep.complemento
    }
}

// MARK: - Métodos de UISearchBarDelegate
extension CEPTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Garantia que possuimos um texto digitado
        guard let textoPesquisa = searchBar.text else { return }
        
        // Efetuar um GET, validar a resposta e abrir o JSON
        Alamofire.request("https://viacep.com.br/ws/\(textoPesquisa)/json", method: .get).validate().responseJSON { (resposta) in
            
            switch resposta.result {
            case .success(let value):
                print(value)
                // Objeto do SwiftyJson
                let json = JSON(value)
                // Objeto do CEP
                let cep = CEP(json: json)
                self.mostrarCEP(cep: cep)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
}
