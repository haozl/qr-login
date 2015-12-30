package com.example.web;

import com.example.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

@Controller
@RequestMapping("/weixin")
public class WeiXinController {

    @Autowired
    SimpMessagingTemplate messagingTemplate;

    @Autowired
    JdbcTemplate jdbcTemplate;

    @RequestMapping(value = "/snapshot", method = RequestMethod.GET)
    public String snapshot(Model model, String destination) {
        model.addAttribute("destination", destination);
        return "snapshot";
    }

    /**
     * generate user access token
     *
     * @param username
     * @return
     */
    @RequestMapping(value = "/snapshot", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE)
    public
    @ResponseBody
    String auth(String username, String destination) {

        String token = UUID.randomUUID().toString();
        jdbcTemplate.update("update users set token=? where username=?", token, username);

        messagingTemplate.convertAndSend("/topic/auth/" + destination, token);
        String ret = String.format("<h2>%s has been authenticated!<h2>", username);
        return ret;
    }

    /**
     * Authenticate user with given token
     *
     * @param token
     * @return
     */
    @RequestMapping(value = "/auth-token")
    public String authWithToken(String token) {
        User user = jdbcTemplate.queryForObject("select * from users where token=?",
                new Object[]{token}, new UserRowMapper());

        //destroy token
        jdbcTemplate.update("update users set token=null where token=?", user.getToken());

        //authenticate user programmatically
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);

        return "redirect:/user";
    }

    private class UserRowMapper implements RowMapper<User> {


        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEnabled(rs.getBoolean("enabled"));
            user.setToken(rs.getString("token"));
            return user;
        }
    }

    @ExceptionHandler(EmptyResultDataAccessException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    private
    @ResponseBody
    String notFound() {
        return "Access denied!";
    }
}
