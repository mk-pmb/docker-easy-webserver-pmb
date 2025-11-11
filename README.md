
<!--#echo json="package.json" key="name" underline="=" -->
docker-easy-webserver-pmb
=========================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
A docker image to easily run simple web apps.
<!--/#echo -->


Motivation
----------

I want an easy way to run simple web apps in docker, without having
to care about the webserver stuff. In the past, I could rely on
Python's built-in HTTP server, but now that its `--cgi` option is
no longer supported, I need a better alternative.



### Docker image wishlist

* [ ] Easy to run directly with `docker run …`.
* [ ] Proper GNU utilities. (bash, grep, sed, wget, ps, …)
* [ ] Python 3 with venv support ready to go.
* [ ] Node.js, with sane defaults.
* [ ] Basic Perl 5 support, so I can use ninja oneliners.


### Web server wishlist

* [ ] Nice directory indexes.
* [ ] Support range requests (to resume partial downloads).
* [ ] CGI support
* [ ] WebDAV
* [ ] Basic auth
* [ ] TLS/SSL



Usage
-----

:TODO:




Known issues
------------

* Needs more/better tests and docs.





<!--#toc stop="scan" -->

&nbsp;


License
-------
<!--#echo json="package.json" key="license" -->
ISC
<!--/#echo -->
