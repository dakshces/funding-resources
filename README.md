# README #

Welcome to the campus funding resources project. Visit the current site at
`https://funding-resources-spring2-2021.herokuapp.com`. You can see the previous group's site
here `https://funding-resources.herokuapp.com`. Please note that this setup guide assumes
you are using an Ubuntu server on AWS Cloud9. 

## Initial Setup ##

(Note: text between underscores, such as "`_github_repo_link_`", are just place holders for
text that should be specific to the task that you are working on) Starting with a completely
new Ubuntu environment in AWS Cloud9 this is what we ran:
```
git clone _github_repo_link_
rvm install "ruby-2.7.0"
source <(curl -sL https://cdn.learnenough.com/yarn_install)
cd funding-resources
```

ADD TO `Gemfile`:
`gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f’``

```
sudo apt install postgresql-contrib libpq-dev
bundle install
bundle update
yarn install --check-files
sudo -u postgres createuser ubuntu -s
rails db:create

rails db:migrate
rails server
```

## Common Commands ##

Every time you add a new gem (this is similar to a library in C) you will need to run `bundle install`. 

To update the data table, run `rails generate migration [migration name]`. Then, update
the generated migration file to include instructions for how to modify the database. 
Run `rails db:migrate` after that. 

`rake db:reset` will re-populate the database with the data from the db/seeds.rb file.
`rake db:migrate:reset` will reset the database removing all data. This command fixed
some errors we had after merging code.
`rake db:seed` populates the database with the data from the db/seeds.rb file without
changing any of the current data stored.

To log in as an administrator (access active admin by adding "/admin" to the end of the base url), use
the following:
```
username: admin@example.com
password: password 
```

## Using Github ##

For most of us this was one of our first experiences using github for version control.
If you are completely lost this is what we ran. Keep in mind we are new to this so some
of this may not accurate. Since we didn't have permission for the repository, we forked
it and worked on that.
This is a quick breakdown of the commands that we ran. (Note: text between underscores,
such as "`_branch_name_`", are just place holders for text that should be specific to
the task that you are working on)

BEFORE YOU START CODING
```
git checkout -b "_branch_name_"
```

WHILE CODING
```
git add -A
git commit -m "_comment_"
```
This essentially saves all the changes that you have made to the branch so far. We
highly recommend that you do this often in case something goes wrong.

MERGING
```
git add -A
git commit -m "_comment_"
git pull _github_repo_link_ master
```
FIX CONFLICTS (there may be an error message that has the files that need to me fixed)
```
git add -A
git commit -m "_comment_"
git push -u origin "_branch_name_"
git checkout master
git merge _branch_name_
git push
```

## Deploying to Heroku ##

We deployed the website using a personal Heroku account. These are the commands we ran:

SETUP
```
source <(curl -sL https://cdn.learnenough.com/heroku_install)
heroku login --interactive
heroku create --stack heroku-18
heroku rename _site_name_
```

UPDATE WEBSITE
```
git push heroku master
```

## What's in the box ##

1. We've set up a `User` model for you to handle site users.
   It has an `admin` flag to denote users with elevated permissions.
2. [Devise](http://devise.plataformatec.com.br/) handles user authentication.
3. [ActiveAdmin](https://activeadmin.info/) provides an admin interface that's easy to configure.
4. [Webpacker](https://github.com/rails/webpacker#readme) integrates modern JavaScript packages.
   If you don't need it, the traditional Rails assets will continue to work.
5. [Bootstrap](https://getbootstrap.com/docs/5.0/getting-started/introduction/) provides a CSS framework for easy layouts and styling. It has fantastic documentation.
6. [Sass](https://sass-lang.com/guide) adds some extra power to your stylesheets when they have the `.scss` extension. Regular CSS will always work great in them too!
7. [Gutentag](https://github.com/pat/gutentag), our pride and joy, allows users to filter resources based on their tags (attributes).
8. [pgsearch](https://pganalyze.com/blog/full-text-search-ruby-rails-postgres), a classic overachiever, lets you search the entire database without typing a single
   line of SQL.

## Future Tasks and Goals ##

1. Add a user sign up page with a way to verify that users have
   a .grinnell.edu email address. The Hartl book has a step-by-step walkthrough
   for how to implement it. 
2. Create a map feature that allows users to find resource locations on
   campus (we suggest using [arcGIS](https://github.com/ajturner/arcgis-ruby)).
3. Continue working on appearance.


## Verbose musings ##
This website is built to remedy the lack of transparency in funding at Grinnell. Currently, unless you know someone who knows about a fund, 
it is next to impossible to apply for, let alone receive money from, a funding source. In order to mitigate this issue, the CLS funding 
website provides a way for students to easily browse funds and find one that is right for them. 

Our project is built around a table of funding resources. The schematics for this table can be found in db/schema.rb. 
The browse page of the website will display all of the resources. We use the “pgsearch” gem to look for exact matches between text entered 
into the search bar and items in our resources table. Users can also refine their search based on tags. Tags are extra descriptive features 
that can be added to a resource. Instead of having a true/false column for every potential aspect of a resource, we opted to use tags. 
This allowed us to have a sparse data set without adding in a ton of extra space. 

When a user searches for something--this uses the get method--the index method in the search controller (app/models/search_controller.rb) 
is called. This first gathers a list (array) of all of the tags a user has selected. Then, it filters based on tags if they are present 
and/or a text search if it is present. If neither is present, it returns all of the information. Note that when you choose a new set of 
tags, the previous text search will be preserved and vice versa. However, entering in new text will get rid of the old typed search query 
just as selecting new tags clears the old ones.

Another very important gem is Gutentag! We use Gutentag to catalog each tag. Instead of assigning a tag array to each resource object, 
Gutentag creates a new tag object only when an entirely new tag is added. If a tag has been used to describe a resource before, it will 
use that same tag to describe every other resource that has that attribute. To implement this, Gutentag stores relations, which describe 
the connection between a tag and a resource object.

Finally, we use ActiveAdmin to allow people like Susan Sanning to add and edit resources. ActiveAdmin is called when “/admin” is added to 
the base website url. The gem allows us to create admin accounts and provides a graphical user interface for modifying the database. 
This is especially important for website administrators who do not have programming experience. 

Our group did the bulk of our work while pair programming or in team meetings. Since none of us knew Ruby on Rails, it was helpful to have 
someone to bounce ideas off of. Furthermore, it was much more likely that one of the two people working together knew something; the combined 
knowledge was enough to remedy a lot of bugs. It is also important to start working on the project as soon as you receive the code. While it 
makes sense to plan what you want to do, you will gain a much stronger understanding of what you can implement once you have messed around with the code.

Ruby on Rails is extremely difficult to learn. Ruby itself is fairly straightforward, but Rails is convoluted and foreign. It is just fine to be lost 
in the file system, confused about when to use plurals, and upset that the function definitions for one object are put in three or four different 
locations. Please remember that this language is a beast and that you unfortunately do not have enough time to fully grasp it (if you end up becoming 
a master Rails developer in seven weeks, please do not contact us to let us know). 




