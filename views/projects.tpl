<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
            % if selected_lab_id is None:
            <title>C4DT showcase projects</title>
            % else:
            %     lab = labs[selected_lab_id]
            <title>C4DT showcase - {{ lab['name'] }}</title>
            % end
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.colVis.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
    <script type="text/javascript" class="init">

        $(document).ready(function() {

            var table = $('#projects').DataTable( {
                "paging": false,
                "scrollCollapse": true,
                "scrollX": true,
                "scrollY": "80vh",
                "dom": "Bfrtip",
                "buttons": [
                    { text: "Columns", extend: 'colvis' },
                    // 'copy',
                    // 'csv',
                    // 'print',
                    {
                        text: "Clear search",
                        action: function(e, dt, node, config) { set_search(""); }
                    },
                ],
                "order": [[5, "desc"], [19, "desc"], [0, "asc"], [1, "asc"]],
            } );

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);

            // Set focus on the search input
            $('#projects_filter input').focus();
        } );

        function set_search(text) {
            var table = $('#projects').DataTable();
            table.search(text).draw();
        }
    </script>
</head>
<body>
    <%
        trail = [
            ('Factory', 'https://www.c4dt.org/factory/'),
        ]

        if selected_lab_id is None:
            here = 'Showcase'
        else:
            trail += [
                ('Showcase', '/projects/'),
                ('Labs', '/labs/'),
            ]
            here = selected_lab_id
        end

        include('breadcrumbs.tpl', trail=trail, here=here)
    %>

    <img class="float_left" src="/resources/c4dt_logo.png">
    <div class="intro">
        % if selected_lab_id is None:
        <h1>C4DT affiliated labs projects</h1>
        <p>
            This page presents all projects from the <a href="/labs/">labs</a> affiliated to the
            Center for Digital Trust.
        % else:
        <h1>
            Projects of Professor <b>{{ ' '.join(lab['prof']['name']) }}</b>
            <br/>
            <a href="{{ lab['url'] }}">{{ lab['name'] }}</a>
        </h1>
        <p>
        % end
            The <a href="https://c4dt.org">Center for Digital Trust (C4DT)</a>
            is cooperating with industrial partners and labs from the EPFL to
            establish trustworthy digital services. As part of C4DT's mission,
            the <strong>showcase</strong> lists all projects that are being
            worked on in the EPFL labs affiliated with C4DT.
        </p>
        <p>
            This page is part of the C4DT Factory that works on producing
            quality software for our industrial partners to use. The other two
            pages are:
            <ul>
                <li>
                    The <a href="https://incubator.c4dt.org">Incubator</a> with
                    a shortlist of EPFL labs projects that are worked on by the
                    C4DT Factory
                </li>
                <li>
                    Some <a href="https://demo.c4dt.org">Demonstrators</a>
                    available to our partners and that show the EPFL labs'
                    software in a more understandable fashion.
                </li>
            </ul>
        </p>
        <p>For questions, please contact <a href="mailto:linus.gasser@epfl.ch">Linus Gasser</a></p>
    </div>

    <p style="text-align: center;">
        <table id="projects" class="display cell-border" style="width:100%">
            <thead>
                <tr>
                    <!-- The "Professor - Lab" column is displayed only on the "all projects" page -->
                    <th class="{{ '' if selected_lab_id is None else 'extra' }}">Professor &mdash; Lab</th>
                    <th>Name</th>
                    <th class="extra">More information</th>
                    <th class="extra">Date added</th>
                    <th class="extra">Date updated</th>
                    <th>Maturity</th>
                    <th>Description</th>
                    <th class="extra">Technical description</th>
                    <th class="extra">Layman description</th>
                    <th class="extra">Language</th>
                    <th class="extra">Type</th>
                    <th>Source code</th>
                    <th class="extra">Date last commit</th>
                    <th class="extra">LOC</th>
                    <th class="extra">Documentation</th>
                    <th>Tags</th>
                    <th class="extra">License</th>
                    <th class="extra">Papers</th>
                    <th>Contact</th>
                    <th title="Most recent between date added and date of last commit" class="extra">Date last activity</th>
                </tr>
            </thead>
            <tbody>
                % for lab_id, lab in labs.items():
                    % if selected_lab_id is None or selected_lab_id == lab_id:
                        % for project_id, project in lab['projects'].items():
                            <%
                            prof = lab['prof']
                            name = project['name']
                            date_added = project.get('date_added')
                            date_updated = project.get('date_updated', date_added)
                            maturity = project.get('maturity', 0)
                            description = project.get('description', '')
                            tech_desc = project.get('tech_desc', '')
                            layman_desc = project.get('layman_desc', '')
                            language = project.get('language', '')
                            proj_type = ', '.join(map(str, project.get('type', [])))
                            url = project.get('url')
                            code = project.get('code', {})
                            date_last_commit = code.get('date_last_commit', '')
                            loc = project.get('lines_of_code', '')
                            doc = project.get('doc')
                            tags = project.get('tags', [])
                            license = ', '.join(map(str, project.get('license', [])))
                            papers = [
                                info
                                for info in sorted(project.get('information', []), key=lambda v: v['type'])
                                if info['type'] == 'Paper'
                            ]

                            # Use Lab Professor as default contact
                            default_contact = dict(prof, name=' '.join(prof['name']))
                            contacts = project.get('contacts', [default_contact])

                            # Skip projects with a `date_added` in the future.
                            # This allows to schedule the appearance of projects in the showcase.
                            import datetime
                            today = datetime.datetime.now()
                            if date_added > today:
                                continue
                            end

                            active = is_active(project)
                            %>
                            <tr class="{{ 'active' if active else '' }}">
                                <td data-order="{{ ' '.join(reversed(prof['name'])) }}" class="dt-nowrap">
                                    <a href="/projects/{{ lab_id }}">{{ ' '.join(prof['name']) }} &mdash; {{ lab_id }}</a>
                                </td>

                                <td class="proj_name dt-nowrap">
                                    <a href="/project/{{ lab_id }}/{{ project_id }}">{{ name }}</a>
                                </td>

                                % if url:
                                <td class=""><a href="{{ url }}">Home page</a></td>
                                % else:
                                <td class=""></td>
                                % end

                                <td class="dt-center">{{ date_added.date() }}</td>

                                <td class="dt-center">{{ date_updated.date() }}</td>

                                % maturity_image = {1: 'showcase', 2: 'incubator', 3: 'market'}
                                <td data-order="{{ maturity + 0.5 if active else maturity }}" class="dt-center">
                                    <img
                                        src="/resources/maturity_{{ maturity_image.get(maturity, "na") }}.svg"
                                        width="25em"
                                        height="25em"
                                        title="{{ maturity_label.get(maturity, 0) }}"
                                        alt="{{ maturity_label.get(maturity, 0) }}"
                                    >
                                </td>

                                <td>{{ description }}</td>

                                <td>{{ tech_desc }}</td>

                                <td>{{ layman_desc }}</td>

                                <td class="dt-center">{{ language }}</td>

                                <td>{{ proj_type }}</td>

                                % if 'url' in code:
                                <td class="dt-nowrap"><a href="{{ code['url'] }}">{{ code.get('type', '') }}</a></td>
                                % else:
                                <td>{{ code.get('type', '') }}</td>
                                % end

                                <td class="dt-center">{{ date_last_commit.date() if date_last_commit else '' }}</td>

                                <td class="dt-center">{{ loc }}</td>

                                <td class="dt-center">
                                    % if doc:
                                    <a href="{{ doc }}">link</a>
                                    % end
                                </td>

                                <td class="dt-center">
                                    % for tag in tags:
                                    <button onclick="javascript:set_search('{{ tag }}')">{{ tag }}</button>
                                    % end
                                </td>

                                <td class="dt-center">{{ license }}</td>

                                <td>
                                    % include('papers.tpl', papers=papers)
                                </td>

                                <td class="dt-nowrap">
                                    % for contact in contacts:
                                    <div>
                                        % include('contact.tpl', contact=contact)
                                    </div>
                                    % end
                                </td>

                                <td class="dt-center">{{ max(date_added, date_last_commit if date_last_commit else date_added).date() }}</td>
                            </tr>
                        % end
                    % end
                % end
            </tbody>
            <tfoot>
                <tr>
                    <th>Professor &mdash; Lab</th>
                    <th>Name</th>
                    <th>More information</th>
                    <th>Date added</th>
                    <th>Date updated</th>
                    <th>Maturity</th>
                    <th>Description</th>
                    <th>Technical description</th>
                    <th>Layman description</th>
                    <th>Language</th>
                    <th>Type</th>
                    <th>Source code</th>
                    <th>Date last commit</th>
                    <th>LOC</th>
                    <th>Documentation</th>
                    <th>Tags</th>
                    <th>License</th>
                    <th>Papers</th>
                    <th>Contact</th>
                    <th>Date last activity</th>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
