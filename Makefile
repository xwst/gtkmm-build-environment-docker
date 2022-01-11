all:
	docker build -t xwst/gtkmm_build_env .

clean:
	docker rmi  `docker images -f dangling=true -q`
