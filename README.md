# autograded-assignment-template
a template repo for an autograded assignment

## Assignment Setup

### use this template

1. click the button to use this template
2. give your repo a descriptive name for your assignment
3. keep the repo private
4. clone your repo into the same directory as your fork of [autograder-core](https://github.com/philipritchey/autograder-core)
   * e.g.
     ```
     user@machine:~/autograders/$ ls
     autograder-core
     hello-world-autograder
     ```

### customize the setup script: `setup.sh`

There are two `TODO(you)`s that you must do:

1. make sure you have deploy keys.
   * the instructions for doing that are in `setup.sh` and in this `README.md` under [make a deploy key](#make-a-deploy-key)
   * :warning: if your editor uses CRLF the deploy keys will not work. Ensure that your document is LF only.
2. set your username and repository for the assignment-specific content
   * change `your_username` to your GitHub username
   * change `repository_for_assignment` to the name of your repo
   * example: if my assignment repo is https://github.com/philipritchey/hello-world-autograder, then
     * `username=philipritchey`
     * `repository=hello-world-autograder`

There is one `TODO?(you)` that you may need to do:

1. install dependencies
   * `valgrind` is used for finding memory errors in c++ programs
   * `num-utils` is used for summarizing coverage of java programs
   * `python3.8` or later is required by `run_tests.py`
   * you can/should add any other dependencies that your tests need

### customize the autograder script: `run_autograder`

There are two  `TODO(you)`s that you must do:

1. define the expected language
   * currently, the following languages are supported:
      * `c++`
      * `java`
2. list the files that the student must submit

There is one `TODO?(you)` that you may need to do:

1. list the files that are provided by the instructor
   * these are files which are needed for testing, but which the student is not responsible for submitting
   * a subset of them may have been given to the students in starter code, but it is not necessary
     * do not assume that files you include here are secret.  it may be possible for a clever student to access them.

### [optional] customize the ssh configuration: `ssh_config`

* you should not need to change anything, but you can if you need to (i.e. you know what you are doing)
* make sure you have created both
  1. `deploy_key` for your assignment-specific repo
  2. `autograder_core_deploy_key` for your fork of the [autograder-core](https://github.com/philipritchey/autograder-core) repo 

### write some tests: `tests/<language>`

the `<language>` must be either `c++` or `java`. i.e. `tests/c++` or `tests/java`.

* test specifications go in file(s) named `X.tests`, e.g. `foo.tests`, `bar.tests`, etc.
  * documentation for writing test specifications is at [/path/to/test_spec_documentation](Test Specification Documentation)
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
    * e.g. like this: `tests/c++/foo.tests` and `tests/c++/bar.tests`.
* i/o test resources go in `io_tests/`
  * each test should be in its own folder with a descriptive name, e.g. `io_tests/example/`
  * each test must have two plaintext files (names are arbitrary):
    1. a file that specifies the input to be provided to the program under test through standard input, e.g. `input.txt`
    2. a file that specifies the expected output that the program under test should print to standard output, e.g. `output.txt`
  * the actual organization of this folder is abritrary since paths are provided in the test specification
    * but, it is to your benefit to keep it well-organized
* script (custom) test resources go in `script_tests/`
  * each test should have a descriptive name, e.g. `side_channel_attack.sh`
  * complex tests (e.g. those which are composed of several files) should be in their own descriptively-named folders
  * the actual organization of this folder is abritrary since paths are provided in the test specification
    * but, it is to your benefit to keep it well-organized
* ⚠️ when running tests, the contents of the `submission`/`solution`, `provided`, and `tests` directories are copied into a directory named `testbox` (along with all other required files, e.g. from the core)
  * only the required/expected files (as specified in `run_autograder`) from `provided` and `submission`/`solution` are copied.
  * then, all the `X.tests` files are concatenated into one file that lives at the root of `testbox`, e.g. `testbox/tests.cpp`
  * paths in your tests should be relative to the root of `testbox`
  * this might confuse your IDE, so don't panic if it says it can't find a reference.  when in doubt, test.

### make a deploy key
`ssh-keygen -t ed25519 -C "gradescope"`

save it as `./deploy_key` with no passphrase

`mv ./deploy_key ./secrets/deploy_key` to move the secret key to the `secrets/` directory

on GitHub, add contents of `./deploy_key.pub` to your assignment-specific repo as a new deploy key

### add autograder-core deploy key

`cp /path/to/autograder_core_deploy_key ./secrets/autograder_deploy_key`

if you don't have one, [get one](https://github.com/philipritchey/autograder-core)!

### prepare upload to gradescope
`make`

creates the file `autograder.zip`

### upload to gradescope
1. create a programming assignment
2. upload `autograder.zip`
3. base image os: Ubuntu
4. base image version: 22.04
5. base image variant: JDK 17
6. update autograder
7. test autograder
8. check settings
   * dates, times
   * submission methods
   * ignored files
   * container specifications
   * timeout
