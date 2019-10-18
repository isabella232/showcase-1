<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
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
            <div class="header">Maturity level:</div>
            % maturity_text = {
            %    0: "Not yet assessed",
            %    1: "Showcase",
            %    2: "Incubator",
            %    3: "Market",
            % }
            {{ maturity_text.get(project.get('maturity', 0)) }}
        </div>

        <hr/>
        <div>
            <div class="header">Written by:</div>
            <a href="{{ lab['url'] }}">{{ lab['lab_id'] }} &mdash; {{ lab['name'] }}</a>
        </div>

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

        % if project.get('papers'):
        <hr/>
        <div>
            <div class="header">Papers:</div>
            <ul>
                % for paper in project['papers']:
                <li><a href="{{ paper['url'] }}">{{ paper['title'] }}</a></li>
                % end
            </ul>
        </div>
        % end

        % if project.get('in_incubator') and project.get('demo'):
        <hr/>
        <div class="header">Demonstrator:</div>
         <a href="project['demo']['url']">{{ project['demo']['title'] }}</a>
        % end

    </div>
</body>
