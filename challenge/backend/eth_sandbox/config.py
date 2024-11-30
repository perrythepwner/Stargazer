# !/usr/bin/env python3
# eth_sandbox/config.py

import os

class Config:
    PUBLIC_IP: str = os.getenv("PUBLIC_IP", "localhost")
    LOCAL_RPC_PORT: int = int(os.getenv("LOCAL_RPC_PORT", 5000))
    PUBLIC_RPC_PORT: int = int(os.getenv("PUBLIC_RPC_PORT", 8888))
    HANDLER_PORT: int = int(os.getenv("HANDLER_PORT", 1338))
    FRONTEND_PORT: int = int(os.getenv("FRONTEND_PORT", 8080))
    ANVIL_LOGFILE: str = "/var/log/ctf/anvil_output.log"
    FLAG: str = os.getenv("FLAG", "HTB{pl4c3h0ld3r}")
    
    ALLOWED_NAMESPACES: list = ["web3", "eth", "net"]
    RECEIPT_POLL_INTERVAL: float = 0.1
    N_ACCOUNTS: int = 2
    N_BOTS: int = 5
    DEPLOYER_BALANCE: int = 1000 # ETH
    PLAYER_BALANCE: int = 500 # ETH
    BOT_BALANCE: int = 1 # ETH
    SETUP_CONTRACT_BALANCE: int = 101 # ETH
