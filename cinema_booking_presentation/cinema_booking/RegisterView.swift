import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.dismiss) var dismiss
    @State var user  = ""
    @State var pwd  = ""
    @State var showAlert : Bool = false
    @State var alertText = ""
    @State var showNet = false
    var body: some View {
        NavigationView {
            VStack{
                //insert logo image to the screen
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                    .clipped()
                    .cornerRadius(50)
                Spacer()
                
                //create the textfield of username
                HStack(alignment: .center, spacing: 17) {
                    Text("Username")
                        
                    TextField("Please input a username" , text:$user)
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                }
                .padding(.leading,20)
                
                //create the textfield of password
                HStack(alignment: .center, spacing: 20) {
                    Text("Password")
                    SecureField("Please input a password" , text:$pwd )
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                        
                }
                .padding(.leading,20)
                
                //test the input from user
                Button {
                    if user.count == 0 || pwd.count == 0{
                        self.showAlert = true
                        alertText = "user or password nil"
                        return
                    }
                    Task {
                        showNet = true
                        let result = await userVM.register(user: user, pwd: pwd)
                        showNet = false
                        self.showAlert = true
                        if result {
                            alertText = "register success"
                        } else {
                            alertText = "register erro"
                        }
                    
                    }
                   
                   
                } label: {
                    Text("Register")
                        .frame(width: 200, height: 40, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                }
                .cornerRadius(8)
                .padding(.top,30)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText), dismissButton: Alert.Button.default(Text("OK"), action: {
                        //give feedback to user to tell them register success
                        if alertText ==  "register success"{
                            dismiss()
                        }
                    }))
                }
             
                Spacer()
                
            }
            .padding(.top,100)
            .navigationBarTitle("Register",displayMode: .inline)
            .withLoading(showAlert: $showNet, msg: .constant("Loading"))
        }
        
    }
}

#Preview {
    RegisterView()
}
