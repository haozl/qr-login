insert into users(username,password,enabled) VALUES ('sa','123',true);
insert into users(username,password,enabled) VALUES ('tom','123',true);
insert into users(username,password,enabled) VALUES ('john','123',true);


insert into user_roles(user_id,role) VALUES (1,'ROLE_USER');
insert into user_roles(user_id,role) VALUES (1,'ROLE_ADMIN');
insert into user_roles(user_id,role) VALUES (2,'ROLE_USER');
