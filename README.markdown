# rails-annoying

rails-annoying removes some common, minor annoyances from Rails. It's inspired
by [django-annoying](http://pypi.python.org/pypi/django-annoying), which gets
rid of some annoying stuff virtually every Django app needs but doesn't come
with by default.

rails-annoying:

* Automatically renders 404, 500, and other error pages/HTTP statuses based on
  exceptions like `ActiveRecord::RecordNotFound` (but only for non-local
  requests)

*rails-annoying is not production-ready yet.*

## Contributing to rails-annoying
 
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* If your patch should include tests (and it probably should): please add them
* Please try not to mess with the Rakefile, version, or history (if you really
  *have* to, please isolate to its own commit so I can cherry-pick your commits
  and ignore your Rakefile, etc. changes)

## License

MIT-licensed; you can basically do whatever you want with rails-annoying.
Patches welcome though! See LICENSE.txt more.

Copyright (c) 2011 Matthew Riley MacPherson.
