//
//  TabBar.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .movies
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View{
        
        VStack(spacing: 0.0){
            
            TabView(selection: $selectedTab){
                HomeView()
                    .tag(Tab.movies)
                            
                BookingsView()
                    .tag(Tab.bookings)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
