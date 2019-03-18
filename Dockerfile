FROM ubuntu:14.04

MAINTAINER SuLIngGG "admin@mlapp.cn"

ENV TZ "Asia/Shanghai"
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get -y update \
	&& apt-get install -qqy --no-install-recommends wget curl vim htop git screen sudo nano zsh build-essential ca-certificates asciidoc binutils bzip2 gawk gettext libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils autoconf automake libtool autopoint \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd admin \
	&& mkdir /home/admin \
	&& echo admin:admin | chpasswd \
	&& echo 'admin ALL=(ALL:ALL) ALL' >> /etc/sudoers \
	&& cd /home/admin \
	&& git clone http://github.com/robbyrussell/oh-my-zsh /home/admin/.oh-my-zsh \
	&& cp /home/admin/.oh-my-zsh/templates/zshrc.zsh-template /home/admin/.zshrc \
	&& git clone http://github.com/zsh-users/zsh-syntax-highlighting /home/admin/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
	&& git clone http://github.com/zsh-users/zsh-autosuggestions /home/admin/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
	&& sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' .zshrc \
	&& sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' .zshrc \
	&& chown -R admin:admin /home/admin
