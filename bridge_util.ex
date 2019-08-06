# Random scripts to use with Adobe Bridge
defmodule BridgeUtil do

  def rename_files(root) do
    seed = rand(1, 50)
    file_list = case File.exists?(root <> "/.BridgeSort") do
      true -> get_file_list_from_bridge_sort(root <> "/.BridgeSort") |> Enum.sort
      false -> File.ls!(root)
    end

    file_list
    |> Enum.with_index
    |> Enum.each(fn({item, index}) ->
      current_path = "#{root}/#{item}"
      case File.dir?(current_path) do
        true ->
          rename_files(current_path)
        false ->
          parent = Path.basename(root)
          case String.starts_with?(item, ".") do
            false ->
              case String.starts_with?(item, ".") do
                false ->
                  ext = Path.extname(item)
                  new_filename = "#{root}/#{parent}_#{seed}_#{index}#{ext}"
                  IO.puts("PROCESSING - #{item} -> #{new_filename}")
                  File.rename("#{root}/#{item}", new_filename)
                true ->
              end
            true ->
          end
      end
    end)
  end

  def rand(lower, upper) do
    ceil(:rand.uniform * (upper - lower)) + lower
  end

  def get_file_list_from_bridge_sort(filename) do
    {:ok, file} = File.read(filename)
    items = file
    |> String.split("\n")
    |> Enum.filter(fn(line) -> String.starts_with?(line, "<item") end)
    |> Enum.map(fn(line) ->
      [head, _tail] = line |> String.split([".png", ".jpg"])
      "<item key='" <> file_name = head
      file_name = file_name <> ".jpg"
    end)

  end
end
