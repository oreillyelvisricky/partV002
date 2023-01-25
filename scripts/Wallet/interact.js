const ethers = require("ethers")

const CONTRACT_ARTIFACT_PATH = process.env.WALLET_CONTRACT_ARTIFACT_PATH
const CONTRACT_ADDRESS = process.env.WALLET_CONTRACT_ADDRESS

const TOKEN_CONTRACT_ADDRESS = process.env.TOKEN_CONTRACT_ADDRESS

const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
const METAMASK_PKEY = process.env.METAMASK_PKEY

const provider = new ethers.providers.AlchemyProvider(network="goerli", ALCHEMY_API_KEY)
const signer = new ethers.Wallet(METAMASK_PKEY, provider)
const Contract = require(CONTRACT_ARTIFACT_PATH)
const contract = new ethers.Contract(CONTRACT_ADDRESS, Contract.abi, signer)

async function main() {
  await contract.initTransferRequirements();

  /*
  await contract.setTokenAddress(TOKEN_CONTRACT_ADDRESS)

  const fakeAddr = 0xE1e092a709D86fb9904Df1edADfbcdc826512efd

  await contract.startTransfer(fakeAddr, 1)
  */
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})

contract.on("Receive", (sender, amount, balance) => {
  console.log("EVENT Wallet: Receive")
  console.log("sender: ", sender)
  console.log("amount: ", amount)
  console.log("balance:", balance)
})

contract.on("MintSmartTokensForTokens", () => {
  console.log("EVENT Wallet: MintSmartTokensForTokens")
})

contract.on("StartTransfer", (receiver, amount) => {
  console.log("EVENT Wallet: StartTransfer")
  console.log("receiver:", receiver)
  console.log("amount:", amount)
})

contract.on("StartTransferFrom", (sender, receiver, amount) => {
  console.log("EVENT Wallet: StartTransferFrom")
  console.log("sender:", sender)
  console.log("receiver:", receiver)
  console.log("amount:", amount)
})
