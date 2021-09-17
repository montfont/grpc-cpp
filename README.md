This is a Docker image that installs GRPC C++ and Abseil (aka absl) onto a Ubuntu machine.

When you build your project from this image, just add absl to your cmake prefix path, e.g. `-DCMAKE_PREFIX_PATH=/build/absl` and then you can add it to your CMakeList `find_package(absl REQUIRED)`
