//
//  SecondViewController.swift
//  LiveCicleUiViewController
//
//  Created by ihan carlos on 21/10/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("< Voltar", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(button)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        view.backgroundColor = .white
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
