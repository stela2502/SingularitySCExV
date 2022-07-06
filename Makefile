sandbox = 'ubuntu_sandbox'
target = 'SCExV_v1.1.sif'
lunarc_path = '/projects/fs1/common/software/SCExV/1.1/'
buildScript = 'BuildScript_v2.txt'
user = `whoami`
all: restart build toLunarc

restart:
ifneq ($(wildcard $(target)),) # file exists ## https://stackoverflow.com/questions/5553352/how-do-i-check-if-file-exists-in-makefile-so-i-can-delete-it
	mv ${target} OLD_${target}
endif
ifneq ($(wildcard $(target)),)
	mv ${sandbox} OLD_${sandbox}
endif
	sudo singularity build --sandbox ${sandbox} ${buildScript} 

build:
	sudo chown -R ${user}:${user} ${sandbox}
	rm -f ${target}
	sudo singularity build ${target} ${sandbox}
toLunarc:
	rsync -I --progress ${target} stefanl@aurora-ls2.lunarc.lu.se:${lunarc_path}
