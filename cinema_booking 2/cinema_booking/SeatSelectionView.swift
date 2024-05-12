//
//  SeatSelectionView.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI

struct SeatSelectionView: View {
    @State private var selectedSeats: Set<String> = []
    @State private var showingSummary = false
    @Environment(\.presentationMode) var presentationMode

    let rows = ["A", "B", "C", "D"]
    let columns = 1...10
    let seatPrice = 15

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
            
            if showingSummary {
                summaryCard
            }
        }
        .navigationBarBackButtonHidden(true)  // 尝试在这里隐藏返回按钮
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
                        backButton.opacity(0) // 使标题保持居中
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
                                .foregroundColor(selectedSeats.contains(seatID) ? .white : .black)
                                .background(selectedSeats.contains(seatID) ? Color.green : Color.gray)
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
            self.presentationMode.wrappedValue.dismiss()
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
    
    
    var confirmButton: some View{
        Button("Confirm") {
            showingSummary = !selectedSeats.isEmpty
        }
        .disabled(selectedSeats.isEmpty)
        .font(.headline)
        .padding()
        .padding(.horizontal, 60)
        .foregroundColor(.white)
        .background(selectedSeats.isEmpty ? Color.gray : Color.indigo)
        .cornerRadius(10)
    }
    

                
                
                
    private func toggleSeat(seatID: String) {
        if selectedSeats.contains(seatID) {
            selectedSeats.remove(seatID)
        } else {
            selectedSeats.insert(seatID)
        }
    }

    var summaryCard: some View {
        VStack {
            Spacer()
            VStack {

                VStack(spacing: 20) {
                    
                    Text("Date: \(Date(), formatter: itemFormatter)")
                    Text("Location: Cinema 1")
                    Text("Seat: \(selectedSeats.joined(separator: ", "))")
                    Text("Total Price: $\(selectedSeats.count * seatPrice)")
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

struct SeatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectionView()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
