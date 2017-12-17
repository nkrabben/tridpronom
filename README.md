## TrID to PRONOM
This repository holds tools for translating TrID format signatures into PRONOM format signatures that are compatible with tools like [DROID](https://digital-preservation.github.io/droid/), [Siegried](https://www.itforarchivists.com/siegfried), and [FIDO](http://fido.openpreservation.org/).

### Background
Marco Pontello and the TrID community has created over 9000 file format signatures that might be useful for digital preservation/archives/curation workflows. Marco has also created a tool to help identify signatures based on a set of sample files. Unfortunately, the XML format for TrID signatures cannot be read by PRONOM-based tools. But, with the magic of XSLT, Python, and other tools, we can convert them.

## Usage
On a Mac
```
xsltproc path/to/tridpronom.xslt path/to/a/trid/signature.xml
```