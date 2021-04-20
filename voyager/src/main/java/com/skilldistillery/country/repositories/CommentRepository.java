package com.skilldistillery.country.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

}
