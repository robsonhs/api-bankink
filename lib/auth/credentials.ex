defmodule ApiBanking.Auth.Credentials do
    
    defstruct id: nil, email: nil, password: nil
    
    def build(user) do
       
        %ApiBanking.Auth.Credentials{id: user.username, password: user.password, email: user.email}
        
    end

end