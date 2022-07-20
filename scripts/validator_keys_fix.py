import json
import os 
from pathlib import Path

home = Path.home()

with open(home / ".near/validator_key.json", "r") as f:
    tokens = json.load(f)
if "private_key" in tokens:
    tokens["secret_key"] = tokens["private_key"]
    del tokens["private_key"]
if "account_id" in tokens:
    near_username = os.getenv("NEAR_USERNAME")
    assert near_username is not None, "can't find NEAR_USERNAME env variable"
    tokens["account_id"] =  "{}.factory.shardnet.near".format(near_username)

with open(home / ".near/validator_key.json", "w+") as f:
    json.dump(tokens, f)
