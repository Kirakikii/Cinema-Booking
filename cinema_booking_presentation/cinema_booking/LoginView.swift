

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
                //insert logo image to the screen
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                    .clipped()
                    .cornerRadius(50)
                
                Spacer()
                //create the textfield of username
                HStack(alignment: .center, spacing: 10) {
                    Text("Username")
                        
                        
                    TextField("please input username" , text:$user)
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                }
                .padding(.leading,20)
                
                //create the textfield of username
                HStack(alignment: .center, spacing: 15) {
                    Text("Password")
                       
                    SecureField("please input password" , text:$pwd )
                        .textFieldStyle(.roundedBorder)
                        .padding([.leading,.trailing],10)
                        
                }
                .padding(.leading,20)
                
            Spacer()
        
                //test the input from user
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
                .padding(.top,0)
                .cornerRadius(10)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText))
                }
             
                //link to registerview
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
            //show the loading animation
            .navigationBarTitle("Login",displayMode: .inline)
            .withLoading(showAlert: $showNet, msg: .constant("Loading"))
        }
        
    }
}

#Preview {
    LoginView()
}
