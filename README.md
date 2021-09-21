# notebookgarden
Jupyter Notebook as a Service.

Notebook Garden has the goal to make Jupyter Notebooks as easy to use as possible. It will allow everyone to use them without learning to install Python, Jupyter notebook server or anything else. It will even allow people to share notebooks without ever learning Git.

The software is currently developed to run a SaaS offering, because that is the best way reach above goal. Self-hosting is not officially supported, but as the code is free and open source everyone can try it on their own.

## Usage

### Prerequisites
You need:

* Elixir
* docker-compose
* Node.js
* yarn

### Development
To run the application locally:

* Install dependencies with `mix deps.get`
* Install asset dependencies with `yarn install` in the `assets` directory
* Launch development database `docker-compose up -d`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
