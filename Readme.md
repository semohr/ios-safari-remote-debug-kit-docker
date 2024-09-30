# Iso debugging on linux using a docker container

A quick and easy way to debug ios apps on linux using the [ios-safari-remote-debug-kit](https://github.com/HimbeersaftLP/ios-safari-remote-debug-kit). 

## Prerequisites
- Docker
- usbmuxd

## Usage
1. Clone the repository
```bash
git clone
```
2. Build the docker image
```bash
docker compose build
```
3. Run the docker container
```bash
docker compose up
```

## Debugging

- Go to Settings->Safari->Advanced->Web Inspector and enable debugging.
- Connect your ios device to your computer.
- Open a browser and navigate to `http://localhost:9322` to open the devtools.


## Troubleshooting

You need to use chrome as the webkit devtools are not supported on firefox.
