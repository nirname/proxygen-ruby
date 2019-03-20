# docker

build:
	docker build -t auth-proxy .

run: build
	docker run -p 80:80 -v $(pwd):/app -it --rm auth-proxy

# local

config: makefile gen services.yml services.conf nginx.conf.erb
	DISCOVERY_PATH=services.yml ./gen routes.yml > /tmp/nginx.conf

start: config
	sudo mkdir -p /var/log/nginx/ && sudo nginx -c "/tmp/nginx.conf" -g "daemon off;"

stop:
	sudo nginx -s stop -c /tmp/nginx.conf

reload: config
	sudo nginx -s reload -c "`pwd`/nginx.conf"

# tests

test: test-yml test-conf gen nginx.conf.erb

test-yml:
	DISCOVERY_PATH=services.yml ./gen routes.yml > /tmp/nginx.conf
	sudo nginx -c "/tmp/nginx.conf" -t

test-conf:
	DISCOVERY_PATH=services.conf ./gen routes.yml > /tmp/nginx.conf
	sudo nginx -c "/tmp/nginx.conf" -t

.PHONY: clean

clean:
	docker images -f 'dangling=true' -q | xargs docker rmi -f
	docker images auth-proxy -q | xargs	docker rmi -f



