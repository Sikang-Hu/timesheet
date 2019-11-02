# Timesheet

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Design Choices

### Database
There are four entities in the database: users, sheets, tasks, jobs.

- The users table store the identifications for all users, such as email, password_hash, name. A user can be either a manager or a worker, which will be distinguished by manager_id, a manager will have a nil for that column. 

- A sheet will have date, status(whether approved), and the id of user it belongs to. One user will have one sheets per day.

- A task will have how many hours it cost, the note for describing it. There are two foreign keys: sheet_id denotes which sheet it belongs to, and job_id specifies what job this task focused.

- A job will have a job code, budget hours, and a description(can be long). The jobs table cannot be modified in this prototype. There are two jobs in the database for test.

### UI design
For this prototype, there is no way to sign up as a new user, I just provided five users in the database: 2 managers and 3 workers. The user need to login first. If he login as a manager, he will be redirect to an index page containing all the timesheets from the user he supervises. And he can view the detail of each timesheets by click show or approve a timesheet. If he login as a worker, he can see all his timesheets, and create a new timesheets.

To create a new timesheets, the worker need to specifiy tasks by selecting the job code, inputting how many hours spent and a note about the task. Tasks with negative hours will be ignore, while tasks with empty note will be filled with a default note.
- Worker1: w1@timesheet.com, supervised by Manager1
- Worker2: w2@timesheet.com, supervised by Manager2
- Worker3: w3@timesheet.com, supervised by Manager2
- Manager1: m1@timesheet.com
- Manager2: m2@timesheet.com
Password are all: password1234


