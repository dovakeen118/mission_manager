class LoginForm
 include Capybara::DSL

  def visit_page
    visit("/users/sign_in") || visit("/users/sign_up")
    self
  end

  def mock_auth_hash(email = 'mock_user_email@test.com')
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
     "provider" => 'facebook',
     "uid" => '12345',
     "info" => {
       "name" => 'mockuser',
       "email" => 'mock_user_email@test.com'
     }
    })

    self
  end

  def social_login(name)
    case name
      when "facebook"
       click_on("Sign in with Facebook")
    end
  end
end
