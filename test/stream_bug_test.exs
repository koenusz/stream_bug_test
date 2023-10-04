defmodule StreamBugTest do
  use ExUnit.Case
  doctest StreamBug

  @image_path "#{File.cwd!()}/church.jpg"
  @copy_path "#{File.cwd!()}/copy.jpg"
  @stream_path "#{File.cwd!()}/stream.jpg"
  @stream_path2 "#{File.cwd!()}/stream2.jpg"
  @lorem_copy_path "#{File.cwd!()}/lorem_copy.txt"
  @hex "#{File.cwd!()}/hex.txt"
  @hex_copy "#{File.cwd!()}/hex_copy.txt"

  test "stream the image" do
    File.stream!(@image_path)
    |> Enum.into(File.stream!(@stream_path))
  end

  test "stream the image 2" do
    File.stream!(@image_path)
    |> Stream.into(File.stream!(@stream_path2))
    |> Stream.run()
  end

  test "hex" do
    hex =
      File.read!(@image_path)
      |> Base.encode16()

    File.write(@hex, hex)

    File.stream!(@image_path)
    |> Stream.map(&Base.encode16/1)
    |> Enum.into(File.stream!(@hex_copy))
  end
end
