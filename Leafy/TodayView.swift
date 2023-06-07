//
//  TodayView.swift
//  Leafy
//
//  Created by Alec Agayan on 6/5/23.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        VStack {
            heading
            
            VStack(spacing: 0.0) {
                // Image Header
                ZStack {
                    
                }
                // Action Module
                HStack {
                    
                }
            }
        }
        
        
    }
    var heading: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(getTodayWeekDay().uppercased())
                    .foregroundColor(.gray)
                    .font(.custom("DMSans-Regular", size: 16))
                
                //            Text("Today")
                //                .font(.custom("DMSans-Bold", size: 22))
                //                .font(.title)
                //                .fontWeight(.bold)
                //
                Text("Discover")
                    .font(.custom("DMSans-Bold", size: 30))
                //                .font(.title)
                //                .fontWeight(.bold)
                
            }
            Spacer()
        }
        .padding(16)
    }
}

func getTodayWeekDay()-> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "EEEE, MMMM dd"
       let weekDay = dateFormatter.string(from: Date())
       return weekDay
 }

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
