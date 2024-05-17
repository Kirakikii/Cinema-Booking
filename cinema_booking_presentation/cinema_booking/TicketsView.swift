

import SwiftUI

//Define the model for Ticket
struct Ticket: Identifiable{
    let id: String
    let filmName: String
    let cinema: String
    let date: Date
    let time: String
    let seat: String
    let image: String
    let documentID: String
}


struct TicketsView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    @ObservedObject var viewRouter: ViewRouter
    @AppStorage("movieDetail") var movieDetailData: String = ""
    
    @State private var tickets = [Ticket]()
    
    
    
    var body: some View {
        VStack (spacing:0){
            TicketsNavBarView
            
            List{
                ForEach(tickets) {ticket in
                    HStack {
                        Image(ticket.image)
                            .resizable()
                            .frame(width:110, height:150)
                            .cornerRadius(5)
                            .padding()
                        
                        VStack(alignment: .leading) {
                
                            Text("\(ticket.cinema)")
                            Text("\(ticket.date)")
                            Text("\(ticket.time)")
                            Text("\(ticket.seat)")
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .onDelete(perform: deleteTicket)
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
        .task{
            tickets = await userVM .getAllTickets() // Fetch tickets from database
        }
    }
    
    func deleteTicket(at offsets: IndexSet){
        offsets.forEach({
            index in
           _ = userVM.removeTickets(ticket: tickets[index])
        })
        tickets.remove(atOffsets: offsets)
    }
    
    
    
    var TicketsNavBarView: some View {
        VStack {
            HStack{
            
                Spacer()
                Text("Tickets")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                Spacer()
                
            }
            
            .padding(.vertical, 25)
            .padding(.bottom, 0)
            .background(Color.indigo)
        }
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewRouter = ViewRouter()
        
        
        TicketsView(viewRouter: viewRouter)
            .environmentObject(viewRouter)
    }
}


