import Principal "mo:base/Principal";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";


actor Token {
    var owner : Principal = Principal.fromText("ziwlz-daecn-u2btg-kbi22-5l6it-yjdnc-wewyo-bjpkw-imo6a-spnaz-yae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "RDC";

    // Initiating Ledger -> with Principal Amount to the Owner.

    var balances = HashMap.HashMap<Principal, Nat> (1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);


    // Checking Balance.

    public query func balanceOf(who: Principal) : async Nat{
        
        let balance : Nat = switch(balances.get(who)){
            case null 0;
            case (?result) result;
        };
            return balance; 
    }


};