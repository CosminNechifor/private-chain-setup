start_nodes() {
    echo "Starting node0 and node1"
    # parity --config ./data/node0.toml &
    parity --config ./data/node0.toml --unlock 0x00bd138abd70e2f00903268f3db08f2d25677c9e,0x004ec07d2329997267ec62b4166639513386f32e --password ./data/node.pwds &
    parity --config ./data/node1.toml --ui-port 8181 --unlock 0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2 --password ./data/node.pwds &
    # parity --config ./data/node1.toml --ui-port 8181 & 

    echo "Waiting for the nodes to start"
    sleep 10
    
    ENODE_NODE0=$( curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 | python -c "import sys, json; print(json.load(sys.stdin)['result'])")
    echo "enode node0:" $ENODE_NODE0

    json_data='{"jsonrpc":"2.0","method":"parity_addReservedPeer","params":["ENODE"],"id":0}'

    json=$(echo $json_data | sed "s-ENODE-$ENODE_NODE0-g")
    echo $json 
    curl --data $json -H "Content-Type: application/json" -X POST localhost:8541
}

echo "starting nodes"
start_nodes
echo "Nodes have been started in the background"
