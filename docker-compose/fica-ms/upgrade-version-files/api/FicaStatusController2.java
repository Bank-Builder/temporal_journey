/**
 * *************************************************
 * Copyright Grindrod Bank Limited 2019, All Rights Reserved.
 * **************************************************
 * NOTICE:  All information contained herein is, and remains
 * the property of Grindrod Bank Limited.
 * The intellectual and technical concepts contained
 * herein are proprietary to Grindrod Bank Limited
 * and are protected by trade secret or copyright law.
 * Use, dissemination or reproduction of this information/material
 * is strictly forbidden unless prior written permission is obtained
 * from Grindrod Bank Limited.
 */
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

import za.co.temporal.journey.model.FicaStatus2;
import za.co.temporal.journey.model.FicaStatusRespository2;

@RestController
@RequestMapping("/fica/v2")
public class FicaStatusController2 {

    @Autowired
    private FicaStatusRespository2 ficaStatusRespository;

    @GetMapping
    @ResponseBody
    public ResponseEntity<List<FicaStatus2>> ficaStatusListing() {
        return new ResponseEntity<>(ficaStatusRespository.findAll(), HttpStatus.OK);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<FicaStatus2> findById(@PathVariable("id") Long id) {
        return new ResponseEntity<>(ficaStatusRespository.findById(id).orElseThrow(() -> new FicaStatusNotFoundException(id)), HttpStatus.OK);
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<FicaStatus2> addFicaStatus(@RequestBody FicaStatus2 fica) {
        return new ResponseEntity<>(ficaStatusRespository.save(fica), HttpStatus.CREATED);
    }

    @PutMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<FicaStatus2> updateFicaStatus(@RequestBody FicaStatus2 fica, @PathVariable Long id) {
        FicaStatus2 updatedJibar = ficaStatusRespository.findById(id).map(x -> {
            x.setName(fica.getName());
            x.setStatus(fica.getStatus());
            x.setTitle(fica.getTitle());
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
