git clone https://github.com/nim-lang/Nim.git ~/.Nim
cd ~/.Nim
git clone --depth 1 https://github.com/nim-lang/csources.git
cd csources
sh build.sh
cd ../
bin/nim c koch
./koch boot -d:release
./koch nimble
./koch tools
