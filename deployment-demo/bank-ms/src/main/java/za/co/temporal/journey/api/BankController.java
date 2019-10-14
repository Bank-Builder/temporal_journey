package za.co.temporal.journey.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import za.co.temporal.journey.model.Bank;
import za.co.temporal.journey.model.BankRespository;

@RestController
@RequestMapping("/banks")
public class BankController {

    @Autowired
    private BankRespository bankRespository;

    @GetMapping
    @ResponseBody
    public ResponseEntity<List<Bank>> bankListing() {
        return new ResponseEntity<>(bankRespository.findAll(), HttpStatus.OK);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Bank> findById(@PathVariable("id") Long id) {
        return new ResponseEntity<>(bankRespository.findById(id).orElseThrow(() -> new BankNotFoundException(id)), HttpStatus.OK);
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<Bank> addBank(@RequestBody Bank fica) {
        return new ResponseEntity<>(bankRespository.save(fica), HttpStatus.CREATED);
    }

    @PutMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Bank> updateBank(@RequestBody Bank bank, @PathVariable Long id) {
        Bank updatedBank = bankRespository.findById(id).map(x -> {
            x.setName(bank.getName());
            x.setUniversalBranchCode(bank.getUniversalBranchCode());
            x.setUpdatedBy(bank.getUpdatedBy());
            return bankRespository.save(x);
        }).orElseGet(() -> {
            bank.setId(id);
            return bankRespository.save(bank);
        });

        return new ResponseEntity<>(updatedBank, HttpStatus.OK);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteFicaStatus(@PathVariable("id") Long id) {
        bankRespository.deleteById(id);
    }
}
