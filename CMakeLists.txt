cmake_minimum_required(VERSION 3.13.0)
project(grpccpp C CXX)
include(FetchContent)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
find_package(absl REQUIRED)

FetchContent_Declare(
  gRPC
  GIT_REPOSITORY https://github.com/grpc/grpc
  GIT_TAG        v1.40.0
)
set(FETCHCONTENT_QUIET OFF)
FetchContent_MakeAvailable(gRPC)