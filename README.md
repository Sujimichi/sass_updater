# SassUpdater

Command line tool to update old-style sass syntax to current convention, ie:

`:font-size 1em` becomes `font-size: 1em`
    
Working on an older code base with SASS files that use the old-style properties?   
Keep seeing messages like this when you compile your assets?

    Old-style properties like ":right 1em" are deprecated and will be an error in future versions of Sass.
    
Then whop this gem all up in your rails app and run `update_sass` and it will process your stylesheets and update all those annoying old style properties.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sass_updater', :git => "https://github.com/Sujimichi/sass_updater.git", :require => false
```

And then execute:

    $ bundle install


## Usage

From the command line anywhere in your rails app run

    $ update_sass
    
This will look for all your .sass and .css.sass files. It will first create a backup (.backup) in the same location as the original file and will then update the original file.

### Options

    $ update_sass --display     #just display the changes without altering the original file or making backups
    $ update_sass --no-backup   #skip writing a backup of the original
    
If your styleheets have different extensions to either .sass or .css.sass then you can specifiy extensions

    $ update_sass --extensions .scss .sass
    
If you just want to update a specific file and not let sass_updater automatically search for files to update run

    $ update_sass file <path_to_stylesheet>
    
    
## Development

Got an improvment? fork, fix, rake spec, and send a pull request.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sujimichi/sass_updater

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
