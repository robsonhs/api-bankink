defmodule ApiBanking.Util.SendEmail do

    @spec send(String.t(), String.t(), String.t()) :: Task.t()
    def send(to, subject, bory) do
        
        Task.async( fn ->
            IO.inspect("Send e-mail...")
            IO.inspect("to: " <> to)
            IO.inspect("subject: " <> subject)
            IO.inspect("bory: " <> bory)
            IO.inspect("Sended e-mail...") 
        end)
        
    end

end