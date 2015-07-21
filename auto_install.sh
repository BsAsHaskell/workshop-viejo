# basic haskell
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install -y cabal-install-1.22 ghc-7.8.4
cat >> ~/.bashrc <<EOF
export PATH="~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:\$PATH"
EOF
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:$PATH
cabal update
cabal install alex happy

# our app
sudo apt-get install -y zlib1g-dev
cabal sandbox init
cabal install --only-dependencies
