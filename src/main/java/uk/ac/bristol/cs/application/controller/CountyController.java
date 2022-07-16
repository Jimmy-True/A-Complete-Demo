package uk.ac.bristol.cs.application.controller;

import java.util.List;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import uk.ac.bristol.cs.application.NoSuchElementException;
import uk.ac.bristol.cs.application.model.County;
import uk.ac.bristol.cs.application.model.ModelClass;
import uk.ac.bristol.cs.application.repository.CountyRepository;

@RestController
public class CountyController {

    private final CountyRepository repository;

    CountyController(CountyRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/api/counties")
    List<County> getAllCounties() {
        return repository.findAll();
    }

    // @GetMapping("/api/county/{id}")
    // County getCountyById(@PathVariable String id) {
    // return repository.findById(id)
    // .orElseThrow(() -> new NoSuchElementException(County.class, id));
    // }

    @GetMapping(path = "/api/county/{id}", produces = "application/json")
    String getCountyById(@PathVariable String id) {
        County c = repository.getWithChildren(id);
        return ModelClass.renderJSON(c, County.class, id);
    }
}
