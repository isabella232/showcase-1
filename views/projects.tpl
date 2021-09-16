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

        // Avoid updating the show_headers when search is in progress.
        let search_lock = false;

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
                "columnDefs": [
                    {"width": "20%", "targets": 0},
                    {"width": "30%", "targets": 1},
                    {"width": "30%", "targets": 2},
                    {"width": "15%", "targets": 3},
                ]
            });

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);

            table.on('order.dt', () => {
                if (!search_lock) {
                    show_headers(false);
                    reset_show(true);
                }
            })

            // handle old JSON encoding of query
            const old_json_matches = decodeURIComponent(window.location.hash)
                .match(/^#{"dropdown":"([^"]*)","input":"([^"]*)"}$/);
            if (old_json_matches !== null)
                update_url(old_json_matches[1], old_json_matches[2]);

            search_for_query(window.location.hash.substr(1));

            // Set the reset button to either dark or light mode, inverted from the color scheme.
            if (window.matchMedia) {
                reset_color(window.matchMedia('(prefers-color-scheme: dark)').matches);
            }
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
                reset_color(e.matches);
            });

            // Set focus on the search input
            $('#search').focus();
        });

        // If visible is true, all headers will be shown.
        // If visible is false, no headers will be shown, and entries with more than
        // one category will be shown only once.
        function show_headers(visible){
            const visible_str = visible ? "table-row" : "none";
            document.documentElement.style.setProperty("--display-headers", visible_str);
        }

        // Sets the dropdown-boxes and the search box given a URL-hash string.
        // If the string is invalid, it will reset it to be empty.
        function search_for_query(str){
            let search = new URLSearchParams(str);
            let dropdown = search.get("dropdown")?.split(" ") ?? [];

            ["work", "categories", "applications", "lab"].forEach(id => {
                let select = $(`#${id}`)[0];
                for (let index = 0; index < select.length; index++){
                    if (dropdown.includes(select.options[index].value) > 0){
                        select.selectedIndex = index;
                    }
                }
            })

            search_set(search.get("input"));
        }

        // Puts the given string in the search box and updates the results
        function search_set(input) {
            $('#search')[0].value = input;
            search_apply();
        }

        // Creates a new search query from the dropdown selections and the search
        // box.
        function search_apply() {
            search_lock = true;
            let categories = $('#categories')[0].value;
            let applications = $('#applications')[0].value;
            let work = $('#work')[0].value;
            let lab = $('#lab')[0].value;
            let search_input = $('#search')[0].value;
            let dropdown = [work, categories, lab, applications]
                .filter((e) => e !== "")
                .join(" ");

            const table = $('#projects').DataTable();
            table.order([21, "asc"], [3, "desc"], [4, "desc"], [0, "asc"], [1, "asc"]).draw();
            table.search(`${dropdown} ${search_input}`).draw();
            update_url(dropdown, search_input);
            // This makes sure that double entries are correctly displayed in the corner
            // case where a text is in the search box and a category is chosen.
            show_headers(search_input === "" || categories !== "");
            reset_show(dropdown !== "" || search_input !== "");
            search_lock = false;
        }

        // Shows or hides the reset button.
        function reset_show(show){
            let reset = $('#reset')[0];
            reset.classList.remove("hidden");
            if (!show){
                reset.classList.add("hidden");
            }
        }

        // Sets the color scheme of the reset button
        function reset_color(light){
            let schemes = ["btn-outline-light", "btn-outline-dark"];
            let reset = $('#reset')[0];
            reset.classList.remove(...schemes);
            reset.classList.add(schemes[light ? 0 : 1])
        }

        // Updates the URL using replaceState, so that it doesn't reload the page
        function update_url(dropdown, input){
            let search = new URLSearchParams();
            if (dropdown !== "") search.set("dropdown", dropdown);
            if (input !== "") search.set("input", input);

            let url = new URL(document.location);
            url.hash = search;
            window.history.replaceState(null, "Search", url);
        }
    </script>
</head>
<body>
<%
trail = [
    ('Factory', '/'),
]

include('breadcrumbs.tpl', trail=trail, here='Showcase')

product_tags = {
    "app": "Application for mobile or desktop",
    "details": "Detailed information on the technology used",
    "demo": "Demonstrator showing off the capabilities",
    "hands-on": "Hands-on training available",
    "pilot": "Real use-case testing application",
    "presentation": "General presentation",
    "technical": "Links to technical information"
}

categories = {
    "Privacy": [0, "Privacy Protection & Cryptography"],
    "Blockchain": [1,"Blockchains & Smart Contracts"],
    "Verification": [2, "Software Verification"],
    "Security": [3, "Device and System Security"],
    "Learning": [4, "Machine Learning"],
    "Other": [5, "Other"],
}

applications = {
    "Finance": "Finance",
    "Health": "Health",
    "Gov": "Government & Humanitarian",
    "Infra": "Critical Infrastructure",
    "Info": "Digital Information",
    "Other": "Other",
}

%>

<div class="contents">
    <div class="page-header">
        <a href="https://c4dt.org">
            <picture>
                <source
                        srcset="/resources/c4dt_logo_dark.png"
                        media="(prefers-color-scheme: dark)">
                <img class="float_left" src="/resources/c4dt_logo.png" style="max-height: 10em; max-width: 10em;">
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
                        onchange="search_apply();">
                    <option selected value="">All projects</option>
                    <option value="project_incubated">C4DT Factory involved</option>
                    <option value="project_active">Updated in last 6 months</option>
                    <option value="product_presentation">Presentation available</option>
                    <option value="product_details">Details available</option>
                    <option value="product_demo">Demo available</option>
                    <option value="product_hands-on">Training available</option>
                    <option value="product_pilot">Pilot available</option>
                    <option value="product_app">App available</option>
                </select>
            </div>

            <div>
                <select id="categories" class="form-select"
                        style="width: 13em;"
                        onchange="search_apply();">
                    <option value="">All pillars</option>
                    % for category_key, [sort, category_value] in categories.items():
                    <option value="category_{{ category_key }}">{{ category_value }}</option>
                    % end
                </select>
            </div>

            <div>
                <select id="applications" class="form-select"
                        style="width: 13em;"
                        onchange="search_apply();">
                    <option value="">All verticals</option>
                    % for application_key, application_value in applications.items():
                        <option value="application_{{ application_key }}">{{ application_value }}</option>
                    % end
                </select>
            </div>

            <div>
                <select id="lab" class="form-select"
                        style="width: 13em;"
                        onchange="search_apply();">
                    <option selected value="">All labs</option>
                    % for lab_id, lab in labs.items():
                        % prof = " ".join(lab['prof']['name'])
                        <option value="{{ lab_id }}">{{ prof }} - {{ lab['name'] }}</option>
                    % end
                </select>
            </div>

            <div class="form-group" style="display: flex; flex-direction: row; align-items: center">
                <label class="sr-only">search:</label>
                <input id="search" class="form-control" oninput="search_apply()">
                <span onclick="search_set('')" class="clear_search">X</span>
            </div>

            <div>
                <button id="reset" type="button" class="btn btn-outline-light hidden"
                    onclick="search_for_query('')">Reset</button>
            </div>

        </div>
        <div class="layout-table">
            <table id="projects" class="display cell-border">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Tags</th>
                    <th>Products</th>
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
                    <th class="extra">Keywords</th>
                </tr>
                </thead>
                <tbody>
                %for category_key, [category_sort, category_value] in categories.items():
                    <tr class="shown_with_headers">
                        <td colspan="24" class="category">{{ category_value }}</td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;" data-order="99">
                            99 - {{ " ".join(list(map(lambda a: "product_" + a, ["presentation", "details", "demo", "hands-on", "pilot", "technical", "app"]))) }}
                        </td>
                        <td style="display: none;" data-order="100"></td>

                        <td></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td>

                        <td></td>
                        <td data-order="{{ category_sort }}">
                            <span style="display: none">category_{{category_key}}
                                project_active project_incubated
                            </span>
                        </td>
                    </tr>
                    <%for lab_id, lab in labs.items():
                        for project_id, project in lab['projects'].items():
                            if not category_key in project.get('categories'):
                                continue
                            end
                            # Only keep the first appearance of an entry if the headers are not shown
                            visibility = ""
                            if project.get('categories').index(category_key) > 0:
                                visibility = "shown_with_headers"
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
                            products = find_project_tabs(project_id)
                            maturity_order = maturity + 0.5 if active else maturity
                            %>
                            <tr class="{{ 'incubated' if incubated else 'not_incubated' }} {{visibility}}">
                                <td class="proj_name"
                                    onclick="window.location='{{project_id}}'"
                                    style="cursor: pointer">
                                    {{ name }}
                                </td>
                                <td onclick="window.location='{{project_id}}'"
                                    style="cursor: pointer">
                                    {{ description }}
                                </td>
                                <td class="dt-center">
                                    % for tag in tags:
                                    <button onclick="javascript:search_set('{{ tag }}')"
                                    class="button">{{ tag }}</button>
                                    % end
                                </td>
                                <td class="dt-center" data-order="{{len(products)}}">
                                    % for product in products:
                                        <span style="display: none">product_{{product}}</span>
                                        <div class="button" style="display: inline-block">
                                            <a href="{{project_id}}/{{product}}">
                                            <img src="../resources/products/icons/{{product}}.png"
                                                 class="dark_invert product" title="{{product_tags[product]}}"/></a>
                                        </div>
                                    % end
                                </td>
                                % maturity_image = {1: 'experimental', 2: 'testing', 3: 'stable'}
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
                                <td data-order="{{category_sort}}">
                                    <span class="hidden">
                                        category_{{category_key}} {{category_value}}
                                        % for application in project.get('applications', []):
                                            application_{{application}}
                                        % end
                                        {{ active_str }}
                                        {{ incubator_str }}
                                    </span>
                                </td>
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
