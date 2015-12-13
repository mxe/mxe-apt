# Blank MXE APT to automate deploy

How to use.

1. Build MXE:

```
$ git clone https://github.com/mxe/mxe /usr/lib/mxe
$ cd /usr/lib/mxe
$ lua tools/build-pkg.lua &> build-pkg.log
```

2. Deploy:

```
$ git clone https://github.com/starius/mxe-apt ~/mxe-apt
$ cd ~/mxe-apt
$ ./make-apt.sh /usr/lib/mxe
$ cd ~/www
$ ln -s ~/mxe-apt repos
```
