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
            <div class="header">Code quality:</div>
            % maturity_text = {
            %    0: "Not yet assessed",
            %    1: "Low",
            %    2: "Medium",
            %    3: "High",
            % }
            {{ maturity_text.get(project.get('maturity', 0)) }}
        </div>

        <hr/>
        <div>
            <div class="header">Written by:</div>
            <a href="{{ lab['url'] }}">{{ lab['lab_id'] }} &mdash; {{ lab['name'] }}</a>
        </div>

        % if project.get('layman_desc'):
        <hr/>
        <div>
            <div class="header">Layman description:</div>
            <div class="contents">{{ project['layman_desc'] }}</div>
        </div>
        % end

        % if project.get('tech_desc'):
        <hr/>
        <div>
            <div class="header">Technical description:</div>
            <div class="contents">{{ project['tech_desc'] }}</div>
        </div>
        % end

        % if project.get('url'):
        <hr/>
        <div>
            <div class="header">Home page:</div>
            <a href="{{ project['url'] }}">{{ project['name'] }}</a>
        </div>
        % end

        % if project.get('contacts'):
        <hr/>
        <div>
            <div class="header">Contacts:</div>
            <ul>
                % for contact in project['contacts']:
                <li>
                    % include('contact.tpl', contact=contact)
                </li>
                % end
            </ul>
        </div>
        % end

        <%
        import itertools
        for info_type, infos in itertools.groupby(
            sorted(project.get('information', []), key=lambda v: v['type']),
            lambda v: v['type']):
        %>
        <hr/>
        <div>
            <div class="header">{{ info_type }}s:</div>
            <ul>
                % for info in infos:
                <li><a href="{{ info['url'] }}">{{ info['title'] }}</a></li>
                % end
            </ul>
        </div>
        % end

        % if project.get('in_incubator') and project.get('demo'):
        <hr/>
        <div class="header">Demonstrator:</div>
         <a href="{{ project['demo']['url'] }}">{{ project['demo']['title'] }}</a>
        % end

    </div>
</body>
