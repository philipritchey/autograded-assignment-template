.PHONY: clean package check starter deploy_key check-git-uncommitted check-git-unpushed

package: clean starter check-git-uncommitted check-git-unpushed
	@if [ ! -f secrets/autograder_core_deploy_key ] || [ ! -f secrets/deploy_key ]; then\
		echo "Missing deploy keys.";\
		echo "Run: make deploy_key";\
		exit 1;\
	fi
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
	@echo "The public key (to add to GitHub) is:"
	@cat ./deploy_key.pub

check-git-uncommitted:
	@if [ -n "$(shell git status --porcelain)" ]; then\
		echo "There are uncommitted changes.";\
		echo "Commit your changes or stash them before continuing.";\
		exit 1;\
	fi

check-git-unpushed:
	@if [ -n "$(shell git log @{u}.. --oneline)" ]; then\
		echo "There are unpushed changes.";\
		echo "Push them before continuing.";\
		exit 1;\
	fi
