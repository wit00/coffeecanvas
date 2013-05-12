DIR=$1
if [ -z $1 ]; then
  echo "Usage: $0 directory-to-compile"
  exit 1
fi
coffee -j $DIR/project.js  -c ./coffeeshoplib.coffee $DIR/*.coffee


