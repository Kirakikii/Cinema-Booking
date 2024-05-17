import Foundation
import SwiftUI

//control the visibility of tab bar
class ViewRouter: ObservableObject {
    @Published var showTabBar: Bool = true
}

struct ContentView: View {
    @StateObject var viewRouter = ViewRouter()
    @State private var selectedTab: Tab
    
    
    init(selectedTab: Tab = .movies){
        _selectedTab = State(initialValue: selectedTab)
        //set a flag that whether we need to show the tab bar
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View{
        
        VStack(spacing: 0.0){
            
            //genrate the interface 
            
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
        // Providing the viewRouter throughout the app
        .environmentObject(viewRouter)
    }
}
    
    
    struct ContentView_Previews: PreviewProvider{
        static var previews: some View{
            ContentView()
        }
    }

