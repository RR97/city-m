package com.citym.app.repositories;

import com.citym.app.models.Contact;
import org.springframework.data.repository.CrudRepository;

public interface ContactRepository extends CrudRepository<Contact, String> {
    @Override
    void delete(Contact deleted);
}