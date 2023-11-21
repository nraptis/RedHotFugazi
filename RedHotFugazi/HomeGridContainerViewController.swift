//
//  HomeGridContainerViewController.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit
import Combine

class HomeGridContainerViewController: UIViewController {

    lazy var homeGridViewController: HomeGridViewController = {
        let result = HomeGridViewController(homeGridViewModel: homeGridViewModel)
        result.view.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    @IBOutlet weak var contentContainerView: UIView!
    let homeGridViewModel: HomeGridViewModel
    required init(homeGridViewModel: HomeGridViewModel) {
        self.homeGridViewModel = homeGridViewModel
        
        super.init(nibName: "HomeGridContainerViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentContainerView.backgroundColor = UIColor.clear
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        addHomeGrid()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        homeGridViewController.viewWillTransition(to: size, with: coordinator)
    }
    
    private func addHomeGrid() {
        if let gridView = homeGridViewController.view {
            contentContainerView.addSubview(gridView)
            contentContainerView.addConstraints([
                gridView.leftAnchor.constraint(equalTo: contentContainerView.leftAnchor),
                gridView.rightAnchor.constraint(equalTo: contentContainerView.rightAnchor),
                gridView.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
                gridView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
            ])
        }
    }
}
