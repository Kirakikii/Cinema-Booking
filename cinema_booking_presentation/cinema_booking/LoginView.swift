

import SwiftUI


struct LoginView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State var user  = "123"
    @State var pwd  = "123"
    @State var showAlert : Bool = false
    @State var alertText = ""
    @State var showNet = false
    var body: some View {
        NavigationView {
            VStack{
                //1user
                HStack(alignment: .center, spacing: 20) {
                    Text("user")
                        
                        
                    TextField("please input user" , text:$user)
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                }
                .padding(.leading,20)
                
                //2password
                HStack(alignment: .center, spacing: 20) {
                    Text("password")
                       
                    SecureField("please input password" , text:$pwd )
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
                        .background(Color.blue)
                }
                .padding(.top,30)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText))
                }
             
                //4register
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .frame(width: 200, height: 40, alignment: .center)
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
