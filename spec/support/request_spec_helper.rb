module RequestSpecHelper
  def login_user(user)
    post '/auth/login', params: { username: user.username, password: user.password }

    JSON.parse(response.body)['token'] # return
  end
end
