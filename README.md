DEPRECATED
------
Replaced by ember-cli/rails projects:
* https://github.com/kagemusha/crambear
* https://github.com/kagemusha/crambear-api


Crambear
=======================

Crambear is a flash cards app written in Rails and EmberJs.  Its aim is to provide a non-trivial example of
an actual Ember.js app.  And by non-trivial I mean something will more than just 1 or 2 models and which
does something besides just CRUD.  The Ember client is written in [Coffeescript](http://coffeescript.org/) and uses 
[Emblem.js](https://github.com/machty/emblem.js) templates.


Features
--------
* Card Sets: create, update, delete (implemented)
* Cards: create, edit, delete (implemented)
* Labels for Card Sets and Cards: you can add to sets - next step is ability to label cards
* Authentication with Devise: implemented

Ember Version
-------------
Currently running on [Ember.js 1.0 RC3](http://emberjs.com/blog/2013/04/21/ember-1-0-rc3.html)


Getting Started
---------------

To run the app:

    (clone or fork the project)
    $ bundle install
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake db:seed
    $ rails server
    
Data Model
----------

The basic data model is:

    User
        has many card_sets

    CardSet
        belongs to user
        has many cards
        has many labels

    Card
        belongs to card_set
        has and belongs to many labels

    Label
        belongs to card_set
        has and belongs to many cards

Some Current Issues
-------------------
* When create a new card set, how do you transition there immediately?
* Can't seem to get reference to card when trying to add card to commit in App.CardsTableRowController enterEditMode()

Helping Out
-----------
...is welcomed!

Other Ember.js/Rails Resources
------------------------------

### Demos and Learning Resources

The official guides:

* http://emberjs.com/guides/

Peepcode

* [Ember.js Peepcode (Jan 2013)](https://peepcode.com/products/emberjs)

  Definitely worthwhile, though found it easier to watch it at 2X speed as recitation a tad slow
  
I found both of the following demos helpful (and new ones appearing all the time):

* [ember_data_examle](https://github.com/dgeb/ember_data_example)
* [ember_todo](https://github.com/Skalar/ember_todo)

### Add-ons

  Think HTML/Handlebars too verbose?  Alex Matchneer is developing a [Slim](http://slim-lang.com/)-like templating solution:

* [emblem.js](https://github.com/machty/emblem.js)


###License
Copyright 2013 Michael Madrid under the [MIT License](http://opensource.org/licenses/MIT)
