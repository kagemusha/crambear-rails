*** This project is under development and most functionality is not implemented yet***
You can use the [non-Ember version](http://crambear2.herokuapp.com) to see what it will look like in future.

Crambear
=======================

Crambear is a flash cards app written in Rails and EmberJs.  Its aim is to provide a non-trivial example of
an actual Ember.js app.  And by non-trivial I mean something will more than just 1 or 2 models and which
does something besides just CRUD.


Features
--------
*
*

Ember Version
-------------
Currently running on [Ember.js 1.0 RC1](http://emberjs.com/blog/2013/02/15/ember-1-0-rc/)


Getting Started (when app ready)
--------------------------------

To run the app:

    (clone or fork the project)
    $ bundle install
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake db:seed
    $ rails server
    
Data Model
----------

The basic data model is something like this:

User
- has many card_sets

CardSet
- belongs to user
- has many cards
- has many labels

Card
- belongs to card_set
- has and belongs to many labels

Label
- belongs to card_set
- has and belongs to many cards


###License
Copyright 2013 Michael Madrid under the [MIT License](http://opensource.org/licenses/MIT)
