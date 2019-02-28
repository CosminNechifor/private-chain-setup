# private-chain-setup
This repository is my personal PoA private chain configuration that I use on personal projects

Setup:

1. ``git clone https://github.com/CosminNechifor/private-chain-setup && cd private-chain-setup``
2. ``bash setup.sh``
3. Start the nodes using the following commands:
    - ``parity --config ./data/node0.toml --unlock 0x00bd138abd70e2f00903268f3db08f2d25677c9e,0x004ec07d2329997267ec62b4166639513386f32e --password ./data/node.pwds``
    - ``parity --config ./data/node1.toml --ui-port 8181 --unlock 0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2 --password ./data/node.pwds``
