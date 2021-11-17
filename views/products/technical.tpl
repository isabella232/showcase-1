<div class="project-details">
    <div>
        <div class="header">Name:</div> {{ project.get('name') }}
    </div>
    <div>
        <div class="header">Description:</div> {{ project.get('description', "") }}
    </div>
    <div>
        <div class="header">Professor &mdash; Lab:</div>
        % prof = lab['prof']
        <a href="mailto:{{ prof['email'] }}">{{ ' '.join(prof['name']) }}</a>
        &mdash;
        <a href="{{ lab['url'] }}">{{ lab['name'] }}</a>
    </div>

    % if 'contacts' in project:
    <div>
        % contacts = project['contacts']
        <div class="header">Contact{{ "s" if len(contacts) > 1 else "" }}:</div>
        % for contact in contacts:
        %   include('contact.tpl', contact=contact)
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

    % if 'doc' in project:
    <div>
        <div class="header">Documentation:</div>
        <a href="{{ project['doc'] }}">{{ project['name'] }} Docs</a>
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
            <li>
                % include('info_item.tpl', info=info)
            </li>
            % end
        </ul>
    </div>
    % end

    <div>
        <%
        active = is_active(project)
        if active is None:
            status = "unknown"
        else:
            status = "active" if active else "inactive"
        end

        date_added = project.get('date_added')
        date_updated = project.get('date_updated', date_added)
        %>

        <div class="header">Project status:</div> {{ status }}
        &mdash;
        entered showcase: {{ date_added.date() }}
        &mdash;
        entry updated: {{ date_updated.date() }}
    </div>

    % incubator = project.get('incubator')
    % if incubator:
    <hr/>
    <div>
        <div class="header">Factory Development:</div>
        {{ incubator['work'] }}
        <ul>
        % for line in incubator.get('products', []):
            <li>{{line['type']}}:
                <a href="{{line['url']}}">{{line['title']}}</a>
            </li>
        % end
        </ul>
    </div>
    <div>
        <div class="header">C4DT Contact:</div>
        % include('contact.tpl', contact=project['c4dt_contact'])
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
        % if 'date_last_commit' in code:
          - last commit: {{ code['date_last_commit'].date()}}
        % end
    </div>
    % end

    <div>
        <div class="header">Code quality:</div>
        {{ maturity_label.get(project.get('maturity', 0)) }}
    </div>

    % if 'type' in project:
    <div>
        <div class="header">Project type:</div>
        {{ ', '.join(map(str, project['type'])) }}
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
        {{ ', '.join(map(str, project['license'])) }}
    </div>
    % end

    % if 'lines_of_code' in project:
    <div>
        <div class="header">Lines of code:</div>
        {{ project['lines_of_code'] }}
    </div>
    % end
</div>
