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

import za.co.temporal.journey.model.FicaStatus;
import za.co.temporal.journey.model.FicaStatusRespository;

@RestController
@RequestMapping("/fica/v1")
public class FicaStatusController {

    @Autowired
    private FicaStatusRespository ficaStatusRespository;

    @GetMapping
    @ResponseBody
    public ResponseEntity<List<FicaStatus>> ficaStatusListing() {
        return new ResponseEntity<>(ficaStatusRespository.findAll(), HttpStatus.OK);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<FicaStatus> findById(@PathVariable("id") Long id) {
        return new ResponseEntity<>(ficaStatusRespository.findById(id).orElseThrow(() -> new FicaStatusNotFoundException(id)), HttpStatus.OK);
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<FicaStatus> addFicaStatus(@RequestBody FicaStatus fica) {
        return new ResponseEntity<>(ficaStatusRespository.save(fica), HttpStatus.CREATED);
    }

    @PutMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<FicaStatus> updateFicaStatus(@RequestBody FicaStatus fica, @PathVariable Long id) {
        FicaStatus updatedJibar = ficaStatusRespository.findById(id).map(x -> {
            x.setName(fica.getName());
            x.setStatus(fica.getStatus());
            x.setChangedBy(fica.getChangedBy());
            return ficaStatusRespository.save(x);
        }).orElseGet(() -> {
            fica.setId(id);
            return ficaStatusRespository.save(fica);
        });

        return new ResponseEntity<>(updatedJibar, HttpStatus.OK);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteFicaStatus(@PathVariable("id") Long id) {
        ficaStatusRespository.deleteById(id);
    }
}
