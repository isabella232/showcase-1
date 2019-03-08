<head>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function() {
            $('#labs').DataTable( {
                "paging": false,
                "scrollCollapse": true,
                "scrollY": "60vmin",
            } );
        } );
    </script>
</head>
<body>
    <div align="center">
        <h1>Participating EPFL Laboratories</h1>
        <a href="/lab_projects/">View all projects</a>
        <table id="labs" class="display" style="width:100%">
            <thead>
                <tr>
                    <th>Lab ID</th>
                    <th>Name</th>
                    <th>Professor</th>
                </tr>
            </thead>
            <tbody>
                %for k, v in data['labs'].items():
                <tr>
                    <td><a href="/lab_projects/{{k}}">{{k}}</a></td>
                    <td>{{v['name']}}</td>
                    <td><a href="mailto:{{v['email']}}">{{v['prof']}}</a></td>
                </tr>
                %end
            </tbody>
            <tfoot>
                <tr>
                    <th>Lab ID</th>
                    <th>Name</th>
                    <th>Professor</th>
                </tr>
            </tfoor>
        </table>
    </div>
</body>
