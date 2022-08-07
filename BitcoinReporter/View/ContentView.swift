//
//  ContentView.swift
//  BitcoinReporter
//
//  Created by Ali Daho on 8/2/22.
// This app is made for how much the petrol in each state. you will think of travelling to.
//

import SwiftUI

struct ContentView: View {
    //@State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State private var selectedCurrency : Int = 0
    @State private var changeHeight : Bool = false
    
    @State private var currencySearching : String = ""
    
    var currencies = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    @ObservedObject var coinModel = CoinManager()
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }) {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 30, weight: .bold))
                }

                Spacer(minLength: 0.1)
                
                TextField("Crypto Symbol", text:$currencySearching)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(width: 274, height: 40, alignment: .trailing)
                .textFieldStyle(.roundedBorder)
                .onTapGesture {
                    self.changeHeight = true
                }
                
                Spacer(minLength: 0.1)
                Button(action: {
                    coinModel.fetchData( cryptoSymbol: self.currencySearching, currency: self.currencies[self.selectedCurrency])
                }
                ) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 30, weight: .bold))
                }

            }
            HStack{
                Label("Crypto Price", systemImage: "bolt.fill")
                Label(String(coinModel.crypto?.rate ?? 0.0), systemImage: "usf")
            }
            NavigationView{
            List{
                Picker(selection: $selectedCurrency, label: Text("Fiat Currency")){
                    ForEach(0 ..< currencies.count, id: \.self) {
                        Text(self.currencies[$0]).tag($0)
                    }
                }
            }
            }.navigationBarTitle(Text("Currencies"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
