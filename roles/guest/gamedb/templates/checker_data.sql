CREATE TABLE checkerstate (
    team_net_no INTEGER,
    service_id INTEGER,
    identifier CHARACTER VARYING (128),
    data TEXT,
    PRIMARY KEY (team_net_no, service_id, identifier)
);
