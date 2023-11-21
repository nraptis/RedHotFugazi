//
//  HomeGridCellData.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class HomeGridCellData {
    var index: Int
    let urlString: String
    init(index: Int, urlString: String) {
        self.index = index
        self.urlString = urlString
    }
}

extension HomeGridCellData: Identifiable {
    var id: Int {
        index
    }
}

extension HomeGridCellData: Hashable {
    static func == (lhs: HomeGridCellData, rhs: HomeGridCellData) -> Bool {
        lhs.index == rhs.index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}
