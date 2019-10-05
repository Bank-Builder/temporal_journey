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

import java.time.ZonedDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "jibar", schema = "_jibar")
public class Jibar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private Long id;

    @Column(name = "rate", nullable = false)
    private String rate;

    @Column(name = "valid_from", nullable = false)
    @CreationTimestamp
    private ZonedDateTime validFrom;

    @Column(name = "updated_by", nullable = false)
    private String updatedBy;
}
