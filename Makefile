
.PHONY: all test full-test bin

bin:
	mkdir -p bin
	GOBIN=${PWD}/bin go install ./exp/cmd/...
	GOBIN=${PWD}/bin go install ./cmd/...

all: check full-test bin

test:
	go test -cover ./...

full-test: test
	go test -race ./...

check:
	which goimports > /dev/null
	find . -name '*.go' | xargs goimports -d | tee /dev/stderr | wc -l | xargs test 0 -eq
	which golint > /dev/null
	golint ./... | tee /dev/stderr | wc -l | xargs test 0 -eq
