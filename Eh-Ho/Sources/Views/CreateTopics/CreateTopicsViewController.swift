//
//  CreateTopicsViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class CreateTopicsViewController: UIViewController {

    @IBOutlet weak var textfieldTitulo: UITextField!
    
    @IBOutlet weak var textfieldDescripcion: UITextField!
    
    let viewModel: CreateTopicsViewModel
    var topics: AddNewTopicResponse?
    
    var textTitle: String?
    var textDescription: String?
    
    init(viewModel: CreateTopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldTitulo.placeholder = "Introduce el titulo"
        textfieldDescripcion.placeholder = "Intoduce la descripcion ..."

        self.title = "Crear topics"
    }

    @IBAction func buttonCrearTopic(_ sender: Any) {
        
        textTitle = textfieldTitulo.text
        textDescription = textfieldDescripcion.text
        
        if (textfieldTitulo.text!.count < 15) {
            showPustTopicAlert(message: "Introduzca más de 15 caracteres en titulo")
        }else if (textfieldDescripcion.text!.count < 20) {
            showPustTopicAlert(message: "Introduzca más de 20 caracteres en descripción")
        }else {
            viewModel.didTapInTopic(title: textTitle!, raw: textDescription!)
            textfieldTitulo.text = ""
            textfieldDescripcion.text = ""
        }
        

    }
}

// VIEWMODEL COMMUNICATION
protocol CreateTopicsViewControllerProtocol: class {
    
    func createNewTopic()
    func showError(with message: String)
}

extension CreateTopicsViewController: CreateTopicsViewControllerProtocol {
    func createNewTopic() {
        showPustTopicAlert(message: "Topic creado con exito")
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        showPustTopicAlert(message: "Se ha producido un errorr al crear el topic")
    }
    
}

extension CreateTopicsViewController {
    
    private func showPustTopicAlert(message: String)  {
        //Create the alert
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        //Creamos la accion
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        //Aañadimos a la alerta
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


