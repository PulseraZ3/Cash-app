//
//  DashboardView.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import SwiftUI

struct DashboardView: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 4 ){
            Text("Total expenses")
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
