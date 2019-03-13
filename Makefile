documentation: 
	@jazzy \
		--clean \
		--author HyreCar \
		--theme fullwidth \
		--documentation=Docs/*.md \
		--output public/docs \
		--min-acl private \
	@rm -rf ./build
