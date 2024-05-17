import SwiftUI

struct SeatSelectionView: View {
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State private var seat: Set<String> = []
    @State private var showingSummary = false
    @State private var createNewBook = false
    
    let film: Film
    let selectedDate: Date
    let selectedTime: String
    
    let rows = ["A", "B", "C", "D"]
    let columns = 1...10
    let seatPrice = 15
    @State var showNet = false
    var body: some View {
        ZStack {
            VStack {
                CustomNavBarView
                
                Text("Screen")
                    .font(.headline)
                    .padding(.horizontal, 150)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .background(Color.brown)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 80)
                
                seatGrid
                    .padding(.top, 80)
                
                legend
                    .padding(.top, 40)
                
                Spacer()
                
                confirmButton
                    .padding(.top, 20)
            }
            .blur(radius: showingSummary ? 20 : 0)
            .animation(.easeInOut, value: showingSummary)
            .onAppear {
                viewRouter.showTabBar = false
            }
            .onDisappear {
                viewRouter.showTabBar = false
            }
            
            if showingSummary {
                summaryCard
            }
        }
        .withLoading(showAlert: $showNet, msg: .constant("Loading"))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        
        
    }
        
        var CustomNavBarView: some View {
            VStack {
                HStack {
                    backButton
                    Spacer()
                    Text("Seat Selection")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                    backButton.opacity(0) // Keep the title centered
                }
                .padding()
                .padding(.horizontal, 40)
                .background(Color.indigo)
            }
        }
        
        var seatGrid: some View{
            VStack {
                ForEach(rows, id: \.self) { row in
                    HStack {
                        ForEach(columns, id: \.self) { column in
                            let seatID = "\(row)\(column)"
                            Button(action: {
                                toggleSeat(seatID: seatID)
                            }) {
                                Text(seatID)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(seat.contains(seatID) ? .white : .black)
                                    .background(seat.contains(seatID) ? Color.green : Color.gray)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            
        }
        
        var backButton: some View{
            Button(action:{
                //action for back button - back to previous screen
                dismiss()
            }){
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .padding(10)
            }
            
            
        }
        
        var legend: some View{
            HStack {
                LegendColor(color: Color.gray, text: "Available")
                LegendColor(color: Color.green, text: "Selected")
            }
        }
        
        
    var confirmButton: some View {
        Button(action: {
            if !seat.isEmpty {
                let ticket = Ticket(id: UUID().uuidString, filmName: film.filmName, cinema: film.filmName, date: selectedDate, time: selectedTime, seat: seat.joined(separator: ","), image: film.imageName,documentID: "")
                showNet = true
                let result = userVM.addTickets(ticket: ticket)
                showNet = false
                if result {
                    showingSummary = true  // Trigger the summary view
                }
                

            }
        }) {
            Text("Confirm")
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(seat.isEmpty ? Color.gray : Color.indigo)  // Conditional background color based on the selection
                .cornerRadius(10)
        }
        .disabled(seat.isEmpty)
        .padding(.horizontal, 60)
    }
        
        
        
        
        
        private func toggleSeat(seatID: String) {
            if seat.contains(seatID) {
                seat.remove(seatID)
            } else {
                seat.insert(seatID)
            }
        }
        
        
        
        var summaryCard: some View {
            VStack {
                Spacer()
                VStack {
                    
                    VStack(spacing: 20) {
                        // Generate booking details
                        Text("Date: \(Date(), formatter: itemFormatter)")
                        Text("Location: Cinema 1")
                        Text("Seat: \(seat.joined(separator: ", "))")
                        Text("Total Price: $\(seat.count * seatPrice)")
                        NavigationLink(destination: BookingConfirmView()){
                            Text("Check out")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.indigo)
                                .cornerRadius(10)
                                .padding(.top, 25)
                        }
                        
                    }
                    .padding(50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .frame(width: 300, height: 200)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
            }
            .edgesIgnoringSafeArea(.all)
            .onTapGesture{
                withAnimation{
                    showingSummary = false
                }
            }
        }
    }
    // Seat colour generation upon user input
    struct LegendColor: View {
        let color: Color
        let text: String
        
        var body: some View {
            HStack {
                Rectangle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                    .cornerRadius(4)
                Text(text)
                    .font(.caption)
            }
        }
    }

    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    

