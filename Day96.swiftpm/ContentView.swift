import SwiftUI

struct ContentView: View {
    @FocusState private var focusedField: FocusedField?
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Enter your username", text: $username)
                .focused($focusedField, equals: .username)
                
            SecureField("Enter your password", text: $password)
                .focused($focusedField, equals: .password)
//            Button("Toggle Focus") {
//                isUsernameFocused.toggle()
//            }
        }
        .onSubmit {
            if focusedField == .username {
                focusedField = .password
            }
        }
    }
    
    enum FocusedField {
        case username, password
    }
}

