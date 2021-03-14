
dotnet_3.0-sdk: Dockerfile~dotnet_3.0-sdk
	docker build -f Dockerfile~dotnet_3.0-sdk -t microsoft/dotnet:3.0-sdk-dev .

all: dotnet_3.0-sdk
