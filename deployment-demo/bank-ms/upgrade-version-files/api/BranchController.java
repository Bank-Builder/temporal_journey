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

import za.co.temporal.journey.model.Branch;
import za.co.temporal.journey.model.BranchRespository;

@RestController
@RequestMapping("/branches")
public class BranchController {

    @Autowired
    private BranchRespository branchRespository;

    @GetMapping
    @ResponseBody
    public ResponseEntity<List<Branch>> branchListing() {
        return new ResponseEntity<>(branchRespository.findAll(), HttpStatus.OK);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Branch> findById(@PathVariable("id") Long id) {
        return new ResponseEntity<>(branchRespository.findById(id).orElseThrow(() -> new BankNotFoundException(id)), HttpStatus.OK);
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<Branch> addBranch(@RequestBody Branch branch) {
        return new ResponseEntity<>(branchRespository.save(branch), HttpStatus.CREATED);
    }

    @PutMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Branch> updateBranch(@RequestBody Branch branch, @PathVariable Long id) {
        Branch updatedBranch = branchRespository.findById(id).map(x -> {
            x.setBankId(branch.getBankId());
            x.setName(branch.getName());
            x.setCode(branch.getCode());
            x.setUpdatedBy(branch.getUpdatedBy());
            return branchRespository.save(x);
        }).orElseGet(() -> {
            branch.setId(id);
            return branchRespository.save(branch);
        });

        return new ResponseEntity<>(updatedBranch, HttpStatus.OK);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteFicaStatus(@PathVariable("id") Long id) {
        branchRespository.deleteById(id);
    }
}
