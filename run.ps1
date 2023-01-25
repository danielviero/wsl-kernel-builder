mkdir -Force output > $null
docker run -it --rm --name wsl-kernel-builder -v ${PWD}\output:/output wsl-kernel-builder