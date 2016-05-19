all: release

release: lib mix.exs
	mix release
	rm -rf ebin
	mkdir -p ebin
	mv rel/*/lib/*/ebin/* ebin/
