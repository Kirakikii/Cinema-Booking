import SwiftUI

struct BookingConfirmView: View {
    let seat: Set<String> = []
    
    var body: some View {
        VStack{
            ConfirmNavBarView
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width:100, height:100)
                .foregroundColor(.green)
            
            Text("Your booking is confirmed")
                .font(.title)
                .padding()
            
            Spacer()
            
            NavigationLink(destination: ContentView(selectedTab: .tickets)){
                Text("Go to 'Tickets'")
                    .foregroundColor(.white)
                    .padding(20)
                    .font(.headline)
                    .padding(.horizontal, 60)
                    .background(Color.indigo)
                    .cornerRadius(10)
            }
            .padding(.bottom, 40)
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

var ConfirmNavBarView: some View {
    VStack {
        HStack{
           
            Spacer()
            
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            
        }
        .padding()
        .padding(.horizontal, 40)
        .background(Color.indigo)
    }
}

var backButton: some View{
    Button(action:{
        
    }){
        Image(systemName: "chevron.left")
            .foregroundColor(.white)
            .padding(10)
    }

    
}

