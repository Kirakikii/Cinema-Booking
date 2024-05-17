import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack{
            
            HStack{
                TabBarButton(icon: "film", label: "Movies", isSelected: selectedTab == .movies) {
                    selectedTab = .movies
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity)
                
                
                TabBarButton(icon: "ticket", label: "Tickets", isSelected: selectedTab == .tickets) {
                    selectedTab = .tickets
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity)
            }
             
            .background(Color.indigo)
            .foregroundColor(.white)
            .padding(.bottom, 20)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
        



struct TabBarButton: View{
    let icon: String
    let label: String
    var isSelected: Bool
    let action: () -> Void
    
    var body: some View{
        Button(action: action) {
            VStack{
                Image(systemName: icon)
                    .font(.system(size: 28))
                Text(label)
            }
        }
        .foregroundColor(isSelected ? .pink : .white)
    }
}

enum Tab {
    case movies
    case tickets
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.movies))
    }
}
