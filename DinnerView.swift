//
//  DinnerView.swift
//  JWHousePrototype
//
//  Created by Swathika Ganesh on 2/28/23.
//

import SwiftUI
import FirebaseFirestore

struct DinnerView: View {
    @State var day:Date = .now
    @EnvironmentObject var networkManager: NetworkManager
    @State var menus: [Menu] = []
    func getMainCourse(menu:Menu)->[String]{
       return menu.menuItems[3].components(separatedBy: ", ")
    }
    var body: some View {
        VStack {
            Text("This Week's Dinner Menu").font(.system(size:25)).bold()
            Form {
                ForEach(menus, id: \.self) { menu in
                    Section (header: Text(.init("**Date**: " + menu.menuItems[0]))) {
                        ForEach(getMainCourse(menu: menu), id: \.self ) { item in
                            Text(item)
                        }
                    }
                    VStack {
                        Divider().overlay(.black)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))
                }
            }
        }.onAppear {
            Task{
                networkManager.retrieveFromDatabase(completion: { res in
                    switch(res) {
                    case.success(let menu):
                        var menuList: [Menu] = [];
                        menu.forEach { menuItems in
                            let curDate = (menuItems["Date"] as? Timestamp)?.dateValue() ?? Date()
                               let appetizer = menuItems["Appetizer"] as? String ?? ""
                               let dessert = menuItems["Dessert"] as? String ?? ""
                               let mainCourse = menuItems["Main Course"] as? String ?? ""
                                let dateString = curDate.getDay() + ", " + curDate.getMonth() + " " +  "\(Calendar.current.dateComponents([.day], from: curDate).day ?? 0)"
                                let menu = Menu(date: curDate, menuItems: [dateString, appetizer, dessert, mainCourse])
                                menuList.append(menu)
                            }
                            menus = menuList
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        }
    }
}

struct DinnerView_Previews: PreviewProvider {
    static var previews: some View {
        DinnerView()
    }
}
