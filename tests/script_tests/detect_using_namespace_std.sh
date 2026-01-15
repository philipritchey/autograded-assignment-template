# find out if student used `using namespace std` anywhere
# TODO(you): change target file(s)
if grep -E "using\s+namespace\s+std" code.cpp; then
  echo "Use of \`using namespace std\` is considered unsafe. 1-point penalty applied." >> DEBUG
  echo "-1" > OUTPUT
else
  echo "100" > OUTPUT
fi
