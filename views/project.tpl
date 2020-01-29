<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
    <title>{{ project['name'] }} &mdash; {{ lab['lab_id'] }}</title>
</head>
<body>
    <br/>

    <div align="center">
        <a href="/projects/">All projects</a>
    </div>

    <br/>

    <div align="center" class="project-header">
        <h1>{{ project['name'] }}</h1>
        <h2>{{ project.get('description', "") }}</h2>
    </div>

    <br/>

    <div class="project-details">
        <div>
            <div class="header">Lab:</div>
            <a href="mailto:{{ lab['prof']['email'] }}">{{ lab['prof']['name'].replace('_', ' ') }}</a>
            &mdash;
            <a href="{{ lab['url'] }}">{{ lab['name'] }}</a>
        </div>

        % if 'contacts' in project:
        <div>
            <div class="header">Contacts:</div>
            % for contact in project['contacts']:
                % include('contact.tpl', contact=contact)
                &nbsp;
            % end
        </div>
        % end

        % if project.get('in_incubator'):
        <div>
            <div class="header">Factory involvement:</div>
            This project is in the Incubator, which means that the C4DT Factory Team is actively working on it.
        </div>
        <div>
            <div class="header">C4DT Contact:</div>
            % include('contact.tpl', contact=project['c4dt_contact'])
        </div>

            % if project.get('demo'):
            <div class="header">Demonstrator:</div>
             <a href="{{ project['demo']['url'] }}">{{ project['demo']['title'] }}</a>
            % end
        % end

        <hr/>

        <div>
            % import datetime
            % date_added = project.get('added', datetime.date(2019, 1, 1))
            <div class="header">Entry created:</div> {{ date_added }}
        </div>
        <div>
            <div class="header">Entry updated:</div> {{ project.get('updated', date_added) }}
        </div>
        % if 'code' in project and 'last_commit' in project['code']:
        <div>
            <div class="header">Project status :</div>
            % today = datetime.datetime.now().date()
            % last_commit = project['code']['last_commit']
            % if today - last_commit > datetime.timedelta(days=180):
            Inactive
            % else:
            Active
            % end
        </div>
        % end

        <hr/>

        % if 'url' in project:
        <div>
            <div class="header">Home page:</div>
            <a href="{{ project['url'] }}">{{ project['name'] }}</a>
        </div>
        % end

        % if 'layman_desc' in project:
        <div>
            <div class="header">Layman description:</div>
            <div class="contents">{{ project['layman_desc'] }}</div>
        </div>
        % end

        % if 'tech_desc' in project:
        <div>
            <div class="header">Technical description:</div>
            <div class="contents">{{ project['tech_desc'] }}</div>
        </div>
        % end

        <%
        import itertools
        for info_type, infos in itertools.groupby(
            sorted(project.get('information', []), key=lambda v: v['type']),
            lambda v: v['type']):
        %>
        <div>
            <div class="header">{{ info_type }}s:</div>
            <ul>
                % for info in infos:
                <li><a href="{{ info['url'] }}">{{ info['title'] }}</a></li>
                % end
            </ul>
        </div>
        % end

        <hr/>

        % if 'code' in project:
        <div>
            <div class="header">Source code:</div>
            % code = project['code']
            % if 'url' in code:
            <a href="{{ code['url'] }}">{{ code['type'] }}</a>
            % else:
            {{ code.get('type', 'url') }}
            % end
        </div>
        % end

        <div>
            <div class="header">Code quality:</div>
            % maturity_text = {
            %    0: "Not yet assessed",
            %    1: "Prototype",
            %    2: "Intermediate",
            %    3: "Mature",
            % }
            {{ maturity_text.get(project.get('maturity', 0)) }}
        </div>

        % if 'type' in project:
        <div>
            <div class="header">Project type:</div>
            {{ project['type'] }}
        </div>
        % end

        % if 'language' in project:
        <div>
            <div class="header">Programming language:</div>
            {{ project['language'] }}
        </div>
        % end

        % if 'license' in project:
        <div>
            <div class="header">License:</div>
            {{ project['license'] }}
        </div>
        % end

        % if 'lines_of_code' in project:
        <div>
            <div class="header">Lines of code:</div>
            {{ project['lines_of_code'] }}
        </div>
        % end
    </div>
</body>
