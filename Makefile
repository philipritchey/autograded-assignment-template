.PHONY: clean package

package: clean
	@zip -j autograder.zip secrets/autograder_core_deploy_key secrets/deploy_key run_autograder setup.sh ssh_config

clean:
	@rm -f autograder.zip
