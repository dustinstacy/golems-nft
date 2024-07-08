-include .env

.PHONY: all test deploy help anvil 

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account myaccount --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployGolems.s.sol:DeployGolems $(NETWORK_ARGS)

mintFire:
	@forge script script/Interactions.s.sol:MintFireGolemsNFT ${NETWORK_ARGS}

mintWater:
	@forge script script/Interactions.s.sol:MintWaterGolemsNFT ${NETWORK_ARGS}

mintEarth:
	@forge script script/Interactions.s.sol:MintEarthGolemsNFT ${NETWORK_ARGS}

evolveNFT:
	@forge script script/Interactions.s.sol:EvolveNFT ${NETWORK_ARGS}