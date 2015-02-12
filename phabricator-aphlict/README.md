This is the image for the
[Aphlict](https://secure.phabricator.com/book/phabricator/article/notifications/)
notification server for Phabricator.

In order to use it with the other `fcoelho/phabricator-*` images, you'll have
go through the following steps:

1. Link both `fcoelho/phabricator-phpfpm` and `fcoelho/phabricator-data` to
   this image with the name `aphlict`
2. Enable notifications [using the Web UI](https://scm.afrodite.ifsc.usp.br/config/group/notification/)
