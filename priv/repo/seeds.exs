
alias ShortuuidExample.{Comment, User, Post, Repo}

user = %User{name: "John Connor", age: 21} |> Repo.insert!()
post = %Post{title: "My first post", user_id: user.id} |> Repo.insert!()
[
  %Comment{content: "first", post_id: post.id, user_id: user.id},
  %Comment{content: "nice!", post_id: post.id, user_id: user.id}
]
|> Enum.each(fn c -> c |> Repo.insert!() end)
