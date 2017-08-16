build:
	docker build . -t tcow/puppet

run:
	docker run -v${PWD}:/etc/puppetlabs/code/modules/nginx -it tcow/puppet

test: build
	rm -rf ${PWD}/testoutput/*
	docker run -v${PWD}/testoutput:/etc/nginx -v${PWD}:/etc/puppetlabs/code/modules/nginx -it tcow/puppet puppet apply --hiera_config=/etc/puppetlabs/code/modules/nginx/hiera.yaml /etc/puppetlabs/code/modules/nginx/test.pp

lint:
	find . -name '*.pp' | xargs puppet-lint

