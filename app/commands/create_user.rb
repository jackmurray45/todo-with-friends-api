class CreateUser
    prepend SimpleCommand
  
    def initialize(name, email, password, password_confirmation)
        @name = name
        @email = email
        @password = password
        @password_confirmation = password_confirmation
    end
  
    def call
        created_user
    end
  
    private
  
    attr_accessor :name, :email, :password, :password_confirmation
  
    def created_user
        user = User.new({"name" => name, "email" => email, "password" => password, "password_confirmation" => password_confirmation})
        if user.save
            token = JsonWebToken.encode(user_id: user.id)
            user_attributes = user.attributes
            user_attributes[:token] = token
            return user_attributes
        end
        errors.add 'errors', user.errors
        nil
    end
end