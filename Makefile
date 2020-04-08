REPO      := amancevice/slackbot-chat
RUNTIME   := nodejs12.x
STAGES    := zip dev test
TERRAFORM := latest

.PHONY: default clean clobber $(STAGES)

default: package-lock.json package.zip

.docker:
	mkdir -p $@

.docker/zip: package.json
.docker/dev: .docker/zip
.docker/test: .docker/dev
.docker/%: | .docker
	docker build \
	--build-arg RUNTIME=$(RUNTIME) \
	--build-arg TERRAFORM=$(TERRAFORM) \
	--iidfile $@ \
	--tag $(REPO):$* \
	--target $* \
	.

clean:
	rm -rf .docker

clobber: clean
	docker image ls $(REPO) --quiet | uniq | xargs docker image rm --force

zip: package.zip

$(STAGES): %: .docker/%
