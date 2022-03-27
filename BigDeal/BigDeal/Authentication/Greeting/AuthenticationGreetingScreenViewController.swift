//
//  AuthenticationGreetingScreenViewController.swift
//  BigDeal
//
//  Created by Renat Murtazin on 27.03.2022.
//

import UIKit

class AuthenticationGreetingScreenViewController: UIViewController, AuthenticationBaseCoordinated {
    
    var coordinator: AuthenticationBaseCoordinator?
    
    init(coordinator: AuthenticationBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
