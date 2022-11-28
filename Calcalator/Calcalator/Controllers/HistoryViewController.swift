//
//  HistoryViewController.swift
//  Calcalator
//
//  Created by Дмитрий Корчагин on 25.11.2022.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var historyTextView = UITextView.createBigTextView()
    var sizes = Sizes()
    let userDefaults = UserDefaults.standard
    var f = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        historyTextView.text = userDefaults.string(forKey: "history") ?? ""
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: -methods
    func setUpView(){
        changeNavVC()
        createButtonClearHistory()
        sizes = Sizes(view.bounds.size.width, sizeH: view.bounds.size.height)
        addSubViews()
        createHistoryTextViewConstraint()
    }
    func addSubViews(){
        view.addSubview(historyTextView)
    }
    
    func createButtonClearHistory(){
        let addButton = UIBarButtonItem(title: NSLocalizedString("Clear", comment: "---"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(clearHistory(_:)))
        navigationItem.rightBarButtonItem = addButton
        
    }
    @objc func clearHistory(_ sender: AnyObject){
        historyTextView.text.removeAll()
        UserDefaults.standard.set("-", forKey: "history")
        UserDefaults.standard.set("-", forKey: "text")
        userDefaults.removeObject(forKey: "history")
        userDefaults.removeObject(forKey: "text")
        UserDefaults.standard.removeObject(forKey: "history")
        UserDefaults.standard.removeObject(forKey: "text")
        print(userDefaults.string(forKey: "text"), "\n----")
        print(userDefaults.string(forKey: "history"))
    }
    func createHistoryTextViewConstraint(){
        if let text = userDefaults.string(forKey: "text"){
            historyTextView.text += text
            let t = (userDefaults.string(forKey: "history") ?? "") + text
            UserDefaults.standard.set(t, forKey: "history")
        }
        userDefaults.removeObject(forKey: "text")
        NSLayoutConstraint.activate([
            historyTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            
            historyTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            historyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func changeNavVC(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.placeholderText] // With a red background, make the title more readable.
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance 
        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
    }
}
 
