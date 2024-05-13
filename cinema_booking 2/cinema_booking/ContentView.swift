import Foundation
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab
    
    init(selectedTab: Tab = .movies){
        _selectedTab = State(initialValue: selectedTab)
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View{
        
        VStack(spacing: 0.0){
            
            TabView(selection: $selectedTab){
                HomeView()
                    .tag(Tab.movies)
                
                
                            
                TicketsView()
                    .tag(Tab.tickets)
            }
            
            //CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
