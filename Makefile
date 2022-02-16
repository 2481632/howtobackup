install:
	mkdir -p ~/.config/htb
	mkdir -p ~/.local/bin
	cp ./howtobackup.sh ~/.local/bin/howtobackup
	chmod +x ~/.local/bin/howtobackup
	ln -s ~/.local/bin/howtobackup ~/.local/bin/htb

uninstall:
	rm -rf ~/config/htb
	rm -rf ~/.local/bin/howtobackup
	rm -rf ~/.local/bin/htb
