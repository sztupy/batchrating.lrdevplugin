Filename based batch rating plugin for Lightroom
================================================

This is my first try of creating a plugin for Lightroom. This will allow one to
supply a list of filename filters, and the plugin will go through all of the
photos in the catalog where the photo's filename matches the filter. If yes,
it will apply the (color) label to the photo.

For example if you have a catalog with the following filenames:

* IMG_5010
* IMG_5020
* IMG_5030

then setting the topmost box to say "5010 5020", the middle box to "red", then
once pressing "Update" the bottom box will show the logs, and at the end the
first two pictures will have their label set to "red", while the third one not.

Licence
=======

WTFPLv2
