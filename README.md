This is a Docker image that installs GRPC C++ and Abseil (aka absl) onto a Ubuntu machine.

When you build your project from this image, just add absl to your cmake prefix path, e.g. `-DCMAKE_PREFIX_PATH=/build/absl` and then you can add it to your CMakeList `find_package(absl REQUIRED)`. The reason you have to do this is because Abseil is apparently not supposed to be a shared library.

GRPC is installed as a shared library so you don't need to do anything special. Just find the packages as normal:

```
find_package(Protobuf REQUIRED)
find_package(gRPC CONFIG REQUIRED)
```
