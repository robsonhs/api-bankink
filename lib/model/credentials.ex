defmodule ApiBanking.Credentials do
    
    defstruct id: nil, email: nil, password: nil
    
    def build(user) do
       
        %ApiBanking.Credentials{id: user.username, password: user.password, email: user.email}
        
    end

end