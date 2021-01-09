defmodule MorseDecoderWeb.MorseControllerTest do
  use MorseDecoderWeb.ConnCase

  test "GET index", %{conn: conn} do
    conn = get(conn, "/v1/decoder/")
    assert text_response(conn, 200) =~ "Morse Decoder"
  end

  test "it_should_create_decode", %{conn: conn} do
    conn = post(conn, "/v1/decoder/")
    assert %{"id" => _id} = json_response(conn, 200)
  end

  test "it_should_decode_code", %{conn: conn} do
    assert %{"id" => id} = json_response(post(conn, "/v1/decoder/"), 200)

    response = put(conn, "/v1/decoder/#{id}", code: ".")
    assert 200 = response.status

    response = put(conn, "/v1/decoder/#{id}", code: ".")
    assert 200 = response.status

    assert %{"text" => "EE"} = json_response(get(conn, "/v1/decoder/#{id}"), 200)
  end
end
