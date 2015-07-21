ENV18=RBENV_VERSION=`rbenv versions --bare | grep "^1\.8" | tail -n 1`
ENV19=RBENV_VERSION=`rbenv versions --bare | grep "^1\.9" | tail -n 1`
ENV22=RBENV_VERSION=`rbenv versions --bare | grep "^2\.2" | tail -n 1`

.PHONY: all install_ruby18 ruby18 install_ruby19 ruby19 install_ruby22 ruby22

all: ruby18 ruby19 ruby22

install: install_ruby18 install_ruby19 install_ruby22

install_ruby18:
	@$(ENV18) bundle

ruby18:
	@echo ruby 1.8
	@$(ENV18) bundle exec rspec

install_ruby19:
	@$(ENV19) bundle

ruby19:
	@echo ruby 1.9
	@$(ENV19) bundle exec rspec

install_ruby22:
	@$(ENV22) bundle

ruby22:
	@echo ruby 2.2
	@$(ENV22) bundle exec rspec
