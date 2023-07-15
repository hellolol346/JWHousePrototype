//
//  ContentView.swift
//  JWHousePrototype
//
//  Created by Swathika Ganesh on 2/23/23.
//

import SwiftUI


struct ContentView: View {
    @State private var generalTapped:Bool = false
    @State private var dinnerTapped:Bool = false
    @State var onGeneralInformation = false
    @State var onDinnerMenu = false;
    @EnvironmentObject var networkManager: NetworkManager
    var body: some View {
        NavigationStack {
                VStack {
                    Image("IMG_0560")
                    Text("Welcome to JW House").foregroundColor(Color.red)
                        .font(.title3)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius:16)
                                .stroke(.green, lineWidth:2)
                        )
                    Text("A Home away from home")
                        .font(.callout)
                        .bold()
                        .padding(EdgeInsets(top: 5, leading:50, bottom:16, trailing:50))
                        .background(.orange)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius:8
                            )
                        )
                    Text("We welcome famililies and individuals from area hospitals into our family for rest and self-care during the say or overnight").padding(EdgeInsets(top: 5, leading:5, bottom:5, trailing:5)).border(.gray)
                    HStack {
                        Button(action: {
                            onGeneralInformation = true;
                        }) {
                            Text("General Information")
                                .frame(maxWidth:.infinity)
                                .frame(maxHeight: 200)
                                .padding()
                        }
                        .navigationDestination(isPresented: $onGeneralInformation) {
                            GeneralView()
                        }
                        .foregroundColor(.black)
                        .background( Color.yellow)
                        .opacity(self.generalTapped ? 0.7 : 1)
                        .cornerRadius(8)
                        .bold()
                        .pressAction {
                            generalTapped = true
                        } onRelease: { generalTapped = false
                        }
                        
                        Button(action: {
                            onDinnerMenu = true;
                        }){
                            Text("Dinner Menu").frame(maxWidth:.infinity)
                                .frame(maxHeight: 200)
                                .padding()
                        }
                        .navigationDestination(isPresented: $onDinnerMenu) {
                            DinnerView().environmentObject(networkManager)
                        }
                        .foregroundColor(.black)
                        .background( Color.purple)
                        .opacity(self.dinnerTapped ? 0.7 : 1)
                        .cornerRadius(8)
                        .bold()
                        .pressAction {
                            dinnerTapped = true
                        } onRelease: { dinnerTapped = false
                        }
                    }.onAppear{
                        Task {
                            NetworkManager.shared.connectWithFirebase()
                        }
                    }
                }
            }
    }
}
extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NetworkManager.shared)
    }
}
struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}
