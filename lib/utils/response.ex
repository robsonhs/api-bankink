defmodule ApiBanking.Util.Response do
    @moduledoc """
        Provides functions to build returns with http status and body
    """ 

    defstruct httpStatusCode: 200,
              contentType: "application/json",
              body: nil

    @spec build(%{}) :: ApiBanking.Util.Response.t()
    def build(body) do

        %ApiBanking.Util.Response{body: body}

    end
   
    @spec build(number, %{}) :: ApiBanking.Util.Response.t()
    def build(httpStatusCode, body) do

        %ApiBanking.Util.Response{httpStatusCode: httpStatusCode, body: body}

    end

    @spec build(number, String.t(), %{}) :: ApiBanking.Util.Response.t()
    def build(httpStatusCode, contentType, body) do

        %ApiBanking.Util.Response{httpStatusCode: httpStatusCode, contentType: contentType, body: body}

    end
    
    @spec buildError(%{}) :: ApiBanking.Util.Response.t()
    def buildError(body) do

        %ApiBanking.Util.Response{httpStatusCode: 500, body: body}

    end

    @spec buildBadReques() :: ApiBanking.Util.Response.t()
    def buildBadReques do

        %ApiBanking.Util.Response{httpStatusCode: 400, body: %{:message => "bad request"}}

    end

    @spec buildNotFound() :: ApiBanking.Util.Response.t()
    def buildNotFound do

        %ApiBanking.Util.Response{httpStatusCode: 404, body: %{:message => "not found"}}

    end

    @spec buildUnauthorized() :: ApiBanking.Util.Response.t()
    def buildUnauthorized do

        %ApiBanking.Util.Response{httpStatusCode: 401, body: %{:message => "unauthorized"}}

    end

end