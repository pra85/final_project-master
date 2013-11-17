###Broomble Rails Project

It is a Rails 3 codebase and uses a MySQL backend for the database and Sphinx for the search
engine.

####Initial setup

* Install Ruby 1.9.3.

* Checkout the Broomble git tree from Github

         $ git clone git://github.com/jcs/Broomble.git
         $ cd Broomble
         Broomble$ 

* Run Bundler to install/bundle gems needed by the project:

         Broomble$ bundle

* Create a MySQL (other DBs supported by ActiveRecord may work, only MySQL and
MariaDB have been tested) database, username, and password and put them in a
`config/database.yml` file:

          development:
            adapter: mysql2
            encoding: utf8mb4
            reconnect: false
            database: Broomble_dev
            socket: /tmp/mysql.sock
            username: *username*
            password: *password*
            
          test:
            adapter: sqlite3
            database: db/test.sqlite3
            pool: 5
            timeout: 5000

* Load the schema into the new database:

          Broomble$ rake db:schema:load

* Create a `config/initializers/secret_token.rb` file, using a randomly
generated key from the output of `rake secret`:

          Broomble::Application.config.secret_token = 'your random secret here'

* (Optional, only needed for the search engine) Install Sphinx.  Build Sphinx
config and start server:

          Broomble$ rake thinking_sphinx:rebuild

* Define your site's name and default domain, which are used in various places,
in a `config/initializers/production.rb` or similar file:

          class << Rails.application
            def domain
              "example.com"
            end
          
            def name
              "Example News"
            end
          end
          
          Rails.application.routes.default_url_options[:host] = Rails.application.domain

* Create an initial administrator user and at least one tag:

          Broomble$ rails console
          Loading development environment (Rails 3.2.6)
          irb(main):001:0> u = User.new(:username => "test", :email => "test@example.com", :password => "test")
          irb(main):002:0> u.is_admin = true
          irb(main):003:0> u.is_moderator = true
          irb(main):004:0> u.save

          irb(main):005:0> t = Tag.new
          irb(main):006:0> t.tag = "test"
          irb(main):007:0> t.save

* Run the Rails server in development mode.  You should be able to login to
`http://localhost:3000` with your new `test` user:

          Broomble$ rails server

####API Details

* get "/news.json"

* get "/newest.json"
 
* get "/newest/:user.json"
  
* get "/s/:id/(:title).json"
  
* get "/comments/page/:page.json"
   
* get "/u/:id.json"

* post "/apilogin" => "login#apilogin"
  
* post "/apilogout" => "login#apilogout"

####OR you can use REST structured api

* get "/apinews" => "home#apiindex"

* get "/apinewest" => "home#apinewest"
 
* get "/apinewest/:user" => "home#apinewest_by_user"
  
* get "/apis/:id/(:title)" => "stories#apishow"
  
* get "/apicomments/(page/:page)" => "comments#apicomments"
   
* get "/apiuser/:id" => "users#apishow"

* post "/apilogin" => "login#apilogin"
  
* post "/apilogout" => "login#apilogout"