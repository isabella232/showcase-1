<!doctype html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/table.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
    <title>C4DT showcase projects</title>
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

        lock_table = false;

        $(document).ready(function () {

            const table = $('#projects').DataTable({
                "scrollResize": true,
                "scrollY": 100,
                "scrollCollapse": true,
                "paging": false,
                "scrollX": true,
                "dom": "Brtip",
                "orderClasses": false,
                "buttons": [
                    {text: "Columns", extend: 'colvis'},
                    // 'copy',
                    // 'csv',
                    // 'print',
                ],
                "order": [[0, "asc"], [4, "desc"], [5, "desc"], [1, "asc"], [2, "asc"]],
                "columnDefs": [
                    {"width": "20%", "targets": 1},
                    {"width": "40%", "targets": 2},
                    {"width": "20%", "targets": 3},
                    {"width": "15%", "targets": 4},
                ]
            });

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);
            update_search()

            table.on('order.dt', () => {
                let rows = document.getElementsByClassName("category_row");
                for (let row = 0; row < rows.length; row++) {
                    rows[row].classList.remove("hidden");
                    if (!lock_table) {
                        rows[row].classList.add("hidden");
                    }
                }
            })

            // Set focus on the search input
            $('#search').focus();
        });

        // called by clicking on a tag
        function search_tag(text) {
            let table = $('#projects').DataTable();
            table.search(text).draw();
            $('#search')[0].value = text;
        }

        function clear_search() {
            $('#search')[0].value = "";
            update_search();
        }

        // called by the dropdown boxes
        function update_search() {
            lock_table = true;
            let categories = $('#categories')[0].value;
            let work = $('#work')[0].value;
            let lab = $('#lab')[0].value;
            let artifacts = $('#artifacts')[0].value;
            let search_input = $('#search')[0].value;
            let search = [work, categories, lab, artifacts, search_input]
                .filter((e) => e !== "")
                .join(" ");
            const table = $('#projects').DataTable();
            table.search(search);
            table.order([0, "asc"], [4, "desc"], [5, "desc"], [1, "asc"], [2, "asc"]).draw();
            lock_table = false;
        }
    </script>
</head>
<body>
<%
trail = [
    ('Factory', '/'),
]

include('breadcrumbs.tpl', trail=trail, here='Showcase')

artifact_tags = {
    "app": "Application for mobile or desktop",
    "background": "Background information on the technology used",
    "demo": "Demonstrator showing off the capabilities",
    "hands-on": "Hands-on training available",
    "pilot": "Real use-case testing application",
    "presentation": "General presentation",
    "technical": "Links to technical information"
}
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
            <h1>C4DT Affiliated Lab Projects</h1>
            <p>
                This page presents all projects from the labs affiliated to the
                Center for Digital Trust.
                You can filter the projects according to your preferences. Clicking on one of the projects
                will show an in-depth description.
            </p>
            <p>For questions, please contact <a href="mailto:linus.gasser@epfl.ch">Linus Gasser</a></p>
        </div>
    </div>
    <div class="page-table">
        <div class="layout-filter">
            <div>
                <select id="work" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option selected value="">All projects</option>
                    <option value="project_incubated">C4DT supported</option>
                    <option value="project_active">Active projects</option>
                </select>
            </div>

            <div>
                <select id="categories" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option value="">All categories</option>
                    % for [category_key, category_value] in categories:
                    <option value="category_{{ category_key }}">{{ category_value }}</option>
                    % end
                </select>
            </div>

            <div>
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

            <div>
                <select id="artifacts" class="form-select"
                        style="width: 13em;"
                        onchange="update_search();">
                    <option selected value="">All artifacts</option>
                    <option value="artifact_presentation">Presentation</option>
                    <option value="artifact_background">Background</option>
                    <option value="artifact_demo">Demo</option>
                    <option value="artifact_hands-on">Hands-on</option>
                    <option value="artifact_pilot">Pilot</option>
                    <option value="artifact_app">App</option>
                </select>
            </div>

            <div>
                search: <input id="search" oninput="update_search()">
                <span onclick="clear_search()" class="clear_search">X</span>
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
                    <th>Artifacts</th>

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
                </tr>
                </thead>
                <tbody>
                %for category_sort, [category_key, category_value] in enumerate(categories):
                    <tr class="category_row">
                        <td data-order="{{ category_sort }}">
                            <span style="display: none">category_{{category_key}}</span>
                        </td>
                        <td colspan="24" class="category">{{ category_value }}</td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;" data-order="99">
                            99 - {{ " ".join(list(map(lambda a: "artifact_" + a, ["presentation", "background", "demo", "hands-on", "pilot", "technical", "app"]))) }}
                        </td>

                        <td style="display: none;" data-order="100"></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td>

                        <td></td><td></td><td>project_active</td><td>project_incubated</td>
                    </tr>
                    <%for lab_id, lab in labs.items():
                        for project_id, project in lab['projects'].items():
                            if project.get('category', 'Other') != category_key:
                                continue
                            end

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
                            incubated = project.get('incubator')
                            incubator_str = "project_incubated" if incubated else "no support"
                            artifacts = find_project_tabs(project_id)
                            maturity_order = maturity + 0.5 if active else maturity
                            %>
                            <tr class="{{ 'incubated' if incubated else 'not_incubated' }}">
                                <td data-order="{{category_sort}}">
                                    category_{{category_key}} {{category_value}}
                                </td>

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
                                    <button onclick="javascript:search_tag('{{ tag }}')"
                                    class="button">{{ tag }}</button>
                                    % end
                                </td>

                                <td class="dt-center" data-order="{{len(artifacts)}}">
                                    % for artifact in artifacts:
                                        <span style="display: none">artifact_{{artifact}}</span>
                                        <div class="button" style="display: inline-block">
                                            <a href="../incubator/{{project_id}}/{{artifact}}">
                                            <img src="../resources/incubator/icons/{{artifact}}.png"
                                                 class="dark_invert artifact" title="{{artifact_tags[artifact]}}"/></a>
                                        </div>
                                    % end
                                </td>

                                % maturity_image = {1: 'showcase', 2: 'incubator', 3: 'market'}
                                <td class="dt-center" data-order="{{ maturity_order }}">
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
                            </tr>
                        % end
                    % end
                % end
                </tbody>
            </table>
        </div>

        <div class="color_legend">
            <span class="box incubated_even"></span>
            <span class="box incubated_odd"></span>
            C4DT supported projects
            <span style="width: 3em;"></span>
            <span class="box not_incubated_even"></span>
            <span class="box not_incubated_odd"></span>
            Lab supported projects
        </div>
    </div>
</div>
</body>
