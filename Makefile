
USER=ludovic

.PHONY: pull-ubuntu
pull-ubuntu:
	docker pull ubuntu

##
# Parameters:
#  $(1): name
#  $(2): depends_on
define BuildTemplate

.PHONY: build-$(1)
build-$(1): $(1)/Dockerfile $$(if $(2),build-$(2)) pull-ubuntu
	docker build --build-arg CACHEBUST="$$(shell date +'%Y-%m-%d')" -f $$< -t $(1) $(1)

endef

$(eval $(call BuildTemplate,base))

##
# Parameters:
#  $(1): name
#  $(2): depends_on
define DevTemplate

$$(eval $$(call BuildTemplate,$(1),$(2)))

.PHONY: run-$(1)
run-$(1): build-$(1)
	docker run --detach --volume /var/run/docker.sock:/var/run/docker.sock dockerfiles:latest bash -c " \
		docker rm --force $(1) || true; \
		docker run \
			--detach \
			--interactive \
			--tty \
			--privileged \
			--network host \
			--volume /home/$$(USER)/.cache/coursier:/home/$$(USER)/.cache/coursier \
			--volume /home/$$(USER)/.gist:/home/$$(USER)/.gist \
			--volume /home/$$(USER)/.ivy2:/home/$$(USER)/.ivy2 \
			--volume /home/$$(USER)/.m2:/home/$$(USER)/.m2 \
			--volume /home/$$(USER)/.oh-my-zsh:/home/$$(USER)/.oh-my-zsh \
			--volume /home/$$(USER)/.sbt:/home/$$(USER)/.sbt \
			--volume /home/$$(USER)/.ssh:/home/$$(USER)/.ssh \
			--volume /home/$$(USER)/.zsh_history:/home/$$(USER)/.zsh_history \
			--volume /home/$$(USER)/.zshrc:/home/$$(USER)/.zshrc \
			--volume /home/$$(USER)/git:/home/$$(USER)/git \
			--volume /var/run/docker.sock:/var/run/docker.sock \
			--user $$(USER) \
			--workdir /home/$$(USER)/git/$(1) \
			--name $(1) \
			$(1):latest "

.PHONY: build-devenv
build-devenv: build-$(1)

.PHONY: run-devenv
run-devenv: run-$(1)

endef

$(eval $(call DevTemplate,dev,base))
  $(eval $(call DevTemplate,jdk,dev))
    $(eval $(call DevTemplate,blas,jdk))
    $(eval $(call DevTemplate,jmh,jdk))
    $(eval $(call DevTemplate,raytracer,jdk))
    $(eval $(call DevTemplate,spark,jdk))
    $(eval $(call DevTemplate,upmem,jdk))
$(eval $(call DevTemplate,luhenry.github.io,base))
# Must be last as it restarts itself when running `make run-devenv`
$(eval $(call DevTemplate,dockerfiles,base))

##
# Parameters:
#  $(1): name
#  $(2): depends_on
define VMTemplate

$$(eval $$(call BuildTemplate,$(1),$(2)))

.PHONY: run-$(1)
run-$(1): build-$(1)
	docker rm --force $(1) || true
	docker run \
		--detach \
		--privileged \
		--network host \
		--volume /home/$$(USER)/git:/home/$$(USER)/git \
		--user $$(USER) \
		--workdir /home/$$(USER)/git/$(1) \
		--name $(1) \
		$(1):latest

endef

$(eval $(call VMTemplate,win10,base))

##
# Parameters:
#  $(1): name
#  $(2): depends_on
define GitHubTemplate

$$(eval $$(call BuildTemplate,$(1),$(2)))

.PHONY: run-$(1)
run-$(1): build-$(1)
	test -n "$$(ORGANIZATION)" || (echo "ORGANIZATION is not defined" && false)
	test -n "$$(PROJECT)" || (echo "PROJECT is not defined" && false)
	test -n "$$(ACCESS_TOKEN)" || (echo "ACCESS_TOKEN is not defined" && false)
	test -n "$$(CPUSET)" || (echo "CPUSET is not defined" && false)
	docker kill --signal INT $(1)-$$(ORGANIZATION)-$$(PROJECT)-$$(CPUSET) && docker wait $(1)-$$(ORGANIZATION)-$$(PROJECT)-$$(CPUSET) || true
	docker rm --force $(1)-$$(ORGANIZATION)-$$(PROJECT)-$$(CPUSET) || true
	docker run \
		--detach \
		--network host \
		--user gh \
		--cpuset-cpus $$(CPUSET) \
		--env ORGANIZATION=$$(ORGANIZATION) \
		--env PROJECT=$$(PROJECT) \
		--env ACCESS_TOKEN=$$(ACCESS_TOKEN) \
		--name $(1)-$$(ORGANIZATION)-$$(PROJECT)-$$(CPUSET) \
		$(1):latest

gh: run-$(1)

endef

$(eval $(call GitHubTemplate,gh))
