INSERT INTO flatpages_flatpage (id, title, content, category_id, ordering, slug)
VALUES (1, '', '<link rel="stylesheet" href="static/game_custom.css"><iframe id="indexframe" src="http://192.168.42.2:80/index_game"></iframe>', NULL, 10, '');

INSERT INTO scoring_gamecontrol (id, start, "end", tick_duration, valid_ticks, current_tick, registration_open, min_net_number, max_net_number)
VALUES (1, '{{ event_start }}', '{{ event_end }}', 60, 15, 0, false, NULL, NULL);

UPDATE scoring_gamecontrol
SET start='{{ event_start }}',
    "end"='{{ event_end }}',
    tick_duration=60,
    valid_ticks=15,
    registration_open=false,
    min_net_number=NULL,
    max_net_number=NULL
WHERE id=1;

{% for s in game_services %}
INSERT INTO scoring_service (id, name, slug)
VALUES ({{ s.id }}, '{{ s.name }}', '{{ s.slug }}');
{% endfor %}

{% for t in teams %}
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined)
VALUES ({{ t.id }}, '{{ t.pass | my_pbkdf2_sha256 }}', NULL, {%
	if 'admin' in t and t.admin %}true{% else %}false{% endif %}, '{{ t.name }}', '', '', '{{ t.email }}', {%
	if 'admin' in t and t.admin %}true{% else %}false{% endif %}, true, now());

{% if 'admin' not in t %}
INSERT INTO registration_team (user_id, informal_email, image, affiliation, country, nop_team)
VALUES ({{ t.id }}, '{{ t.email }}', '', 'team{{ t.id }}', '', {%
	if 'nop' in t and t.nop %}true{% else %}false{% endif %});
{% endif %}

{% endfor %}
