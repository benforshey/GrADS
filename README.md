# GrADS on Rocky Linux 8

- Build GrADS: `docker build -t grads .`

## Run GrADS in Batch Mode

- Run GrADS: `docker run -it grads`
- Once you get the container TTY prompt: `grads -bl`

## Run GrADS as a GUI Application

- On MacOS, start XQuartz.
  - The first time you open XQuartz in its settings, "Allow connections from network clients". Quit XQuartz. Start XQuartz.
  - Once per time you start XQuartz, accept localhost connections to your X11 server: `xhost + 127.0.0.1`
  - You probably want to maximize your XQuartz window size.
- Run GrADS: `docker run -e DISPLAY=host.docker.internal:0 -it grads`
- Once you get the container TTY prompt: `grads -l`
