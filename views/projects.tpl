<!doctype html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/table.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
    % if selected_lab_id is None:
    <title>C4DT showcase projects</title>
    % else:
    % lab = labs[selected_lab_id]
    <title>C4DT showcase - {{ lab['name'] }}</title>
    % end
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript"
            src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript"
            src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" language="javascript"
            src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.colVis.min.js"></script>
    <script type="text/javascript" language="javascript"
            src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
    <script type="text/javascript" language="javascript"
            src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
    <script type="text/javascript" language="javascript"
            src="https://cdn.datatables.net/plug-ins/1.10.25/features/scrollResize/dataTables.scrollResize.min.js"></script>
    <script type="text/javascript" class="init">

        $(document).ready(function () {

            var table = $('#projects').DataTable({
                "scrollResize": true,
                "scrollY": 100,
                "scrollCollapse": true,
                "paging": false,
                "scrollX": true,
                "dom": "Bfrtip",
                "orderClasses": false,
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
                "order": [[0, "asc"], [23, "desc"], [4, "desc"], [1, "asc"], [2, "asc"]],
                "columnDefs": [
                    {"width": "20%", "targets": 1},
                    {"width": "50%", "targets": 2},
                    {"width": "20%", "targets": 3},
                ]
            });

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);
            set_search('project_incubated');

            // Set focus on the search input
            $('#projects_filter input').focus();
        });

        function set_search(text) {
            let table = $('#projects').DataTable();
            table.search(text).draw();
        }

        function update_search() {
            let categories = $('#categories')[0].value;
            let work = $('#work')[0].value;
            let lab = $('#lab')[0].value;
            let artefacts = $('#artefacts')[0].value;
            let search = [work, categories, lab, artefacts]
                .filter((e) => e !== "")
                .join(" ");
            console.log("search is:", search);
            set_search(search);
        }
    </script>
</head>
<body>
<%
trail = [
    ('Factory', '/'),
]

if selected_lab_id is None:
    here = 'Showcase'
else:
    trail += [
    ('Showcase', '/showcase/'),
    ('Labs', '/showcase/labs/'),
    ]
    here = selected_lab_id
end

include('breadcrumbs.tpl', trail=trail, here=here)
%>

<div class="contents">
    <div class="page-header">
        <a href="https://c4dt.org">
            <picture>
                <source
                        srcset="/resources/c4dt_logo_dark.png"
                        media="(prefers-color-scheme: dark)">
                <img class="float_left" src="/resources/c4dt_logo.png">
            </picture>
        </a>
        <div class="intro">
            % if selected_lab_id is None:
            <h1>C4DT affiliated labs projects</h1>
            <p>
                This page presents all projects from the <a href="/showcase/labs/">labs</a> affiliated to the
                Center for Digital Trust.
                % else:
            <h1>
                Projects of Professor <b>{{ ' '.join(lab['prof']['name']) }}</b>
                <br/>
                <a href="{{ lab['url'] }}">{{ lab['name'] }}</a>
            </h1>
            <h2>Description</h2>
            <p>
                {{! lab['description'] }}
            </p>
            <p>
                % end
                You can filter the projects according to your preferences. Clicking on one of the projects
                will show an in-depth description.
            </p>
            <p>For questions, please contact <a href="mailto:linus.gasser@epfl.ch">Linus Gasser</a></p>

            <div class="color_legend">
                <span class="box active_even"></span>
                <span class="box active_odd"></span>
                Active projects
            </div>
        </div>
    </div>
    <div class="page-table">
        <div class="layout-filter">
            <div>
                <select id="work" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option selected value="project_incubated">C4DT supported</option>
                    <option value="project_active">Active projects</option>
                    <option value="">All projects</option>
                </select>
            </div>

            <div style="position: absolute; left: 15em; top: 0em;">
                <select id="categories" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option value="">All categories</option>
                    % for category_key, [_, category_value] in categories.items():
                    <option value="{{ category_key }}">{{ category_value }}</option>
                    % end
                </select>
            </div>

            <div style="position: absolute; left: 30em; top: 0em;">
                <select id="lab" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option selected value="">All labs</option>
                    % for lab_id, lab in labs.items():
                        % prof = " ".join(lab['prof']['name'])
                        <option value="{{ lab_id }}">{{ prof }} - {{ lab['name'] }}</option>
                    % end
                </select>
            </div>

            <div style="position: absolute; left: 45em; top: 0em;">
                <select id="artefacts" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option selected value="">All artefacts</option>
                    <option value="artefact_presentation">Presentation</option>
                    <option value="artefact_background">Background</option>
                    <option value="artefact_demo">Demo</option>
                    <option value="artefact_hands-on">Hands-on</option>
                    <option value="artefact_pilot">Pilot</option>
                </select>
            </div>
        </div>
        <div class="layout-table">
            <table id="projects" class="display cell-border">
                <thead>
                <tr>
                    <th class="extra">Category</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Tags</th>
                    <th>Maturity</th>

                    <th class="extra">Professor &mdash; Lab</th>
                    <th class="extra">More information</th>
                    <th class="extra">Date added</th>
                    <th class="extra">Date updated</th>
                    <th class="extra">Technical description</th>

                    <th class="extra">Layman description</th>
                    <th class="extra">Language</th>
                    <th class="extra">Type</th>
                    <th class="extra">Source code</th>
                    <th class="extra">Date last commit</th>

                    <th class="extra">LOC</th>
                    <th class="extra">Documentation</th>
                    <th class="extra">License</th>
                    <th class="extra">Papers</th>
                    <th class="extra">Contact</th>

                    <th title="Most recent between date added and date of last commit" class="extra">Date last activity</th>
                    <th class="extra">Active</th>
                    <th class="extra">Incubator</th>
                    <th class="extra">Artefacts</th>
                </tr>
                </thead>
                <tbody>
                %for category_key, [category_sort, category_value] in categories.items():
                    <tr>
                        <td data-order="{{ category_sort }}"></td>
                        <td colspan="4" class="category">{{ category_value }}</td>
                        <td style="display: none;"></td><td style="display: none;"></td><td style="display: none;"></td>

                        <td></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td>

                        <td></td><td>project_active</td><td>project_incubated</td>
                        <td>
                           99 - {{ " ".join(list(map(lambda a: "artefact_" + a, ["presentation", "background", "demo", "hands-on", "pilot", "technical"]))) }}</td>
                    </tr>
                    <%for lab_id, lab in labs.items():
                        if selected_lab_id is None or selected_lab_id == lab_id:
                            for project_id, project in lab['projects'].items():
                                if project.get('category', 'Other') != category_key:
                                    continue
                                end
                                #category_sort, category_value = category_sv

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
                                active_str = "project_active" if active else "inactive"
                                incubator_str = "project_incubated" if project.get('in_incubator') else "no support"
                                artefacts = list(map(lambda a: "artefact_" + a, find_project_tabs(project_id)))
                                %>
                                <tr class="{{ 'active' if active else 'inactive' }}">
                                    <td data-order="{{category_sort}}">{{category_value}}</td>

                                    <td class="proj_name"
                                        onclick="window.location='/incubator/{{project_id}}'"
                                        style="cursor: pointer">
                                        {{ name }}
                                    </td>

                                    <td onclick="window.location='/incubator/{{project_id}}'"
                                        style="cursor: pointer">
                                        {{ description }}
                                    </td>

                                    <td class="dt-center">
                                        % for tag in tags:
                                        <button onclick="javascript:set_search('{{ tag }}')">{{ tag }}</button>
                                        % end
                                    </td>

                                    % maturity_image = {1: 'showcase', 2: 'incubator', 3: 'market'}
                                    <td class="dt-center">
                                        <div style="display:none;">
                                            {{ maturity + 0.5 if active else maturity }}
                                        </div>
                                        <img
                                                src="/resources/maturity_{{ maturity_image.get(maturity, "na") }}.svg"
                                                width="25em"
                                                height="25em"
                                                title="{{ maturity_label.get(maturity, 0) }}"
                                                alt="{{ maturity_label.get(maturity, 0) }}"
                                        >
                                    </td>

                                    <td data-order="{{ ' '.join(reversed(prof['name'])) }}" class="dt-nowrap">
                                        <a href="/showcase/labs/{{ lab_id }}">{{ ' '.join(prof['name']) }} &mdash; {{ lab_id }}</a>
                                    </td>

                                    % if url:
                                    <td class=""><a href="{{ url }}">Home page</a></td>
                                    % else:
                                    <td class=""></td>
                                    % end

                                    <td class="dt-center">{{ date_added.date() }}</td>

                                    <td class="dt-center">{{ date_updated.date() }}</td>

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

                                    <td>{{ active_str }}</td>

                                    <td>{{ incubator_str }}</td>

                                    <td>
                                        {{ len(artefacts) }} - {{ " ".join(artefacts) }}
                                    </td>
                                </tr>
                            % end
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
    </div>
</div>
</body>
