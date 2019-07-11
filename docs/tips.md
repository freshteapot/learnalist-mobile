
How to trigger a specific list to be loaded
```flutter
ListTile(
    leading: Icon(Icons.add_box),
    title: Text('View a list via uuid only.'),
    onTap: () {
        Navigator.of(context).pushNamed(ViewListRoute.routePrefix,
            arguments: ViewListRouteArguments(
                '8b19f084-430d-5dc4-a7a1-f404c85a06b1'));
    },
)
```


How to create a list of type v1
```flutter
ListTile(
    leading: Icon(Icons.add_box),
    title: Text('Create a simple list of items (v1).'),
    onTap: () {
        Navigator.of(context).pushNamed('/create/list',
            arguments: CreateListRouteArguments('v1'));
    },
),
```
