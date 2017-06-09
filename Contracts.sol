pragma solidity ^0.4.11;

contract PensioenOvereenkomst {
  
    address werkgever;
    address pensioenFonds;
  
    struct Persoon {
        string voornaam;
        string achternaam;
        address account;
    }

    mapping (address => Persoon) deelnemers;

    address eigenaar;
    function PensioenOvereenkomst(address owner) { 
      eigenaar = owner;
    }
    
    function deelname(address deelnemer) {
        deelnemers[deelnemer] = Persoon("x","y",deelnemer);
    }
    
    function isDeelnemer(address deelnemer) returns (bool){
        return deelnemers[deelnemer].account != 0;
    }
    
    function kill() { if (msg.sender == eigenaar) selfdestruct(eigenaar); }
}

contract SamenlevingsContract {
    
    address eigenaar;
    PensioenOvereenkomst po;
    
    mapping (address => address) samenlevers;
  
    function SamenlevingsContract() { 
        eigenaar = msg.sender;
        po = new PensioenOvereenkomst(msg.sender);
    }
    
    function deelname(address deelnemer, address partner) {
        if (po.isDeelnemer(deelnemer)) {
            if (samenlevers[deelnemer] == 0) {
               samenlevers[deelnemer] = partner;
            } else {
                // Er is al een partner
                throw;
            }
        } else {
            // Geen deelnemer
            throw;
        }
    }
    
    function kill() { if (msg.sender == eigenaar) selfdestruct(eigenaar); }
}

contract SamenlevingsOvereenkomst is SamenlevingsContract {
   
    
    function greet() constant returns (string) {
        return "greeting";
    }
}
