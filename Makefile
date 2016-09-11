NAME=jq
VERSION=1.5
ITERATION=1
PREFIX=/usr/bin
LICENSE=MIT
VENDOR="Stephen Dolan"
MAINTAINER="Ryan Parman"
DESCRIPTION="jq is a lightweight and flexible command-line JSON processor."
URL=https://stedolan.github.io/jq/

.PHONY: package
package:
	rm -f jq*
	wget -O jq https://github.com/stedolan/jq/releases/download/jq-$(VERSION)/jq-linux64
	chmod +x jq

	fpm \
		-s dir \
		-t rpm \
		-n $(NAME) \
		-v $(VERSION) \
		-m $(MAINTAINER) \
		--epoch 1 \
		--iteration $(ITERATION) \
		--license $(LICENSE) \
		--vendor $(VENDOR) \
		--prefix $(PREFIX) \
		--url $(URL) \
		--description $(DESCRIPTION) \
		--rpm-defattrfile 0755 \
		--rpm-digest md5 \
		--rpm-compression gzip \
		--rpm-os linux \
		--rpm-auto-add-directories \
		jq \
	;

	mv *.rpm /vagrant/repo
