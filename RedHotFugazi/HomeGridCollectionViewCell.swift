//
//  HomeGridCollectionViewCell.swift
//  PestBlaster
//
//  Created by Nicky Taylor on 11/20/23.
//

import SwiftUI

class HomeGridCollectionViewCell: UICollectionViewCell {
    
    lazy var homeGridCell: HomeGridCell = {
        HomeGridCell()
    }()
    
    lazy var hostingController: UIHostingController = {
        let result = UIHostingController(rootView: homeGridCell)
        result.view.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    lazy var loadingView: LoadingView = {
        let result = LoadingView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    lazy var errorView: ErrorView = {
        let result = ErrorView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    lazy var clippedImageView: ClippedImageView = {
        let result = ClippedImageView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    unowned var cellData: HomeGridCellData!
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        addHostingController()
        addLoadingView()
        addErrorView()
        addClippedImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHostingController() {
        if let hostingView = hostingController.view {
            addSubview(hostingView)
            self.addConstraints([
                hostingView.leftAnchor.constraint(equalTo: self.leftAnchor),
                hostingView.rightAnchor.constraint(equalTo: self.rightAnchor),
                hostingView.topAnchor.constraint(equalTo: self.topAnchor),
                hostingView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
    }
    
    func addLoadingView() {
        addSubview(loadingView)
        self.addConstraints([
            loadingView.leftAnchor.constraint(equalTo: self.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.rightAnchor),
            loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addErrorView() {
        addSubview(errorView)
        self.addConstraints([
            errorView.leftAnchor.constraint(equalTo: self.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: self.rightAnchor),
            errorView.topAnchor.constraint(equalTo: self.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addClippedImageView() {
        addSubview(clippedImageView)
        self.addConstraints([
            clippedImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            clippedImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            clippedImageView.topAnchor.constraint(equalTo: self.topAnchor),
            clippedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setup(cellData: HomeGridCellData, homeGridViewModel: HomeGridViewModel) {
        self.cellData = cellData
        if let image = homeGridViewModel.getImage(at: cellData.index) {
            clippedImageView.imageView.image = image
            loadingView.hide()
            errorView.hide()
            clippedImageView.show()
        } else if homeGridViewModel.getError(at: cellData.index) != nil {
            clippedImageView.imageView.image = nil
            loadingView.hide()
            errorView.show()
            clippedImageView.hide()
        } else {
            clippedImageView.imageView.image = nil
            loadingView.show()
            errorView.hide()
            clippedImageView.hide()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clippedImageView.imageView.image = nil
    }
}
