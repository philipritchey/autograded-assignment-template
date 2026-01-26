# find out if student used `using namespace std` anywhere
# TODO(you): change target file(s)
if grep -E "using\s+namespace\s+std" code.cpp; then
  echo "[FAIL] Use of \`using namespace std\` is considered unsafe. 1-point penalty applied." >> DEBUG
  echo "-1" > OUTPUT
else
  echo "[PASS] \`using namespace std\` not found.  good." >> DEBUG
  echo "100" > OUTPUT
fi
