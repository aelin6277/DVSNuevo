//
//  CalendarView.swift
//  DVSNuevo
//
//  Created by Elin.Andersson on 2024-06-27.
//
import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var vitaminDays: Set<Date> = []
    private let db = Firestore.firestore()
    
    private let calendar = Calendar.current
    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d."
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                
                Text(monthFormatter.string(from: currentDate))
                    .font(.title)
                    .frame(maxWidth: .infinity)
                
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            
            let days = generateDaysInMonth(for: currentDate)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { date in
                    VStack {
                        Text(dayFormatter.string(from: date))
                            .font(.caption)
                        
                        Button(action: {
                            toggleVitaminDay(date: date)
                        }) {
                            if vitaminDays.contains(date) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .frame(width: 40, height: 40)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                    .padding(5)
                    .background(calendar.isDateInToday(date) ? Color.yellow.opacity(0.3) : Color.clear)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationTitle("Kalender")
        .onAppear {
            fetchVitaminDays()
        }
    }
    
    private func generateDaysInMonth(for date: Date) -> [Date] {
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        
        var days: [Date] = []
        for day in 0..<calendar.range(of: .day, in: .month, for: startOfMonth)!.count {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                days.append(date)
            }
        }
        return days
    }
    
    private func toggleVitaminDay(date: Date) {
        if vitaminDays.contains(date) {
            vitaminDays.remove(date)
            removeVitaminDayFromFirestore(date: date)
        } else {
            vitaminDays.insert(date)
            saveVitaminDayToFirestore(date: date)
        }
    }
    
    private func saveVitaminDayToFirestore(date: Date) {
        let dateString = ISO8601DateFormatter().string(from: date)
        db.collection("vitaminDays").document(dateString).setData([
            "date": dateString
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    private func removeVitaminDayFromFirestore(date: Date) {
        let dateString = ISO8601DateFormatter().string(from: date)
        db.collection("vitaminDays").document(dateString).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    private func fetchVitaminDays() {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let startString = ISO8601DateFormatter().string(from: startOfMonth)
        let endString = ISO8601DateFormatter().string(from: endOfMonth)
        
        print("Fetching vitamin days from \(startString) to \(endString)")
        
        db.collection("vitaminDays").whereField("date", isGreaterThanOrEqualTo: startString).whereField("date", isLessThanOrEqualTo: endString).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                vitaminDays.removeAll()
                for document in querySnapshot!.documents {
                    if let date = ISO8601DateFormatter().date(from: document.data()["date"] as! String) {
                        vitaminDays.insert(date)
                    }
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
/*
import Foundation
import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var vitaminDays: Set<Date> = []

    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                
                Text(currentDate, style: .date)
                    .font(.title)
                
                Button(action: {
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            
            let days = generateDaysInMonth(for: currentDate)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { date in
                    VStack {
                        Text(dateFormatter.string(from: date))
                            .font(.caption)
                        
                        Button(action: {
                            toggleVitaminDay(date: date)
                        }) {
                            if vitaminDays.contains(date) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .frame(width: 40, height: 40)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Kalender")
    }
    
    private func generateDaysInMonth(for date: Date) -> [Date] {
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        
        var days: [Date] = []
        for day in 0..<calendar.range(of: .day, in: .month, for: startOfMonth)!.count {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                days.append(date)
            }
        }
        return days
    }
    
    private func toggleVitaminDay(date: Date) {
        if vitaminDays.contains(date) {
            vitaminDays.remove(date)
        } else {
            vitaminDays.insert(date)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

*/
