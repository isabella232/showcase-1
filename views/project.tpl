<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
</head>
<body>
    <div align="center">
        <h1>{{ project['name'] }}</h1>
        <h2>{{ project['description'] }}</h2>
    </div>

    <div align="left">
        <div><em>Maturity:</em>{{ project.get('maturity') }}</div>

        <div>
            <em>Written by EPFL laboratory:</em> <a href="{{ lab['url'] }}">{{ lab['lab_id'] }} -- {{ lab['name'] }}</a>
        </div>

        % if 'url' in project:
            <div><a href="{{ project['url'] }}">Home Page</a></div>
        % end

        % if 'tech_desc' in project:
        <div><em>Technical description:</em> {{ project['tech_desc'] }}</div>
        % end

        % if 'contacts' in project:
        <div>
            <em>Contacts:</em>
            <ul>
                % for contact in project['contacts']:
                <li><a href="mailto:{{ contact['email'] }}">{{ contact['name'] }}</a></li>
                % end
            </ul>
        </div>
        % end

        % if 'papers' in project:
        <div>
            <em>Papers:</em>
            <ul>
                % for paper in project['papers']:
                <li><a href="{{ paper['url'] }}">{{ paper['title'] }}</a></li>
                % end
            </ul>
        </div>
        % end

    </div>
</body>
