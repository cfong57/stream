# stream.it - entertainment/filesharing

stream.it aspires to be the first cloud-based music player, allowing people from all over
the world to easily share songs without linking to YouTube or other sites designed for
movies. Why stream a music video and clutter up your temporary internet files cache when
you could just load the audio portion - or better yet, simply the sound itself, such
as .MP3? Sharing music should be just as simple as sharing pictures via Imgur or such.

(note: getting stream.it to work in a live environment would involve resolving some
thorny legal issues and paying for cloud storage space, so the prototype will rely
on YouTube embedded videos for now)

## Setup

To get started, clone this repo and run the following from your terminal:

```
$ bundle
$ rake db:create
$ rake db:migrate
```