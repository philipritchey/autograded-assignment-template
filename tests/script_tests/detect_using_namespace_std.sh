# find out if student used `using namespace std` anywhere
# TODO(you): list files_to_check
files_to_check=( code.cpp )
for file in "${files_to_check[@]}"; do
    if grep -E "using\s+namespace\s+std" $file; then
      echo "[FAIL] Use of \`using namespace std\` is considered unsafe. 1-point penalty applied." >> DEBUG
      echo "-1" > OUTPUT
      exit 0
    fi
done
echo "[PASS] \`using namespace std\` not found.  good." >> DEBUG
echo "100" > OUTPUT
