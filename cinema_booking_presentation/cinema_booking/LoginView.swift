

import SwiftUI


struct LoginView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State var user  = ""
    @State var pwd  = ""
    @State var showAlert : Bool = false
    @State var alertText = ""
    @State var showNet = false
    var body: some View {
        NavigationView {
            VStack{
                //1user
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                    .clipped()
                    .cornerRadius(50)
                
                Spacer()
                HStack(alignment: .center, spacing: 10) {
                    Text("Username")
                        
                        
                    TextField("Input username" , text:$user)
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                }
                .padding(.leading,20)
                
                //2password
                HStack(alignment: .center, spacing: 15) {
                    Text("Password")
                       
                    SecureField("Input password" , text:$pwd )
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                        
                }
                .padding(.leading,20)
                
        
                //3 login
                Button {
                    if user.count == 0 || pwd.count == 0{
                        self.showAlert = true
                        alertText = "user or password nil"
                        return
                    }
                    Task {
                        showNet = true
                        let result = await userVM.login(user: user, pwd: pwd)
                        showNet = false
                        if result {
                            userVM.user = user
                            userVM.isLogin = true
                        } else {
                            self.showAlert = true
                            alertText = "login error"
                        }
                        
                        
                    }
                   
                } label: {
                    Text("Login")
                        .frame(width: 200, height: 40, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                }
                .padding(.top,20)
                .cornerRadius(8)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText))
                }
             
                //4register
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .frame(width: 200, height: 40, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.pink)
                }
                .cornerRadius(8)
                .padding(.top,20)
                
                Spacer()
                
            }
            .padding(.top,100)
            .navigationBarTitle("Login",displayMode: .inline)
            .withLoading(showAlert: $showNet, msg: .constant("Loading"))
        }
        
    }
}

#Preview {
    LoginView()
}
