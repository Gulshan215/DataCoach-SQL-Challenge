CREATE table Teams(
team_id int primary key,
team_name  varchar(20) not null,
country varchar(20),
captain_id int );

INSERT INTO Teams (team_id, team_name, country, captain_id)
VALUES (1, 'Cloud9', 'USA', 1),
(2, 'Fnatic', 'Sweden', 2),
(3, 'SK Telecom T1', 'South Korea', 3),
(4, 'Team Liquid', 'USA', 4),
(5, 'G2 Esports', 'Spain', 5);


create table Matches(
match_id int  primary key,
team1_id  int ,
team2_id int,
match_date   date,
winner_id  int,
score_team1  int,
score_team2 int,
FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
FOREIGN KEY (winner_id) REFERENCES Teams(team_id)
);

INSERT INTO Matches (match_id, team1_id, team2_id, match_date, winner_id, score_team1, score_team2)
VALUES (1, 1, 2, '2022-01-01', 1, 16, 14),
(2, 3, 5, '2022-02-01', 3, 14, 9),
(3, 4, 1, '2022-03-01', 1, 17, 13),
(4, 2, 5, '2022-04-01', 5, 13, 12),
(5, 3, 4, '2022-05-01', 3, 16, 10),
(6, 1, 3, '2022-02-01', 3, 13, 17),
(7, 2, 4, '2022-03-01', 2, 12, 9),
(8, 5, 1, '2022-04-01', 1, 11, 15),
(9, 2, 3, '2022-05-01', 3, 9, 10),
(10, 4, 5, '2022-01-01', 4, 13, 10);

create table Players(
player_id  int primary key,
player_name varchar(20) not null,
team_id int ,
role  varchar(50),
salary int,
FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

INSERT INTO Players (player_id, player_name, team_id, role, salary)
VALUES (1, 'Shroud', 1, 'Rifler', 100000),
(2, 'JW', 2, 'AWP', 90000),
(3, 'Faker', 3, 'Mid laner', 120000),
(4, 'Stewie2k', 4, 'Rifler', 95000),
(5, 'Perkz', 5, 'Mid laner', 110000),
(6, 'Castle09', 1, 'AWP', 120000),
(7, 'Pike', 2, 'Mid Laner', 70000),
(8, 'Daron', 3, 'Rifler', 125000),
(9, 'Felix', 4, 'Mid Laner', 95000),
(10, 'Stadz', 5, 'Rifler', 98000),
(11, 'KL34', 1, 'Mid Laner', 83000),
(12, 'ForceZ', 2, 'Rifler', 130000),
(13, 'Joker', 3, 'AWP', 128000),
(14, 'Hari', 4, 'AWP', 90000),
(15, 'Wringer', 5, 'Mid laner', 105000);


select * From Teams;
select * From Players;
select * From Matches;


--1. What are the names of the players whose salary is greater than 100,000?

Select player_name, salary from Players
where salary >100000;

--2. What is the team name of the player with player_id = 3?

select Teams.team_name from Teams
left join Players
on Teams.team_id = Players.team_id
where player_id = 3;

---3. What is the total number of players in each team?

select Teams.team_name ,count(Players.player_name) as Total_Number_player from Teams
inner join Players
on Teams.team_id = Players.team_id
group by Teams.team_name;

---- 4. What is the team name and captain name of the team with team_id = 2?

SELECT Teams.team_name, players.player_name AS captain_name
FROM Teams
INNER JOIN Players ON Teams.captain_id = Players.player_id
WHERE Teams.team_id = 2;

-- 5. What are the player names and their roles in the team with team_id = 1?

SELECT player_name, role from players
where team_id = 1;

--- 6. What are the team names and the number of matches they have won?
select Teams.team_name, count(Matches.winner_id) as matches_won
from Teams 
inner Join Matches
on Teams.team_id = Matches.team1_id
group by Teams.team_name;

--7. What is the average salary of players in the teams with country 'USA'?

select teams.country, avg(players.salary) as Average_salary from teams
inner join players
on teams.team_id = players.team_id
where teams.country = 'USA'
group by teams.country;

---8. Which team won the most matches?

select Teams.team_name, count(Matches.winner_id) as matches_won
from Teams 
inner Join Matches
on Teams.team_id = Matches.team1_id
group by Teams.team_name
order by matches_won desc
limit 1;

-- 9. What are the team names and the number of players in each team whose salary is greater than 100,000?

select teams.team_name, count(players.player_name) as Num_players from teams
inner join players
on Teams.team_id = players.team_id
where players.salary > 100000
group by teams.team_name;

--- 10. What is the date and the score of the match with match_id = 3?

select match_date, score_team1, score_team2 from Matches
where match_id = 3;












