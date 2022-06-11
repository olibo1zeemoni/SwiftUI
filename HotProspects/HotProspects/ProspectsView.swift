//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Olibo moni on 24/05/2022.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    enum ShowIcon {
        case yes, no 
    }

    var showIcon: ShowIcon
    var filter: FilterType
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showInfoAlert = false
    @State private var sortBy = "name"
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .foregroundColor(.secondary)
                            
                        }
                        Spacer()
                        if showIcon == .yes {
                            Label("", systemImage: prospect.isContacted ? "person.fill.checkmark" : "person.fill.questionmark")
                                .foregroundColor(prospect.isContacted ? .green : .secondary)
                            
                        }
                        
                    }
                    .swipeActions(edge: .leading) {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Add reminder", systemImage: "bell")
                            }
                        }
                        
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            prospects.delete(prospect)
                        } label: {
                            Label("Trash", systemImage: "trash")
                        }
                    }
                }
                //.onDelete(perform: prospects.removeItems(at:))
            }
            .alert("Long press to sort.", isPresented: $showInfoAlert, actions: {
                Button("OK"){ }
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr],simulatedData: "Olibo moni\nolibo1zeemoni13@gmail.com", completion: handleScan(result:))
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner = true
                    }label: {
                        Label("scan", systemImage: "qrcode.viewfinder")
                    }
                }
            
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showInfoAlert = true
                    }label: {
                        Label("sort", systemImage: "contextualmenu.and.cursorarrow")
                    }
                    .contextMenu {
                        Button {
                            prospects.sortByName()
                            sortBy = "name"
                        } label: {
                            Label("Name", systemImage: "person.fill")
                        }
                        Button {
                            prospects.sortByOther()
                            sortBy = "id"
                        } label: {
                            Label("Most Recent", systemImage: "clock.arrow.circlepath")
                        }
                    }
                }
            }
            
        }
    }
    
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>){
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
                //guard details.count == 2 else { return }

                let person = Prospect()
                person.name = details[0]
                person.email = details[1]
                prospects.add(person)
        case .failure(let error):
            print("Scanning failed \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect){
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
           // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        //more code to come
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(showIcon: .yes, filter: .none)
            .environmentObject(Prospects())
    }
}
