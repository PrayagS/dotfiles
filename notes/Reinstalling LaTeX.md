# Cleanup process

- `sudo rm -rf /usr/local/texlive/* and rm -rf ~/.texlive*`
- `sudo rm -rf /usr/local/share/texmf`
- `sudo rm -rf /var/lib/texmf`
- `sudo rm -rf /var/lib/texmf`
- `sudo rm -rf /etc/texmf`

# Installation

Download the install script from [TUG](https://www.tug.org/texlive/acquire-netinstall.html) and install all the required TeX packages. Update the PATH variable once that's done.

# Installing additional LaTeX packages using `tlmgr`

- Install ones required by the vsCode LaTeX Workshop extension
  - `tlmgr install chktex`
  - `tlmgr install latexmk`
  - `tlmgr install latexindent`. This one's a bit tricky as it has external perl dependencies. Its usually solved by installing texlive-most package from Arch but that duplicates files on your system (since it again reinstalls the same LaTeX packages you installed beforehand) and a lot of the times, those packages aren't up to date. The solution is to install the perl dependencies yourself.
    - Install [cpanm](https://metacpan.org/pod/App::cpanminus#Installing-to-system-perl)
    - Install the following packages in order (usually installing the first two does the trick)
      - `cpanm Log::Log4perl`
      - `cpanm Log::Dispatch`
      - `cpanm YAML::Tiny`
      - `cpanm File::HomeDir`
      - `cpanm Unicode::GCString`
- Install others which were used to compile my previous docs
  - `tlmgr install cleveref`
  - `tlmgr install relsize`
  - `tlmgr install enumitem`
  - `tlmgr install bm`
  - `tlmgr install footnotebackref`
  - `tlmgr install pagecolor`
  - `tlmgr install csquotes`
  - `tlmgr install mdframed`
  - `tlmgr install zref`
  - `tlmgr install needspace`
  - `tlmgr install titling`
  - `tlmgr install titlesec`
  - `tlmgr install IEEEtran`
  - `tlmgr install eqparbox`
  - `tlmgr install environ`
  - `tlmgr install trimspaces`
  - `tlmgr install dvisvgm`
  - `tlmgr install preprint`
  - `tlmgr install seqsplit`

# TODO

Make this into a script duh
