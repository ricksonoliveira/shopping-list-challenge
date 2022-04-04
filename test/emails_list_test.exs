defmodule EmailsListTest do
  use ExUnit.Case
  doctest EmailsList

  @buyers [
    %EmailsList{email: "rick@mail.com"},
    %EmailsList{email: "ana@mail.com"},
    %EmailsList{email: "khaleesi@mail.com"}
  ]

  setup do
    Files.start

    on_exit(fn ->
      File.rm("shopping_list.txt")
      File.rm("emails_list.txt")
    end)
  end

  test "Should test structure" do
    email_struct = %EmailsList{email: "rick@mail.com"}
    assert email_struct.email == "rick@mail.com"
  end

  test "emails_list/0" do
    EmailsList.create_emails_list("rick@mail.com")
    assert EmailsList.emails_list() |> Enum.count() == 1
  end

  test "distribute_to_buyers/2 with 3 emails" do
    emails_list = EmailsList.distrubute_to_buyers(@buyers, 100)
    assert List.first(emails_list) == %{"rick@mail.com" => 33}
    assert List.last(emails_list) == %{"khaleesi@mail.com" => 34}
  end

  test "distribute_to_buyers/2 with 2 emails" do
    buyers_list = List.delete_at(@buyers, 0)
    emails_list = EmailsList.distrubute_to_buyers(buyers_list, 100)
    assert List.first(emails_list) == %{"ana@mail.com" => 50}
    assert List.last(emails_list) == %{"khaleesi@mail.com" => 50}
  end
end
