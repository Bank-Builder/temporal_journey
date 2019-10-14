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

import za.co.temporal.journey.model.Jibar;
import za.co.temporal.journey.model.JibarRespository;

@RestController
@RequestMapping("/jibar-rates")
public class JibarController {

    @Autowired
    private JibarRespository jibarRespository;

    @GetMapping
    @ResponseBody
    public ResponseEntity<List<Jibar>> jibarRates() {
        return new ResponseEntity<>(jibarRespository.findAll(), HttpStatus.OK);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Jibar> findById(@PathVariable("id") Long id) {
        return new ResponseEntity<>(jibarRespository.findById(id).orElseThrow(() -> new JibarNotFoundException(id)), HttpStatus.OK);
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<Jibar> addJibar(@RequestBody Jibar jibar) {
        return new ResponseEntity<>(jibarRespository.save(jibar), HttpStatus.CREATED);
    }

    @PutMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Jibar> saveOrUpdateJibar(@RequestBody Jibar jibar, @PathVariable Long id) {
        Jibar updatedJibar = jibarRespository.findById(id).map(x -> {
            x.setRate(jibar.getRate());
            x.setValidFrom(jibar.getValidFrom());
            x.setUpdatedBy(jibar.getUpdatedBy());
            return jibarRespository.save(x);
        }).orElseGet(() -> {
            jibar.setId(id);
            return jibarRespository.save(jibar);
        });

        return new ResponseEntity<>(updatedJibar, HttpStatus.OK);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteFicaStatus(@PathVariable("id") Long id) {
        jibarRespository.deleteById(id);
    }
}
