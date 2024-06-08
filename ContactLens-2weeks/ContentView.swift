//
//  ContentView.swift
//  ContactLens-2weeks
//
//  Created by Fujii Ryosuke on R 6/06/08.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var notificationDate: Date? = nil

    private let service = NotificationService()

    var body: some View {
        VStack {
            Text("2 weeks contact lens notification service")
                .font(.largeTitle)
                .padding()
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .padding()
            Button(action: {
                notificationDate = service.scheduleNotification(for: selectedDate)
            }) {
                Text("Schedule Notification")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if let notificationDate = notificationDate {
                Text("Notification will be sent on: \(notificationDate, formatter: dateFormatter)")
                    .padding()
            }

        }
        .padding()
        .onAppear {
            if let savedDate = service.getScheduledNotificationDate() {
                notificationDate = savedDate
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    ContentView()
}
