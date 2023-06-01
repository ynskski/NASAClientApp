//
//  ContentView.swift
//  NASAClient
//
//  Created by Yunosuke Sakai on 2021/07/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            APODView(
                store: .init(
                    initialState: .init(),
                    reducer: APODReducer()
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
