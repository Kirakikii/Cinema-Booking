//
//  CinemaPicker.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/9/24.
//

import SwiftUI

struct CinemaPicker: View {
    @Binding var selectedCinema: String
    @Binding var selectedDate: Date
    let cinemas: [String]
    var dateRange: ClosedRange<Date>{
        let today = Date()
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: today)!
        return today...endDate
    }

    var body: some View {
        VStack (spacing:0) {
            HStack {
                
                DatePicker(
                    "Today",
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: .date
                )
                .labelsHidden()
                .accentColor(.pink)
                .padding(.leading, 20)
                
                Picker("Select Cinema", selection: $selectedCinema) {
                    ForEach(cinemas, id: \.self) {cinema in
                        Text(cinema).tag(cinema)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.pink)
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.7))
                .cornerRadius(5)
                .frame(height: 40)
                .frame(maxWidth: .infinity)

                   
            }
            .background(Color.white) // Background for the entire HStack
            .foregroundColor(.white)
            .padding(.horizontal, 0)
            
        }
        .frame(maxWidth: .infinity)
        
    }
        
}

struct CinemaPicker_Previews: PreviewProvider {
    static var previews: some View {
        CinemaPicker(
            selectedCinema: .constant("Choose Cinema"),
            selectedDate: .constant(Date()),
            cinemas: ["Choose Cinema", "Events - Broadway", "Pacific Cinema - Central Park", "Events - Town Hall", "Ritz - Randwick", "Dendy Cinema - Newtown"])
    }
}
