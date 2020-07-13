
.PHONY: build
build:
  ln -s ../lmwang9527.github.io public && \
	R -e 'blogdown::build_site()'

push: build
	git status && \
	git commit -a -m"Updated personal webiste" && \
	git push

publish: build
	cd ../lmwang9527.github.io && \
	git add . && \
	git commit -a -m"Updated personal webiste" && \
	git push

update:
	Rscript -e "blogdown::install_hugo()" && \
	git submodule update --remote --merge

unbind:
	lsof -wni tcp:4000

serve:
	hugo server --watch
