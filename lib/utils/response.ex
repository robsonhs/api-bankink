defmodule ApiBanking.Util.Response do
    
    def response(conn, httpStatusCode) do
        Plug.Conn.send_res(conn, httpStatusCode,"")
    end

    def response(conn, httpStatusCode, msg) do
        Plug.Conn.send_res(conn, httpStatusCode,msg)
    end

end