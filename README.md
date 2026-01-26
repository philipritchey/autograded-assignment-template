# autograded-assignment-template
a template repo for an autograded assignment

## Assignment Setup

### use this template

1. click the button to use this template
2. give your repo a descriptive name for your assignment
3. keep the repo private
4. clone your repo into the same directory as your fork/clone of [autograder-core](https://github.com/philipritchey/autograder-core)
   * e.g.
     ```
     user@machine:~/autograders/$ ls
     autograder-core
     hello-world-autograder
     ```
5. go ahead and make `run_autograder` executable: `chmod u+x run_autograder`

### customize the setup script: `setup.sh`

There is one `TODO(you)`s that you must do:

1. set your username and repository for the assignment-specific content
   * change `your_username` to your GitHub username
   * change `repository_for_assignment` to the name of your repo
   * example: if my assignment repo is https://github.com/philipritchey/hello-world-autograder, then
     * `username=philipritchey`
     * `repository=hello-world-autograder`

### customize the autograder script: `run_autograder`

There are two  `TODO(you)`s that you must do:

1. define the expected language
   * currently, the following languages are supported:
      * `c++`
      * `java`
      * `python`
2. list the files that the student must submit

There is one `TODO?(you)` that you may need to do:

1. list the files that are provided by the instructor
   * these are files which are needed for testing, but which the student is not responsible for submitting
   * a subset of them may have been given to the students in starter code, but it is not necessary
     * the files you include here are not secret

### customize the Makefile

There is one `TODO?` in `Makefile` that you may need to do:

1. update the `starter` rule
   * by default, the `make starter` will zip `starter/*.cpp` and `starter/*.h` into `starter.zip`
   * if you want to provide other or different files in the starter code, this is the place to specify which files should be included
     * e.g. you might want in include some provided files or some test files

### [optional] customize the ssh configuration: `ssh_config`

* you should not need to change anything, but you can if you need to (i.e. you know what you are doing)

### write some tests

* tests go in the `tests/` directory
* test specifications go in file(s) named `X.tests`, e.g. `foo.tests`, `bar.tests`, etc.
  * documentation for writing test specifications is at [https://github.com/philipritchey/autograder-core/blob/main/documentation/test_specification.md](Test Specification Documentation)
  * the basic format of a test specification looks like this:
    ```c++
    /*
    @name: add small numbers
    @points: 5
    @type: unit
    @target: calculator.cpp
    */
    <test>
    EXPECT_EQ(add(867, 5309), 6176);
    </test>
    ```
  * all files containing test specifications (i.e. `X.tests`) must be in the top level of the directory
    * e.g. like this: `tests/foo.tests`.
* i/o test resources should go in `io_tests/`
  * each test should be in its own folder with a descriptive name, e.g. `io_tests/example/`
  * each test must have two plaintext files (names are arbitrary):
    1. a file that specifies the input to be provided to the program under test through standard input, e.g. `input.txt`
    2. a file that specifies the expected output that the program under test should print to standard output, e.g. `output.txt`
  * the actual organization of this folder is abritrary since paths are provided in the test specification, but it is to your benefit to keep it well-organized
* script (custom) test resources should go in `script_tests/`
  * each test should have a descriptive name, e.g. `side_channel_attack.sh`
  * complex tests (e.g. those which are composed of several files) should be in their own descriptively-named folders
  * the actual organization of this folder is abritrary since paths are provided in the test specification, but it is to your benefit to keep it well-organized
* ⚠️ when running tests, the files to submit are copied from the `submission/` or `solution/`, the provided files are copied from `provided/`, and all files in `tests/` are copied into a directory named `testbox` (along with all other required files from the core)
  * only the required/expected files (as specified in `run_autograder`) from `provided` and `submission`/`solution` are copied.
  * then, all the `X.tests` files are concatenated into one file that lives at the root of `testbox`, e.g. `testbox/tests.cpp`
  * paths in your tests should be relative to the root of `testbox`
  * this might confuse your IDE, so don't panic if it says it can't find a reference.  when in doubt, test.

### test your tests

* you should write your own code to test your tests.
* put your code in `solution/`
  * the `solution/` directory is ignored per `.gitignore`.
* run `./run_autograder`
  * when running tests locally, the autograder detects that it is not on gradescope and will pull the "submitted" code from `solution`.

### make a deploy key
* ensure you already have a fork/clone of [autograder-core](https://github.com/philipritchey/autograder-core) and that there is an autograder-core deploy key at `../autograder-core/secrets/deploy_key`
  * if you don't have one, [get one](https://github.com/philipritchey/autograder-core)!
* run `make deploy_key`
* on GitHub, add the contents of `./deploy_key.pub` (echoed to the terminal when you ran `make deploy_key`) to your assignment-specific repo as a new deploy key

### prepare upload to gradescope
* run `make check` to enure that your solution passes your tests
* run `make` (or `make package`) to create the files `starter.zip` and `autograder.zip`
  * `starter.zip` is the starter code to provide to the students
  * `autograder.zip` is the autograder code to upload to Gradescope

### upload to gradescope
1. create a programming assignment on Gradescope
   * set the name, points, release date, due date, etc.
2. upload `autograder.zip`
3. check base image options:
   * os: Ubuntu
   * version: 22.04
   * variant: Default (or JDK 17, if using Java)
4. click the Update Autograder button
   * wait for the autograder to build
   * if it fails, debug and go to step 2
5. test the autograder
   * submit your solution or the starter code (or both, one after the other)
   * if it behaves badly, debug and go back to step 2
6. check settings
   * double check dates and times
   * submission methods
   * ignored files
     * file names you list here will be ignored (not uploaded from the student submission) by Gradescope
   * container specifications
   * timeout
