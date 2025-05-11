defmodule Updown do
  use Application

  def start(_type, _args) do
    Updown.start_game()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def start_game do
    IO.puts("업다운 게임을 시작합니다.")
    answer = :rand.uniform(100)
    Updown.guess(answer)
  end

  def guess(answer) do
    input =
      IO.gets("숫자를 입력 하세요 : ")
      |> String.trim()

    case Integer.parse(input) do
      {input, _} when input === answer ->
        IO.puts("정답입니다! 다시 하시겠습니까?\n하신다면 Y 안 하신다면 Y 제외 아무거나 입력해주세요.")
        continue = IO.gets("입력 : ") |> String.trim()

        if continue === "Y" or "y" do
          Updown.start_game()
        else
        end

      {input, _} when input > answer ->
        IO.puts("#{input}보다 작습니다.")
        guess(answer)

      {input, _} when input < answer ->
        IO.puts("#{input}보다 큽니다.")
        guess(answer)

      :error ->
        IO.puts("올바른 숫자를 입력해주세요.")
        guess(answer)
    end
  end
end
