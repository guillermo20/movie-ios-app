//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/18/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import UIKit
import MovieDBRepository

class MoviesViewController: UIViewController, MoviesViewDelegate {
    
    
    // repository should be injected with a dependency injector.
    private let presenter = MoviesPresenter(repository: DependencyInjector.dependencies.resolveRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presenter.setViewDelegate(viewDelegate: self)
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
