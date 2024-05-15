import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalViewModel: GlobalViewModel
    
//    init(selectedTab: Tab = .movies){
//        _selectedTab = State(initialValue: selectedTab)
//        UITabBar.appearance().isHidden = true
//    }
    
    var body: some View{
        
        VStack(spacing: 0.0){
            
            TabView(selection: $globalViewModel.selectedIndex){
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("HOME")
                    }
                    .tag(0)
                         
                TicketsView()
                    .tabItem {
                        Image(systemName: "contextualmenu.and.cursorarrow")
                        Text("Ticket")
                    }
                    .tag(1)
            }
            
            //CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
            .environmentObject(GlobalViewModel())
    }
}
