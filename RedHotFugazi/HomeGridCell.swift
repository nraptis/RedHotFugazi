//
//  HomeGridCell.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import SwiftUI

struct HomeGridCell: View {
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    HStack {
                        Spacer()
                        VStack() {
                            Spacer()
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 14.0))
            }
            .background(RoundedRectangle(cornerRadius: 14.0).foregroundColor(.mauve))
            .padding(.all, 1.0)
        }
        .background(RoundedRectangle(cornerRadius: 14.0).foregroundColor(.ghost))
        .shadow(color: .black, radius: 3.0)
    }
}

#Preview {
    HomeGridCell()
}
