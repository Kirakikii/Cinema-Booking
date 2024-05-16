import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var showTabBar: Bool = true
}

struct ContentView: View {
    @StateObject var viewRouter = ViewRouter()
    @State private var selectedTab: Tab
    
    
    init(selectedTab: Tab = .movies){
        _selectedTab = State(initialValue: selectedTab)
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View{
        
        VStack(spacing: 0.0){
            
            TabView(selection: $selectedTab){
                HomeView(viewRouter: viewRouter)
                    .tag(Tab.movies)
                
                TicketsView(viewRouter: viewRouter)
                    .tag(Tab.tickets)
            }
            if viewRouter.showTabBar {
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(viewRouter)  // Providing the viewRouter throughout the app
    }
}
    
    
    struct ContentView_Previews: PreviewProvider{
        static var previews: some View{
            ContentView()
        }
    }

