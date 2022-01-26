//
//  ContentView.swift
//  Univert
//
//  Created by Eduardo Prado Ruiz on 25/01/22.
//

import SwiftUI

@available(iOS 15.0, *)

enum Units: String, CaseIterable {
    case celcius = "Celcius"
    case farenheit = "Farenheit"
    case kelvin = "kelvin"
}

struct ContentView: View {
    let units = ["Celcius","Farenheit","Kelvin"]
    let numOfUnits = Units.allCases.count
    @State var unitA:Units = .celcius
    @State var unitB:Units = .celcius
    @State var valueA:Double = 0.0
    @State var valueB:Double = 0.0
    
    // c to f : (0°C × 9/5) + 32 = °F
    // c to k : 0°C + 273.15 = K
    // f to k : (32°F − 32) × 5/9 + 273.15 = K
    // k to f : (0K − 273.15) × 9/5 + 32 = °F

    var unitConversion:Double {
        switch unitA {
        case .celcius:
            switch unitB {
            case .celcius:
                return valueA
            case .farenheit:
                return (valueA * (9/5)) + 32
            case .kelvin:
                return valueA + 273.15
            }
        case .farenheit:
            switch unitB {
            case .celcius:
                return ((valueA - 32) * 5/9 )
            case .farenheit:
                return valueA
            case .kelvin:
                return ((valueA - 32) * 5/9 + 273.15)
            }
        case .kelvin:
            switch unitB {
            case .celcius:
                return (valueA - 273.15)
            case .farenheit:
                return ((valueA - 273.15) * 9/5) + 32
            case .kelvin:
                return valueA
            }
        }
    }
    
    
    var body: some View {
        Form {
            Section {
                HStack{
                    
                    TextField("From", value: $valueA, format: .number)
                    Divider()
                    
                    Picker("UnitA", selection: $unitA) {
                        ForEach(Units.allCases,  id:\.self){
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(.menu)
                    Text("To")
                    Picker("UnitB", selection: $unitB) {
                        ForEach(Units.allCases,  id:\.self){
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(.menu)
                    Divider()
                    Text(unitConversion, format: .number)
                        .padding()
                }
            }
            Section{
                
            }
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
