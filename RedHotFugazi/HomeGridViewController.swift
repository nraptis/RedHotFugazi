//
//  HomeGridViewController.swift
//  PestBlaster
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit
import Combine

class HomeGridViewController: UIViewController {
    
    static let cellIdentifierHomeGridStandardCell = "HomeGrid.HomeGridCollectionViewCell"
    
    var cellDownloadStatusSubscription: AnyCancellable?
    
    lazy var collectionView: UICollectionView = {
        let result = UICollectionView(frame: .zero, collectionViewLayout: GridLayout.createLayout())
        result.translatesAutoresizingMaskIntoConstraints = false
        result.register(HomeGridCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellIdentifierHomeGridStandardCell)
        result.dataSource = self
        result.delegate = self
        result.backgroundColor = UIColor.clear
        (result as UIScrollView).delegate = self
        return result
    }()
    
    let homeGridViewModel: HomeGridViewModel
    required init(homeGridViewModel: HomeGridViewModel) {
        self.homeGridViewModel = homeGridViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        wireUpSubscriptions()
        addCollectionView()
        DispatchQueue.main.async {
            self.handleScrollDidChange()
        }
    }
    
    private func wireUpSubscriptions() {
        cellDownloadStatusSubscription = homeGridViewModel.cellDownloadStatusChangePublisher
            .receive(on: OperationQueue.main)
            .sink { [weak self] cellData in
                if let strongSelf = self {
                    strongSelf.collectionView.reloadItems(at: [.init(row: cellData.index,
                                                                     section: 0)])
                }
            }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // Have the collection view re-layout its cells.
        coordinator.animate(
            alongsideTransition: { [weak self] _ in
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }, completion: nil)
    }
    
    private func addCollectionView() {
        if let selfView = self.view {
            selfView.addSubview(collectionView)
            selfView.addConstraints([
                collectionView.leftAnchor.constraint(equalTo: selfView.leftAnchor),
                collectionView.rightAnchor.constraint(equalTo: selfView.rightAnchor),
                collectionView.topAnchor.constraint(equalTo: selfView.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: selfView.bottomAnchor)
            ])
        }
    }
    
    func handleScrollDidChange() {
        var list = [(index: Int, frame: CGRect)]()
        for visibleCell in collectionView.visibleCells {
            if let homeGridCell = visibleCell as? HomeGridCollectionViewCell {
                if let cellData = homeGridCell.cellData {
                    let frame = homeGridCell.frame
                    let index = cellData.index
                    list.append((index: index,
                                 frame: frame))
                }
            }
        }
        homeGridViewModel.handleScreenContentDidMove(list)
    }
}
