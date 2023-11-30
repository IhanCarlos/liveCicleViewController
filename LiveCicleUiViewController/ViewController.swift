//
//  ViewController.swift
//  LiveCicleUiViewController
//
//  Created by ihan carlos on 19/10/23.
//

import UIKit
import CoreLocation
import UIKit

class MyViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var landscapeConstraints: [NSLayoutConstraint] = []
    var portraitConstraints: [NSLayoutConstraint] = []
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Título da Tela"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite alguma coisa"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clique Aqui", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var advancedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Avançar >", for: .normal)
        button.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func navigate() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delaysContentTouches = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 18
        tableView.backgroundColor = .lightGray
        return tableView
    }()
    
#warning( "Neste método, você normalmente cria a hierarquia de visualização da interface do usuário, Isso é chamado apenas se você não estiver usando um arquivo de interface (Storyboard ou XIB)")
    override func loadView() {
        super.loadView()
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(advancedButton)
        view.addSubview(tableView)
    }
    
#warning( "Este método é chamado assim que a hierarquia de visualização é carregada na memória, geralmente após o método loadView(). É o local onde você deve configurar elementos da interface do usuário, carregar dados e realizar outras inicializações. Este é um ótimo lugar para configurar elementos visuais e realizar tarefas de configuração")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraintsForPortrait()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
#warning( "Este método é chamado antes da UIViewController ser exibida na tela. Você pode usá-lo para executar tarefas que devem ocorrer toda vez que a tela estiver prestes a ser exibida, é útil para garantir que a interface do usuário esteja sempre atualizada")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
#warning( "Este método é chamado após a UIViewController ser totalmente exibida na tela. É um bom local para iniciar tarefas que precisam ser executadas quando a tela já está visível")
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization()
    }
    
#warning( "É chamado quando a UIViewController está prestes a ser retirada da tela, por exemplo, quando o usuário navega para outra tela. Você pode usar este método para limpar recursos ou interromper tarefas em segundo plano.")
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customAlert(mensagem: "Você navegou para outra pagina, os ")
    }
    
#warning( "É chamado após a UIViewController ter sido retirada da tela. É um bom lugar para concluir qualquer tarefa ou limpeza após a tela não estar mais visível.")
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
#warning("Este método é chamado quando a interface do usuário está prestes a ser redimensionada ou reposicionada, É útil para realizar ações que você deseja executar antes das mudanças de layout ocorrerem.")
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        titleLabel.font = .systemFont(ofSize: 30, weight: .black)
    }
    
#warning("Este método é chamado após a interface do usuário ter sido redimensionada ou reposicionada. É útil para executar ações que dependem das mudanças de layout que ocorreram.")
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if button.frame.width > 100 {
            button.backgroundColor = .green
        } else {
            button.backgroundColor = .blue
        }
    }
    
#warning("Estes métodos são chamados antes de ocorrer uma transição de tamanho, como quando o dispositivo é girado. Você pode atualizar a interface com base no novo tamanho da tela.")
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.width > size.height {
            // Transição para o modo paisagem
            setupConstraintsForLandscape()
        } else {
            // Transição para o modo retrato
            setupConstraintsForPortrait()
        }
    }
    
    @objc func buttonTapped() {
        if let text = textField.text {
            titleLabel.text = "Você digitou: \(text)"
        }
    }
    
    func customAlert(mensagem: String) {
        let alert = UIAlertController(title: "Aviso", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupConstraintsForPortrait() {
        NSLayoutConstraint.deactivate(landscapeConstraints)

        // Configurar as constraints no modo retrato (vertical)
        portraitConstraints = [
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            
            advancedButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            advancedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: advancedButton.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]

        // Ativar as constraints no modo retrato
        NSLayoutConstraint.activate(portraitConstraints)
    }
    
    func setupConstraintsForLandscape() {
        
        NSLayoutConstraint.deactivate(portraitConstraints)

        // Configurar as constraints no modo paisagem (horizontal)
        landscapeConstraints = [
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            
            advancedButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            advancedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: advancedButton.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        // Ativar as constraints no modo paisagem
        NSLayoutConstraint.activate(landscapeConstraints)
    }
    
}

    extension MyViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
            }
        }
    }
