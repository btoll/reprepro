```bash
$ vagrant up
```

```config
$ ssh \
    -i .vagrant/machines/default/virtualbox/private_key \
    -o RemoteForward=/run/user/1000/gnupg/S.gpg-agent:/run/user/1000/gnupg/S.gpg-agent \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -p 2222 \
    vagrant@127.0.0.1
```

Import packages:

```bash
$ reprepro --basedir /home/vagrant/base includedeb bullseye "/vagrant/packages/$PACKAGE_DIR/$DEB"
$ reprepro --basedir /home/vagrant/base includedsc bullseye "/vagrant/packages/$PACKAGE_DIR/$DSC"
```

List packages:

```bash
$ reprepro --basedir base list bullseye
$ reprepro --basedir base listfilter bullseye 'Package (== asbits), Version (== 1.0.0)'
```

Remove packages:

```bash
$ reprepro --basedir /home/vagrant/base remove bullseye asbits
$ reprepro --basedir base removefilter bullseye 'Package (== asbits), Version (== 1.0.0)'
```

```bash
No section and no priority for 'asbits', skipping.
```

