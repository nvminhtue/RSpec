
module SpecTestHelper
   def login user
    user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
    # session[:user_id] = user.id
    # sign_in user
  end
  # def current_user
  #   User.find(session[:user])
  # end
end
