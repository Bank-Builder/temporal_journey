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
package za.co.temporal.journey.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FicaStatusRespository2 extends JpaRepository<FicaStatus2, Long> {

}
