import Principal "mo:base/Principal";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";



actor Token {

    Debug.print("Hello");

    let owner : Principal = Principal.fromText("ziwlz-daecn-u2btg-kbi22-5l6it-yjdnc-wewyo-bjpkw-imo6a-spnaz-yae");
    let totalSupply : Nat = 1000000000;
    let symbol : Text = "RDC";

    // Initiating Ledger -> with Principal Amount to the Owner.

    private stable var balanceEntries: [(Principal, Nat)] = [];
    private var balances = HashMap.HashMap<Principal, Nat> (1, Principal.equal, Principal.hash);
    if (balances.size() < 1) {
        balances.put(owner, totalSupply);
        Debug.print("error");
    };

    // Checking Balance.

    public query func balanceOf(who: Principal) : async Nat{
        
        let balance : Nat = switch(balances.get(who)){
            case null 0;
            case (?result) result;
        };
            return balance; 
    };

    // Getting the Symbol 

    public query func getSymbol() : async Text{
        return symbol;
    };

    // faucet PayOut Giveawya

    public shared(msg) func payOut() : async Text {
        // Debug.print(debug_show (msg.caller));

        if(balances.get(msg.caller) == null){
            let amount = 10000;
            let result = await transfer(msg.caller, amount);
            return result;
        } else {
            return "You have already claimed you tokens"
        }
    };


    // Transfer functionality

    public shared(msg) func transfer(to : Principal, amount : Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller); 
        if(fromBalance > amount){
            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);
            
            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success"
        } else {
            return "Insufficent Funds"
        }
    };

    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entries());
    };

     system func postupgrade() {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash );

        if (balances.size() < 1) {
            balances.put(owner, totalSupply);
        }
    };  



};