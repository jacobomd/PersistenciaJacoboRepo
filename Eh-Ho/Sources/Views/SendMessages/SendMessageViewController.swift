//
//  SendMessageViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 27/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class SendMessageViewController: UIViewController {
    
    
    @IBOutlet weak var labelUserName: UITextField!
    
    @IBOutlet weak var labelTitle: UITextField!
    
    @IBOutlet weak var labelRaw: UITextField!
    
    var userName: String?
    var ttitle: String?
    var raw: String?

    
    let viewModel: SendMessageViewModel
    var messages: SendNewMessagePrivateResponse?
    
    init(viewModel: SendMessageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mensajes privados"
        labelUserName.text = viewModel.target_usernames

    }

    @IBAction func buttonSendMessage(_ sender: Any) {
        
        userName = labelUserName.text
        ttitle = labelTitle.text
        raw = labelRaw.text
        
        viewModel.didTapInTopic(title: ttitle!, raw: raw!)
    }
    

}

// MARK: - ViewModel Communication

protocol SendMessageViewControllerProtocol: class {
    func sendMessagePrivate()
    func showError(with message: String)
}

extension SendMessageViewController: SendMessageViewControllerProtocol {
    func sendMessagePrivate() {
        showPustMessageSendAlert(message: "Mensaje enviado con exito")
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
}

extension SendMessageViewController {
    
    private func showPustMessageSendAlert(message: String)  {
        //Create the alert
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        //Creamos la accion
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        //Aañadimos a la alerta
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
