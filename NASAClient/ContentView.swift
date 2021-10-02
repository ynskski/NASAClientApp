//
//  ContentView.swift
//  NASAClient
//
//  Created by Yunosuke Sakai on 2021/07/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        APOTodayView(
            store: .init(
                initialState: .init(),
                reducer: APOTodayReducer,
                environment: APODTodayEnvironment(
                    client: .init(session: .shared),
                    imageLoader: .init(session: .shared),
                    mainQueue: .main
                )
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
