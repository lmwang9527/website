
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
	R -e "blogdown::install_hugo()" && \
	#git remote add upstream https://github.com/sourcethemes/academic-kickstart.git &&
	git fetch upstream && \
	git merge upstream/master && \
	git submodule update --remote --merge

unbind:
	lsof -wni tcp:4000

serve:
	hugo server --watch
