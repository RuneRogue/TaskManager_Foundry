# TaskManager Smart Contract

This repository contains a Solidity smart contract for a **Task Manager** that allows multiple users to create, update, complete, and delete their own tasks. Each task is linked to its creator, ensuring only the owner can modify it.  

🔗 **Deployed Smart Contract:** [Blockscout](https://eth-sepolia.blockscout.com/address/0xb7cE37102a7b41e47310cAae054C45014cEF1278)  

## Features

- **Multi-user support**: Each user can have multiple tasks stored securely.  
- **Task management**: Users can create, complete, edit, and delete tasks.  
- **Data persistence**: Tasks are stored in a mapping, ensuring efficient lookup.  
- **Access control**: Only task owners can modify their tasks.  
- **Event emissions**: Smart contract emits events for each action to facilitate tracking.  

## Installation & Setup

1. **Clone the repository**  
   ```sh
   git clone https://github.com/RuneRogue/TaskManager_Foundry.git
   cd TaskManager_Foundry
   ```

2. **Install Foundry** (if not installed)  
   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

3. **Build the smart contract**  
   ```sh
   forge build
   ```

## Running Tests

The repository includes unit tests using Foundry. To run the tests:

```sh
forge test
```

### How Testing Works

The **TaskManagerTest** contract verifies various functionalities of the TaskManager smart contract:

- **Task Creation**: Ensures a user can create a task and retrieve its details.  
- **Task Completion**: Checks if a task can be marked as completed.  
- **Task Editing**: Verifies that only the task owner can update it.  
- **Task Deletion**: Confirms that deleting a task updates the task list correctly.  
- **Access Control**: Ensures that only the task owner can modify or delete their tasks.  

## Deploying the Smart Contract

1. **Set up an Ethereum test network**  
   Use **Sepolia** or **Goerli** with Alchemy/Infura for deployment and get your RPC Url.

2. **Deploy using Foundry**  
   ```sh
   forge script script/TaskManager.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY 
   ```
