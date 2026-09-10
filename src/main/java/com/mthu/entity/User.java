package com.mthu.entity;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotEmpty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * User entity - dung Lombok de sinh getter/setter/constructor/toString,
 * giam boilerplate code so voi ban cu (viet tay tung getter/setter).
 */
@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(unique = true)
    @NotEmpty(message = "Tên đăng nhập không được rỗng")
    private String username;

    @NotEmpty(message = "Mật khẩu không được rỗng")
    private String password;

    private String email;
    private String fullname;


    private String images;

    private String phone;
    private int roleid;
    
    

    @Column(name = "active")
    private boolean active;

    @Column(name = "otp_code")
    private String otpCode;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "otp_expiry")
    private Date otpExpiry;

    @Column(name = "createdate")
    private Date createDate;

    /** Thoi diem cap nhat profile gan nhat (cot moi bo sung cho chuc nang profile) */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    private Date updatedAt;
}
