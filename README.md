[![Code Climate](https://codeclimate.com/github/vikram7/rubies/badges/gpa.svg)](https://codeclimate.com/github/vikram7/rubies) [![Coverage Status](https://coveralls.io/repos/github/vikram7/rubies/badge.svg?branch=master)](https://coveralls.io/github/vikram7/rubies?branch=master)

# Rubies

Newcomers to programming would benefit from practicing drills regularly until basic problem solving becomes second nature. This gem is a command line tool that allows users to solve randomly generated small problems.

It currently supports drills surrounding simple and complex data structures.

## Installation

    $ gem install rubies

## Usage

```
rubies
```

After typing `rubies` into your terminal, you will see the Splash screen:

![alt text](http://i.imgur.com/PGvyVEC.png)

After starting, you will see randomly generated data structures for you to work through:

![alt text](http://i.imgur.com/zCHl7Sq.png)

Here, you are being asked to find `865` in the array called `current`, which is located in the 3rd position (or index of `2`). The answer would be the following:

```
[1] rubies(main)> current[2]
=> 865
```

![alt text](http://i.imgur.com/MYH1ynW.png)

Here, you are given a hash called `current` and are being asked to find the right command for `engineer collaborative schemas`. The key associated with that value is `Bergnaum-Pouros`, so the answer would be the following:

```
[1] rubies(main)> current["Bergnaum-Pouros"]
=> enable collaborative schemas
```

![alt text](http://i.imgur.com/DIjspdO.png)

Here, you are given an array with a hash in it, or a compound data structure, and are being asked to find `(106) 777-4274`. This is how you could go about it:

```
[1] rubies(main)> current[0]["Mikel Herman"]["phone"]
=> (106) 777-4274
```

Type `new` to get another data structure or `exit` to quit and see your final score. Try to do 15-20 minutes every day and you will be in great shape!

## Contributing

1. Fork it ( https://github.com/vikram7/rubies/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
