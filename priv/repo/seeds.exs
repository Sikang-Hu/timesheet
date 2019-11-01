# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheet.Repo.insert!(%Timesheet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Timesheet.Repo
alias Timesheet.Users.User

pw1 = Argon2.hash_pwd_salt("password1234")
pw2 = Argon2.hash_pwd_salt("password5678")

Repo.insert!(%User{name: "manager1", email: "m1@timesheet.com", password_hash: pw1})
Repo.insert!(%User{name: "manager2", email: "m2@timesheet.com", password_hash: pw1})

Repo.insert!(%User{name: "worker1", email: "w1@timesheet.com", password_hash: pw2, manager_id: 1})
Repo.insert!(%User{name: "worker2", email: "w2@timesheet.com", password_hash: pw2, manager_id: 2})
Repo.insert!(%User{name: "worker3", email: "w3@timesheet.com", password_hash: pw2, manager_id: 2})
