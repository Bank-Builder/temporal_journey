package za.co.temporal.journey.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BranchRespository extends JpaRepository<Branch, Long> {

}
