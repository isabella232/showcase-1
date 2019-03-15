<!doctype html>
<head>
    <link rel="stylesheet" type="text/css" href="/css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css"/>
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
                "scrollY": "60vmin",
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
    <div align="center">
        % if selected_lab_id is None:
        <h1>All projects</h1>
        % else:
        <h1>{{ labs[selected_lab_id]['name'] }}</h1>
        <a href="/projects/">All projects</a>
        &emsp;
        % end
        <a href="/labs/">List of labs</a>
        <table id="projects" class="display cell-border" style="width:100%">
            <thead>
                <tr>
                    <th>Lab</th>
                    <th>Name</th>
                    <th class="extra">Maturity</th>
                    <th>Description</th>
                    <th class="extra">Technical description</th>
                    <th class="extra">Layman description</th>
                    <th class="extra">Language</th>
                    <th class="extra">Type</th>
                    <th>Source code</th>
                    <th class="extra">LOC</th>
                    <th class="extra">Documentation</th>
                    <th>Tags</th>
                    <th class="extra">License</th>
                    <th class="extra">Paper</th>
                    <th>Contact</th>
                </tr>
            </thead>
            <tbody>
                % for lab_id, lab in labs.items():
                    % if selected_lab_id is None or selected_lab_id == lab_id:
                        % for project in lab['projects']:
                        <tr>
                            <%
                            name = project['name']
                            maturity = project.get('maturity')
                            description = project.get('description', '')
                            tech_desc = project.get('tech_desc', '')
                            layman_desc = project.get('layman_desc', '')
                            language = project.get('language', '')
                            proj_type = project.get('type', '')
                            url = project.get('url')
                            code = project.get('code', {})
                            loc = project.get('lines_of_code', '')
                            doc = project.get('doc')
                            tags = project.get('tags', [])
                            license = project.get('license', '')
                            paper_url = project.get('paper_url')
                            contacts = project.get('contacts', [])
                            %>
                            <td><a href="/projects/{{ lab_id }}">{{ lab_id }}</a></td>
                            % if url:
                            <td class="proj_name dt-nowrap"><a href="{{ url }}">{{ name }}</a></td>
                            % else:
                            <td class="proj_name dt-nowrap">{{ name }}</td>
                            % end
                            % maturity_map = {1: 'showcase', 2: 'incubator', 3: 'market'}
                            <td class="{{ maturity_map.get(maturity) }}"></td>
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
                            <td class="dt-center">
                                % if paper_url:
                                <a href="{{ paper_url }}">link</a>
                                % end
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
                    <th>Lab</th>
                    <th>Name</th>
                    <th>Maturity</th>
                    <th>Description</th>
                    <th>Technical description</th>
                    <th>Layman description</th>
                    <th>Language</th>
                    <th>Type</th>
                    <th>Source code</th>
                    <th>LOC</th>
                    <th>Documentation</th>
                    <th>Tags</th>
                    <th>License</th>
                    <th>Paper</th>
                    <th>Contact</th>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
