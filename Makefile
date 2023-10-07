-include .env

.PHONY: test sadeploy ssdeploy stest


test:; forge test 
stest:; forge test --fork-url $(SR)
sadeploy:; forge script --broadcast  --rpc-url $(AR) --private-key $(AP) Deploy
ssdeploy:; forge script --broadcast  --rpc-url $(SR) --private-key $(SP) --verify --etherscan-api-key SN6I6UVPZ2EYIDYK9SIWNJN2KXBSQX25YU Deploy



