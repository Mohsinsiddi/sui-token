build:
	sui move build

test:
	sui move test

deploy-devnet:
	sui client publish --gas-budget 200000000

configure-devnet:
	sui client envs && sui client switch --env devnet

request-faucet:
	sui client faucet

check-gas:
	sui client gas