package com.skilldistillery.country.services;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.entities.Comment;
import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.CommentRepository;
import com.skilldistillery.country.repositories.UserRepository;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentRepository commentRepo;

	@Autowired
	UserRepository userRepo;

	@Override
	public List<Comment> index(String username) {
		return commentRepo.findByUser_Username(username);
	}

	@Override
	public Comment show(String username, int cid) {
		Comment comment = null;

		Optional<Comment> optComment = commentRepo.findById(cid);
		if (optComment.isPresent()) {
			comment = optComment.get();

			if (comment.getUser().getUsername().equals(username)) {
				return comment;
			}
		}
		return null;
	}

	@Override
	public Comment create(String username, Comment comment) {
		if (username != null && comment != null) {
			User user = userRepo.findByUsername(username);
			if (user != null) {
				comment.setUser(user);
				comment = commentRepo.saveAndFlush(comment);
				return comment;
			}
		}
		return null;
	}

	@Override
	public Comment update(String username, int cid, Comment newComment) {

		Comment oldComment = null;

		if (username != null && newComment != null) {

			User user = userRepo.findByUsername(username);

			if (user != null) {

				Optional<Comment> opt = commentRepo.findById(cid);
				if (opt.isPresent()) {
					oldComment = opt.get();
				
				oldComment.setContent(newComment.getContent());
				oldComment.setEnabled(newComment.getEnabled());
				oldComment.setUpdateDate(newComment.getUpdateDate());

				commentRepo.saveAndFlush(oldComment);
				
				return oldComment;
				}
			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int cid) {
		boolean destroyed = false;
		Comment comment = null;

		if (username != null) {
			User user = userRepo.findByUsername(username);

			Optional<Comment> commentOpt = commentRepo.findById(cid);
			if (commentOpt.isPresent())
				comment = commentOpt.get();

			if (user != null && user.getComments().contains(comment)) {
				comment.setEnabled(false);
				commentRepo.save(comment);
				destroyed = true;
			}
		}
		return destroyed;
	}

}
