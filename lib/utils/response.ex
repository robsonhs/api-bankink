defmodule ApiBanking.Util.Response do
    
    defstruct httpStatusCode: 200,
              contentType: "application/json",
              body: nil

    def build(body) do

        %ApiBanking.Util.Response{body: body}

    end
    def build(httpStatusCode, body) do

        %ApiBanking.Util.Response{httpStatusCode: httpStatusCode, body: body}

    end
    def build(httpStatusCode, contentType, body) do

        %ApiBanking.Util.Response{httpStatusCode: httpStatusCode, contentType: contentType, body: body}

    end
    def buildError(body) do

        %ApiBanking.Util.Response{httpStatusCode: 500, body: body}

    end

    def buildBadReques do

        %ApiBanking.Util.Response{httpStatusCode: 400, body: %{:message => "bad request"}}

    end

    def buildNotFound do

        %ApiBanking.Util.Response{httpStatusCode: 404, body: %{:message => "not found"}}

    end

    def buildUnauthorized do

        %ApiBanking.Util.Response{httpStatusCode: 401, body: %{:message => "unauthorized"}}

    end

end