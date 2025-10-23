package br.cefetrj.service;

import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;

import br.cefetrj.model.Editora;
import br.cefetrj.repository.EditoraRepository;

@Service
public class EditoraService {
    protected EditoraRepository repository;

    public EditoraService(EditoraRepository repository) {
        this.repository = repository;
    }

    public Editora save(Editora entity) {
        return repository.save(entity);
    }

    public void update(Editora entity) {
        repository.save(entity);
    }

    public void delete(Integer id) {
        repository.deleteById(id);
    }

    public Optional<Editora> findById(Integer id) {
        return repository.findById(id);
    }

    public List<Editora> findAll() {

        return repository.findAll();
    }

}
