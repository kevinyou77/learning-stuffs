defmodule M do

  def main do

    anonymous_functions()
    concurrency()
  end

  def do_stuff do
    name = IO.gets("What's your name? ") |> String.trim
    IO.puts "Hello, #{name}"

    4 * 10 |> IO.puts

    # Like guard in Swift, but make more sense
    unless name === "kevin" do
      "Lol no" |> IO.puts
    else
      "you're kevin" |> IO.puts
    end
  end

  def condDo do

    # much like if else if
    age = IO.gets("what's your age? ") |> String.trim

    cond do
      age >= 18 ->
        IO.puts "You can vote!"
      age >= 16 ->
        IO.puts "You can drive"
      age >= 14 ->
        IO.puts "You can wait"
      true -> IO.puts "???"
    end
  end

  def case_keyword do

    age = IO.gets("whats your age? (case)") |> String.trim

    case age do
      2 ->
        IO.puts "You're two years old"
      10 ->
        IO.puts "You're 10 years old"

      _ -> IO.puts "Default"
    end
  end

  def tuples do

    my_stats = { 1, 2, :SomeAtom }

    Tuple.append(my_stats, 52)
    Tuple.append(my_stats, :AnotherAtom)

    new_tuple = Tuple.delete_at(my_stats, 0)
    inserted_tuple = Tuple.insert_at(new_tuple, 0, 800)

    tuple_with_many_zeroes = Tuple.duplicate(0, 5)

    # Javascript destructuring like
    { weight, bmi } = { 8, 180 }

    IO.puts "#{weight}"
  end

  def arrays do

    list_one = [ 1, 2, 3 ]
    list_two = [ 2, 7, 4]

    list_three = list_one ++ list_two # [1,2,3,2,7,4]
    list_four = list_three -- list_two # [1,2,3]

    [ head | tail ] = list_four # head = [1] tail = [2,3]

    IO.inspect list_three, char_lists: :as_lists
    IO.inspect list_four, char_lists: :as_lists

    list_to_loop = ["Something", "interesting"]

    Enum.each list_to_loop, fn word ->
      IO.puts word
    end
  end

  # since elixir is immutable, we need to use recursion as it doesn't mutate any variable
  def looping_list_recursively([head | tail]) do
    IO.puts head
    looping_list_recursively([tail])
  end
  def looping_list_recursively([]), do: nil

  def anonymous_functions do

    sum_numbers = fn (a, b) -> a + b end
    IO.puts "7 + 7 = #{sum_numbers.(7, 7)}"

    substract_numbers = &(&1 - &2)
    IO.puts "7 - 3 = #{substract_numbers.(7, 3)}"
  end

  def anonymous_function_with_case do

    sum_numbers = fn
      { x, y } ->  x + y
      { x, y, z } -> x + y + z
    end

    IO.puts sum_numbers.(1,2)
    IO.puts sum_numbers.(2,3,4)
  end

  def function_with_default_param(param_one \\ 1, param_two \\ 2) do
    param_one + param_two
  end

  def loop(0, _), do: nil
  def loop(max, min) do
    if max < min do
      loop(0, min)
    else
      IO.puts "Num: #{max}"
      loop(max - 1, min)
    end
  end

  def list_comprehension do

    list = [1, 2, 3, 4]
    double_list = for n <- list, do: n * 2
    IO.inspect double_list

    even_list = for n <- list,
      rem(n, 2) == 0,
      do: n
    IO.inspect even_list
  end

  def concurrency do

    spawn(fn() -> loop(50, 1) end)
    spawn(fn() -> loop(20, 1) end)

    send(self(), { :english, "Bob" })

    receive do
      { :english, name } -> IO.puts "Hello, #{name}!"
      { :german, name } -> IO.puts "Guten Tag, #{name}!"

    after
      500 -> IO.puts "Time's up"
    end
  end
end
