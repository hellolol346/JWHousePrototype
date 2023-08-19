//
//  GeneralView.swift
//  JWHousePrototype
//
//  Created by Swathika Ganesh on 2/28/23.
//

import SwiftUI
import Foundation
import UIKit

struct GeneralView: View {
    @State var dinnerHours = ""
    @State var hours = ""
    @State var officeHours = ""
    @State var animal = ""
    var body: some View {
        ScrollView {
            VStack() {
                Text("We support families in need who are going through tough times, providing accomodation and meals for both day use and Overnight")
                    .foregroundColor(Color.orange)
                    .font(.system(size:21))
                Spacer().frame(height: 30)
                Text("**JW House**\n \n3850 Homestead Road \n \nSanta Clara, CA 95051 \n \nPhone: (408) 246-2224\n \n**JW House Administrative Office**\n \n4010 Moorpark Avenue Suite 201\n \nSan Jose, CA 95117\n \nPhone: (408) 606-8545\n")
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                Spacer().frame(height: 20)
                Text(animal).bold()
                    .foregroundColor(Color.red)
                    .font(.system(size:21))
                Spacer().frame(height: 30)
                Text("Day Use Hours:").bold()
                    .padding(EdgeInsets(top:0, leading: 5, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                Text(hours)
                    .padding(EdgeInsets(top:0, leading: 5, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                Spacer().frame(height: 30)
                Group {
                    Text("Dinner Is Served Hours:").bold()
                        .padding(EdgeInsets(top:0, leading: 5, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                    Text(dinnerHours)
                        .padding(EdgeInsets(top:0, leading: 5, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                    Text("Office Hours:").bold()
                        .padding(EdgeInsets(top:0, leading: 5, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                    Text(officeHours)
                        .padding(EdgeInsets(top:0, leading: 5, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                }
            }
        }.onAppear {
            Task {
                NetworkManager.shared.retrieveBusinessHoursFromDatabase(completion:{ result in
                    switch(result) {
                    case .success(let dict):
                        for value in dict {
                            dinnerHours = value["Dinner Hours"] as? String ?? ""
                            dinnerHours = dinnerHours.replacingOccurrences(of: "\\n", with: "\n")
                            hours = value["Hours"] as? String ?? ""
                            hours = hours.replacingOccurrences(of: "\\n", with: "\n")
                            officeHours = value["Office Hours"] as? String ?? ""
                            officeHours = officeHours.replacingOccurrences(of: "\\n", with: "\n")
                            animal = value["Support Animal"] as? String ?? ""
                            animal = animal.replacingOccurrences(of: "\\n", with: "\n")
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                })
            }
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
