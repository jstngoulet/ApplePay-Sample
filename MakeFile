documentation: 
	@jazzy \
		--clean \
		--author HyreCar \
		--theme fullwidth \
		--documentation=Docs/*.md \
		--output public/docs \
		--min-acl private \
		--author_url https://hyrecar.com \
	@rm -rf ./build
