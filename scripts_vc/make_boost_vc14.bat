cd ..
mkdir buildx64
cd buildx64
mkdir vc14
cd vc14
cmake -G "Visual Studio 14 2015 Win64" ../..

cd ../..

mkdir buildx86
cd buildx86
mkdir vc14
cd vc14
cmake -G "Visual Studio 14 2015" ../..

cd ../..

cd scripts_vc
start cmd /k call buildRelease.bat buildx64/vc14
start cmd /k call buildDebug.bat buildx64/vc14
start cmd /k call buildRelease.bat buildx86/vc14
start cmd /k call buildDebug.bat buildx86/vc14

PAUSE