.PHONY: package check starter deploy_key check-git-uncommitted check-git-unpushed

package: starter check-git-uncommitted check-git-unpushed
	@if [ ! -f secrets/autograder_core_deploy_key ] || [ ! -f secrets/deploy_key ]; then\
		echo "Missing deploy keys.";\
		echo "Run: make deploy_key";\
		exit 1;\
	fi
	@echo "=== autograder.zip ==="
	@rm -f autograder.zip
	@zip -j autograder.zip secrets/autograder_core_deploy_key secrets/deploy_key run_autograder setup.sh ssh_config

check:
	@chmod u+x run_autograder
	./run_autograder

starter:
	@echo "[TODO?] update Makefile's starter rule"
	@echo "=== starter.zip ==="
	@rm -f starter.zip
	@zip -j starter.zip starter/*.cpp starter/*.h

deploy_key:
	@mkdir -p secrets
	@if [ -f secrets/deploy_key ]; then \
		echo "[WARN] ./secrets/deploy_key already exists."; \
		echo "       not overwriting."; \
	else \
		ssh-keygen -t ed25519 -C "gradescope deploy key" -f ./deploy_key -N ""; \
		mv ./deploy_key ./secrets/deploy_key; \
	fi
	@if [ ! -f ../autograder-core/secrets/deploy_key ]; then \
		echo "[FATAL] autograder-core deploy key not found."; \
		echo "        it should be in ../autograder-core/secrets/deploy_key"; \
		exit 1; \
	else \
		cp ../autograder-core/secrets/deploy_key ./secrets/autograder_core_deploy_key; \
	fi
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
