# ShoppingList

ShoppingList is a pure elixir handmade challenge proposed by [Stone](https://www.stone.com.br/), with the purpose to fully distribute values from a given shopping list between the list's buyers.

* [Installation](https://github.com/ricksonoliveira/shopping-list-challenge#installation)
* [Usage](https://github.com/ricksonoliveira/shopping-list-challenge#usage)
* [Tests](https://github.com/ricksonoliveira/shopping-list-challenge#tests)

## **Installation**

To use this service, you'll need [Elixir](https://elixir-lang.org/install.html) installed on your machine or container.

Then, install the dependencies with the command:
```console
 mix deps.get
 ```

And that's it... you're all set! 🎉

## **Usage**

This service is written in pure [Elixir](https://elixir-lang.org/docs.html), so in order to use it, you'll need to open your terminal inside the application's folder and type th following command to enter interative mode:

```console
iex -S mix
```

After that, we'll start playing. 😊

First you'll need to create the lists in which we'll work with. Which are the shopping list and the email list of our buyers. But first we'll start our app settings by using the `start/0` function that will create the files in which will store our lists data.

To do that, follow the example:

### Starting the application and creating the shopping list

```console
iex> Files.start
iex> ShoppingList.create_shopping_list(10, 100)
```

You should get a return like so:

```console
{:ok, [%ShoppingItem{quantity: 10, unit_price: 100}]}
```

The `crate_shopping_list/2` has the params:

* `quantity: item quantity (integer)`
* `unit_price: price unit of the item (integer)`

You can create as much shopping list as you want, they will all be added to a single file and a single list, like the following:

```console
iex> ShoppingList.create_shopping_list(10, 100)
iex> ShoppingList.create_shopping_list(1, 10)
iex> ShoppingList.create_shopping_list(2, 50)
```

And the return should be like this:

```console
{:ok, [
  %ShoppingItem{quantity: 10, unit_price: 100}
  %ShoppingItem{quantity: 1, unit_price: 10}
  %ShoppingItem{quantity: 2, unit_price: 50}
]}
```

### Creating the email list of the buyers

```console
iex> EmailsList.create_emails_list("rick@mail.com")
```

Will return something like:

```console
{:ok, [%EmailsList{email: "rick@mail.com"}]}
```

The `crate_emails_list/2` contains the param:

* `email: buyer email (string)`

Such as the shopping list, you can create as much emails list as you want, and it will also be added to a single lis like below:

```console
iex> EmailsList.create_emails_list("rick@mail.com")
iex> EmailsList.create_emails_list("ana@mail.com")
iex> EmailsList.create_emails_list("khaleesi@mail.com")
```

The return should be:

```console
{:ok, [
  %EmailsList{email: "rick@mail.com"}
  %EmailsList{email: "ana@mail.com"}
  %EmailsList{email: "khaleesi@mail.com"}
]}
```

### **Emails list distributed equally not missing a single cent**

After having our both lists, we can now generate our emails list with the values of the shopping list distributed equally except for one rule.

The rule is: if your shopping list's sum of values divided for the quantity of the items results in an infinite number, e.g. `100 / 3 = 0,33333333...` , the values, in this case `33` cents, will be divided along the buyers, but the last buyer will receive the rest of the cents missing so our distribution will be fully given not missing a single cent!

Let's see the examples of use with the function to generate the list `get_shopping_list_distributed/0`:

Generating list with sum not inifinite

```console
ShoppingList.get_shopping_list_distributed
```

Remember we already created above three buyers with the shopping list's quantitities of `10, 1` and `2` and unit prices of `100, 10` and `50`. So the result in this case will be:

```console
{:ok,
 [
   %{"rick@mail.com" => 370},
   %{"ana@mail.com" => 370},
   %{"khaleesi@mail.com" => 370}
]}
```

Now if we add Lord Vader into this mess, we'll have to give him him equal part, plus the rest amount of the value so not a single cent will be missing!

```console
EmailsList.create_emails_list("darthvader@mail.com")
```

Result

```console
{:ok,
 [
   %EmailsList{email: "rick@mail.com"},
   %EmailsList{email: "ana@mail.com"},
   %EmailsList{email: "khaleesi@mail.com"},
   %EmailsList{email: "darthvader@mail.com"}
]}

```

Then now calling the list generating function, the final result shoud be:

```console
{:ok,
 [
   %{"rick@mail.com" => 277},
   %{"ana@mail.com" => 277},
   %{"khaleesi@mail.com" => 277},
   %{"darthvader@mail.com" => 279}
]}
```

What can I do.. he's the boss! 🤷‍♂️

![Alt Text](https://media2.giphy.com/media/ylyUQnqAdMNs4QITOE/giphy.gif?cid=ecf05e4759bca6r354lmkuyi533fiot942d7yjqokk5etnc9&rid=giphy.gif&ct=g)

## **Tests**

This application was 100% tested. So to checkout out the tests run:

```console
mix test
```

And to check coverage report, run:

```console
mix coveralls.html
```
