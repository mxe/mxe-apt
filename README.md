# Blank MXE APT to automate deploy

How to use.

  * Dependencies:

    * Install [MXE dependencies](http://mxe.cc/#requirements-debian)
    * Install lua, tsort, fakeroot, dpkg-deb


  * Build MXE:

```
$ git clone https://github.com/mxe/mxe /usr/lib/mxe
$ cd /usr/lib/mxe
$ lua tools/build-pkg.lua &> build-pkg.log
```

  * Deploy:

```
$ git clone https://github.com/starius/mxe-apt ~/mxe-apt
$ cd ~/mxe-apt
$ ./make-apt.sh /usr/lib/mxe
$ cd ~/www
$ ln -s ~/mxe-apt repos
```
