String insertUser() {
    return """
    mutation Signup(\$firstName: String!, \$lastName: String!, \$email: String!, \$password: String!){
      signup(input: {userSignupInput: {firstName: \$firstName, lastName: \$lastName, email: \$email, password: \$password}}){
                  token
      }
    }                                                                                                  
  """;
  }