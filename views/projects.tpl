<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/resources/styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
            % if selected_lab_id is None:
            <title>C4DT showcase projects</title>
            % else:
            <title>C4DT showcase - {{ labs[selected_lab_id]['name'] }}</title>
            % end
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.colVis.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
    <script type="text/javascript" class="init">

        $(document).ready(function() {

            // Define a custom ordering
            const order_lastname = (a, b) => {
              return a.match(/_.*?$/)[0].localeCompare(b.match(/_.*?$/));
            }
            $.extend( $.fn.dataTable.ext.type.order, {
              "Professor-asc": (a, b) => {
                return order_lastname(a, b);
              },
              "Professor-desc": (a, b) => {
                return order_lastname(b, a);
              }
            });

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
                "columnDefs": [
                    { targets: [0],
                      type: "Professor",
                      render: (data, type, row) => {
                        if (type === "sort"){
                          return data;
                        } else {
                          return data.replace(/_/g, " ");
                        }
                      }}
                ],
            } );

            // Hide "extra" columns by default
            table.columns(".extra").visible(false);
        } );

        function set_search(text) {
            var table = $('#projects').DataTable();
            table.search(text).draw();
        }
    </script>
</head>
<body>
    <img class="float_left" src="/resources/c4dt_logo.png">
    <div class="intro">
    % if selected_lab_id is None:
    <h1>C4DT affiliated labs projects</h1>
        <p>This page presents all projects from the labs affiliated to the Center for Digital Trust.
    % else:
    <h1>C4DT affiliated lab {{ labs[selected_lab_id]['name'] }} projects</h1>
        <p>This page presents all projects from the {{ labs[selected_lab_id]['name'] }} lab.
    % end
    The <a href="https://c4dt.org">Center for Digital Trust (C4DT)</a> is cooperating with industrial partners
    and labs from the EPFL to establish trustworthy digital services. As part of C4DT's mission, the
    <strong>showcase</strong> lists all projects that are being worked on in the EPFL labs affiliated with
    C4DT.</p>
    <p>This page is part of the C4DT Factory that works on producing quality software for our industrial partners to
    use. The other two pages are:
    <ul>
    <li>The <a href="https://incubator.c4dt.org">Incubator</a> with a shortlist of EPFL labs projects that are worked
    on by the C4DT Factory</li>
    <li>Some <a href="https://demo.c4dt.org">Demonstrators</a> available to our partners and that show the
    EPFL labs' software in a more understandable fashion.</li>
    </ul>
    </p>
    <p>For questions, please contact <a href="mailto:linus.gasser@epfl.ch">Linus Gasser</a></p>
    </div>
    <p style="text-align: center;">
        % if selected_lab_id:
            <a href="/projects/">All projects</a><br><br>
        % end
        <a href="/labs/">List of labs</a></p>

        <table id="projects" class="display cell-border" style="width:100%">
            <thead>
                <tr>
                    <th>Professor</th>
                    <th class="extra">Lab</th>
                    <th>Name</th>
                    <th class="extra">Date added</th>
                    <th class="extra">Date updated</th>
                    <th class="extra">Maturity</th>
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
                </tr>
            </thead>
            <tbody>
                % for lab_id, lab in labs.items():
                    % if selected_lab_id is None or selected_lab_id == lab_id:
                        % for project in lab['projects']:
                            <%
                            prof = lab['prof']
                            name = project['name']
                            date_added = project.get('added', '')
                            date_updated = project.get('updated', '')
                            maturity = project.get('maturity', 0)
                            description = project.get('description', '')
                            tech_desc = project.get('tech_desc', '')
                            layman_desc = project.get('layman_desc', '')
                            language = project.get('language', '')
                            proj_type = project.get('type', '')
                            url = project.get('url')
                            code = project.get('code', {})
                            date_last_commit = code.get('latest', '')
                            loc = project.get('lines_of_code', '')
                            doc = project.get('doc')
                            tags = project.get('tags', [])
                            license = project.get('license', '')
                            papers = project.get('papers', [])
                            contacts = project.get('contacts', [])

                            if maturity == 0:
                                continue
                            end

                            import datetime
                            today = datetime.datetime.now().date()
                            if date_added > today:
                                continue
                            end
                            %>
                            <tr>
                                <td class="dt-nowrap">
                                    <a href="{{ lab['url'] }}">{{ prof['name'] }}</a>
                                </td>
                                <td><a href="/projects/{{ lab_id }}">{{ lab_id }}</a></td>
                                % if url:
                                <td class="proj_name dt-nowrap"><a href="{{ url }}">{{ name }}</a></td>
                                % else:
                                <td class="proj_name dt-nowrap">{{ name }}</td>
                                % end
                                <td>{{ date_added }}</td>
                                <td>{{ date_updated }}</td>
                                % maturity_map = {1: 'showcase', 2: 'incubator', 3: 'market'}
                                <td id="{{ maturity_map.get(maturity) }}">{{ maturity }}</td>
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
                                <td>{{ date_last_commit }}</td>
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
                                    % include('contacts.tpl', contacts=contacts)
                                </td>
                            </tr>
                        % end
                    % end
                % end
            </tbody>
            <tfoot>
                <tr>
                    <th>Professor</th>
                    <th>Lab</th>
                    <th>Name</th>
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
                </tr>
            </tfoot>
        </table>
    </div>
</body>
