//
//  HomeGridViewController+UIScrollViewDelegate.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

extension HomeGridViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleScrollDidChange()
    }
}
