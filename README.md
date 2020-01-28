# dot-test

This is the test codes for my WIP project at Murai Lab.

1. `git clone https://github.com/JJ1LFC/dot-test.git`
2. `sudo apt install -y knot-dnsutils`
3. Put ssh private key as `~/.ssh/endo-key`.
4. Write ssh configs for cpu1 and endo.
5. In endo, write ACL and `sudo service unbound restart`.
6. Start experimentation with `bash dig.sh`. When initial run, ssh fingerprint confirmation is needed.
7. Show result with `bash calc.sh`.
