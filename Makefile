.PHONY: clean package check starter deploy_key

package: clean
	@zip -j autograder.zip secrets/autograder_core_deploy_key secrets/deploy_key run_autograder setup.sh ssh_config

clean:
	@rm -f autograder.zip

check:
	@chmod u+x run_autograder
	./run_autograder

starter:
	@echo "[TODO?] update Makefile's starter rule"
	@zip -j starter.zip starter/*.cpp starter/*.h

deploy_key:
	@ssh-keygen -t ed25519 -C "gradescope deploy key" -f ./deploy_key -N ""
	@mkdir -p secrets
	@mv ./deploy_key ./secrets/deploy_key
	@cp ../autograder-core/secrets/deploy_key ./secrets/autograder_core_deploy_key
	@echo "The public key (to add the GitHub) is:"
	@cat ./deploy_key.pub
