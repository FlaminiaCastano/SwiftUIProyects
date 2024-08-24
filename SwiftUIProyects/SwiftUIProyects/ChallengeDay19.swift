//
//  ChallengeDay19.swift
//  SwiftUIProyects
//
//  Created by Flaminia Castaño on 24/08/2024.
//

import SwiftUI

enum LenghtUnit: String, CaseIterable {
    case meters, kilometers, feet, yards, miles
    
    var unit: UnitLength {
        switch self {
        case .meters: return .meters
        case .kilometers: return .kilometers
        case .feet: return .feet
        case .yards: return .yards
        case .miles: return .miles
        }
    }
    
    func toMeters(value: Double) -> Double {
        switch self {
        case .meters:
            return value
        case .kilometers:
            return value * 1000
        case .feet:
            return value * 0.3048
        case .yards:
            return value * 0.9144
        case .miles:
            return value * 1609.34
        }
    }
    
    func fromMeters(value: Double) -> Double {
        switch self {
        case .meters:
            return value
        case .kilometers:
            return value / 1000
        case .feet:
            return value / 0.3048
        case .yards:
            return value / 0.9144
        case .miles:
            return value / 1609.34
        }
    }
}

struct ChalengeDay19: View {
    @State private var inputUnit: LenghtUnit = .meters
    @State private var outputUnit: LenghtUnit = .meters
    @State private var inputValue: String = ""
    
    var convertedValue: Double? {
        guard let value = Double(inputValue) else { return nil }
        let baseValue = inputUnit.toMeters(value:value)
        return outputUnit.fromMeters(value: baseValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select the original lenght") {
                    Picker("Original Lenght", selection: $inputUnit) {
                        ForEach(LenghtUnit.allCases, id:\.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Select the final lenght (use '.' for decimal separator)") {
                    Picker("Final Lenght", selection: $outputUnit) {
                        ForEach(LenghtUnit.allCases, id:\.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter your lenght to convert") {
                    TextField("Enter value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section("Result") {
                    if let result = convertedValue {
                        Text("Converted Value: \(result, specifier: "%.2f") \(outputUnit.rawValue)")
                    } else {
                        Text("Invalid input")
                    }
                }
            }
        }
    }
}

#Preview {
    ChalengeDay19()
}

