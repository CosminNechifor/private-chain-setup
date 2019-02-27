# this script assumes that you have at lease version 1.11
# and it must be run inside the directory where the other files are



setup_node1() {
    echo "Starting the configuration of the first node"
    parity --config ./data/node0_setup.toml &
    
    echo "Waiting for the node to start"
    sleep 5 # I paused it for five second just to make sure it has enought time to start on any machine 

    # creating the first account with the address 0x00bd138abd70e2f00903268f3db08f2d25677c9e
    echo "First account is being created"
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node0", "node0"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540

    # creating the user account with the password 0x004ec07d2329997267ec62b4166639513386f32e
    echo "Second account is being created"
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user", "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540
    
    # killing the node which is running on port 8540
    echo "Killing node1"
    fuser -k 8540/tcp
}

setup_node2() {
    
    echo "Starting the configuration of the second node"
    parity --config ./data/node1_setup.toml &
    
    echo "Waiting for the node to start"
    sleep 5 # I paused it for five second just to make sure it has enought time to start on any machine 
    
    # creating the account of the second node with address 0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2 
    echo "Second node account is being created"
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node1", "node1"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541

    # killing the node which is running on port 8541
    fuser -k 8541/tcp
}

# function used to connect the two nodes
build_connection() {
    echo "Starting node0 and node1"
    parity --config ./data/node0.toml &
    parity --config ./data/node1.toml --ui-port 8181 & 

    echo "Waiting for the nodes to start"
    sleep 10
    
    ENODE_NODE0=$( curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 | python -c "import sys, json; print(json.load(sys.stdin)['result'])")
    echo "enode node0:" $ENODE_NODE0

    echo '{"jsonrpc":"2.0","method":"parity_addReservedPeer","params":["$ENODE_NODE0"],"id":0}' 

    curl --data '{"jsonrpc":"2.0","method":"parity_addReservedPeer","params":["$ENODE_NODE0"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541





}

echo "starting setup"

setup_node1
setup_node2
build_connection

echo "setup executed"