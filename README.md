# Phat: Preprocessed Hashes & Arrays as Templating

Phat helps you generate JSON and XML repsonses using the same template files.
A Phat template is plain Ruby code: whatever it returns, will get converted to
JSON or XML.

The system consists of a template handler and the handy `to_phat` method
defined on hashes, arrays and - currently - ActiveRecord model objects.

## Usage

Currently Phat is available as a plugin, though we will soon be packaging it
also as a gem. Clone this repository under your Rails 3 application's
`vendor/plugins/` folder and you can start using Phat right away.

Phat templates have the extension `.phat`. If you name them `action.phat`, they
will catch all formats that have no explicitly designated templates, but of
course you can just call them e.g. `action.json.phat` to restrict the format.

## An example

An example Phat template might look like this:

    { users: @users.to_phat(
        only: 'name',
        merge: { path: ->(user) { user_path(user) }},
        refs: {
          pets: {
            only: %w(name species),
            merge: { path: ->(pet) { pet_path(pet) }}}) }

It will yield the following output (pretty printed here for readability):

    { "users": [
      { "name": "Jamie",
        "path": "/users/jamie",
        "pets": [
          { "name": "Wordsworth",
            "species": "Canis lupus familiaris",
            "path: "/pets/wordsworth" }]},
      { "name": "Jon Arbuckle",
        "path": "/users/jon",
        "pets": [
          { "name": "Garfield",
            "species": "Felis silvestris catus",
            "path": "/pets/garfield" },
          { "name": "Odie",
            "species": "Canis lupus familiaris",
            "path: "/pets/odie" }]}]}

The variable `@users` is an array (or an Arel relation), so as you can see,
parameters meant to be used by `ActiveRecord::Base#to_phat` will cascade down
through enumerables.

You can control the inclusion of AR fields and custom methods using `only`,
`also` and `expect`. If you do not wish to include any AR attributes in the
output, use `only: nil`. If you want to include all AR attributes and throw in
some custom method calls, use the `also` keyword.

The `merge` keyword makes it possible to add calculated fields into the output,
this is most useful with generated URL's.

Phat is able to look into all kinds of AR reflections with the `refs` keyword;
they will be represented either as arrays or a single object. All the above
keywords (and `refs` itself) can be applied and will cascade.
