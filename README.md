# ShortuuidExample

Example usage of ecto_shortuuid for ShortUUID primary and foreign keys. I hope this example will allow you to quickly evaluate if this is something for you.

## Installation

Clone this repository and run the following commands to set it up and log into the console.

**Note:** You will need to either have docker running to use the included postresql setup [docker-compose.yml](docker-compose.yml) or edit [config/config.exs](config/config.exs) so the app can connect to your database server.

```
$ mix deps.get
$ docker-compose up --detach
$ mix ecto.create
$ mix ecto.migrate
$ mix run priv/repo/seeds.ex
$ iex -S mix
```

## Examples

After our database is seeded it will looks as follows

#### Users

id                                   |name        |age |inserted_at         |updated_at          |
-------------------------------------|------------|----|--------------------|--------------------|
54deeb48-6bdb-4bba-babb-d8d7dce748d0 |John Connor |21  |2019-02-03 13:54:26 |2019-02-03 13:54:26 |


#### Posts
id                                   |title         |summary |user_id                              |inserted_at         |updated_at          |
-------------------------------------|--------------|--------|-------------------------------------|--------------------|--------------------|
f23b321a-8607-416c-9e80-4a51b6099f48 |My first post |        |54deeb48-6bdb-4bba-babb-d8d7dce748d0 |2019-02-03 13:54:26 |2019-02-03 13:54:26 |

#### Comments
id                                   |content |parent_id |post_id                              |user_id                              |inserted_at         |updated_at          |
-------------------------------------|--------|----------|-------------------------------------|-------------------------------------|--------------------|--------------------|
fa0f4357-a9e1-4df0-9356-7c36c399d056 |first   |          |f23b321a-8607-416c-9e80-4a51b6099f48 |54deeb48-6bdb-4bba-babb-d8d7dce748d0 |2019-02-03 13:54:26 |2019-02-03 13:54:26 |
130084e1-5197-4cb8-80ca-a11b948c31d0 |nice!   |          |f23b321a-8607-416c-9e80-4a51b6099f48 |54deeb48-6bdb-4bba-babb-d8d7dce748d0 |2019-02-03 13:54:26 |2019-02-03 13:54:26 |


## Let's run some commands
With the following examples run in the iex I'm trying to illustrate how shortuuid's and uuid's can be used interchangeably

To start the console run
```
$ iex -S mix
```

```elixir
# let's get our user so we have an id to work with
iex> Repo.all(User)
[
  %ShortuuidExample.User{
    __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
    age: 21,
    id: "aNKHnKTZSttFsVzqdcti7H",
    inserted_at: ~N[2019-02-03 13:54:26],
    name: "John Connor",
    posts: #Ecto.Association.NotLoaded<association :posts is not loaded>,
    updated_at: ~N[2019-02-03 13:54:26]
  }
]

# ShortUUIDs can be easily converted back to full UUIDs
# as it's just an encoding
iex> ShortUUID.decode!("aNKHnKTZSttFsVzqdcti7H")
"54deeb48-6bdb-4bba-babb-d8d7dce748d0"

# also we can retrieve using both the full UUID
iex> Repo.get!(User, "54deeb48-6bdb-4bba-babb-d8d7dce748d0")

%ShortuuidExample.User{
  __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
  age: 21,
  id: "aNKHnKTZSttFsVzqdcti7H",
  inserted_at: ~N[2019-02-03 13:54:26],
  name: "John Connor",
  posts: #Ecto.Association.NotLoaded<association :posts is not loaded>,
  updated_at: ~N[2019-02-03 13:54:26]
}

# as well as of course the ShortUUID
iex> Repo.get!(User, "aNKHnKTZSttFsVzqdcti7H")

%ShortuuidExample.User{
  __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
  age: 21,
  id: "aNKHnKTZSttFsVzqdcti7H",
  inserted_at: ~N[2019-02-03 13:54:26],
  name: "John Connor",
  posts: #Ecto.Association.NotLoaded<association :posts is not loaded>,
  updated_at: ~N[2019-02-03 13:54:26]
}

# we get the same user
iex> Repo.get!(User, "54deeb48-6bdb-4bba-babb-d8d7dce748d0") === Repo.get!(User, "aNKHnKTZSttFsVzqdcti7H")
true

# it works the same in queries as well we can use both
iex> query = from u in "users", where: u.id == "54deeb48-6bdb-4bba-babb-d8d7dce748d0", select: u.id
# Ecto.Query<from u0 in "users",
# where: u0.id == "54deeb48-6bdb-4bba-babb-d8d7dce748d0", select: u0.id>

# let's get the actual binary value which is stored in the DB
# the binary is exactly the same as when using regular binary_ids
iex> [binary_id | _] = Repo.all(query)
SELECT u0."id" FROM "users" AS u0 WHERE (u0."id" = '54deeb48-6bdb-4bba-babb-d8d7dce748d0') []
[<<84, 222, 235, 72, 107, 219, 75, 186, 186, 187, 216, 215, 220, 231, 72, 208>>]

# we can see that both `Ecto.ShortUUID.load/1` and `Ecto.UUID.load/1` are able to load the binary uuid
# we received from the database

iex> Ecto.ShortUUID.load(<<84, 222, 235, 72, 107, 219, 75, 186, 186, 187, 216, 215, 220, 231, 72, 208>>)
{:ok, "aNKHnKTZSttFsVzqdcti7H"}

iex> Ecto.UUID.load(<<84, 222, 235, 72, 107, 219, 75, 186, 186, 187, 216, 215, 220, 231, 72, 208>>)
{:ok, "54deeb48-6bdb-4bba-babb-d8d7dce748d0"}
```

## Documentation

* shortuuid - [github](https://github.com/gpedic/ex_shortuuid), [hexdocs](https://hexdocs.pm/shortuuid/ShortUUID.html)
* ecto_shortuuid - [github](https://github.com/gpedic/ecto_shortuuid), [hexdocs](https://hexdocs.pm/ecto_shortuuid/Ecto.ShortUUID.html)
* Ecto.Schema - [hexdocs](https://hexdocs.pm/ecto/Ecto.Schema.html#module-schema-attributes)